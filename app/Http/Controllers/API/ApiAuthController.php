<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Http\Request;
use Laravel\Sanctum\PersonalAccessToken;
use App\Models\SiapKelasMaster; // Jika perlu, sesuaikan dengan model yang digunakan
use App\Models\SiapKelasMK;
use Illuminate\Support\Facades\Http;

class ApiAuthController extends Controller
{
    // API Login
    public function login(Request $request)
    {
        // Validasi request
        $request->validate([
            'username' => 'required',
            'password' => 'required',
        ]);

        // Ambil data dari request
        $login = $request->username;
        $password = $request->password;

        // Cari user berdasarkan nip, nim, atau email
        $user = User::where('nip', $login)
            ->orWhere('nim', $login)
            ->orWhere('email', $login)
            ->first();

        // Cek apakah user tidak ditemukan atau password salah
        if (!$user || !Hash::check($password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Username atau Password salah.'
            ], 401); // Unauthorized
        }

        // Login menggunakan Sanctum untuk menghasilkan token
        $token = $user->createToken('API Token')->plainTextToken;

        // Siapkan data dasar user
        $userData = [
            'id_user' => $user->id_user,
            'email' => $user->email,
            'role' => $user->userLevel->nama_level,
        ];

        $idUnik = null;

        // Jika user adalah pegawai (nip tidak null)
        if (!is_null($user->nip)) {
            try {
                $dosenJson = Http::get('https://d649-2001-448a-60c0-1829-b591-4f36-e8c4-dd73.ngrok-free.app/api/pegawai-ringkas');
                if ($dosenJson->successful()) {
                    $datadosenJson = json_decode($dosenJson->body(), true);
                    $dosen = collect($datadosenJson)->firstWhere('nip', $user->nip);

                    if ($dosen) {
                        $userData['nip'] = $user->nip;

                        $kelasDosen = SiapKelasMK::where('id_pegawai', $dosen['id_pegawai'])->first();
                        if ($kelasDosen) {
                            $idUnik = $kelasDosen->id_pegawai;
                            $idKelasMk = $kelasDosen->id_kelas_mk;
                        } else {
                            return response()->json([
                                'success' => false,
                                'message' => 'Data kelas dosen tidak ditemukan.'
                            ], 404);
                        }
                    } else {
                        return response()->json([
                            'success' => false,
                            'message' => 'Dosen tidak ditemukan dalam data API eksternal.'
                        ], 404);
                    }
                } else {
                    return response()->json([
                        'success' => false,
                        'message' => 'Gagal mengambil data mahasiswa.',
                        'status' => $dosenJson->status()
                    ], $dosenJson->status());
                }
            } catch (\Exception $e) {
                return response()->json([
                    'success' => false,
                    'message' => 'Terjadi kesalahan saat mengakses data mahasiswa.',
                    'error' => $e->getMessage()
                ], 500);
            }
            // $userData['nip'] = $user->nip;
            // $userData['id_kelas_mk'] = SiapKelasMK::where('id_pegawai', $user->id_user)->pluck('id_kelas_mk')->toArray();
        }

        // Jika user adalah mahasiswa (nim tidak null)
        elseif (!is_null($user->nim)) {
            try {
                $mhsJson = Http::get('https://ti054d03.agussbn.my.id/api/mahasiswa/list_mahasiswa');

                if ($mhsJson->successful()) {
                    $dataMhsJson = json_decode($mhsJson->body(), true);
                    $mhs = collect($dataMhsJson)->firstWhere('nim', $user->nim);

                    if ($mhs) {
                        $userData['nim'] = $user->nim;

                        $kelas = SiapKelasMaster::where('nim', $mhs['nim'])->first();
                        if ($kelas) {
                            $idUnik = $kelas->id_kelas_master;
                        } else {
                            return response()->json([
                                'success' => false,
                                'message' => 'Data kelas mahasiswa tidak ditemukan.'
                            ], 404);
                        }
                    } else {
                        return response()->json([
                            'success' => false,
                            'message' => 'Mahasiswa tidak ditemukan dalam data API eksternal.'
                        ], 404);
                    }
                } else {
                    return response()->json([
                        'success' => false,
                        'message' => 'Gagal mengambil data mahasiswa.',
                        'status' => $mhsJson->status()
                    ], $mhsJson->status());
                }
            } catch (\Exception $e) {
                return response()->json([
                    'success' => false,
                    'message' => 'Terjadi kesalahan saat mengakses data mahasiswa.',
                    'error' => $e->getMessage()
                ], 500);
            }
        }

        // Respons akhir sukses
        return response()->json([
            'success' => true,
            'message' => 'Login berhasil.',
            'token' => $token,
            'id_unik' => $idUnik,
            'id_kelas_mk' => $idKelasMk ?? null,
            'user' => $userData
        ]);
    }



    // API Logout

    public function logout(Request $request)
    {
        $accessToken = $request->bearerToken();

        if ($accessToken) {
            $token = PersonalAccessToken::findToken($accessToken);
            if ($token) {
                $token->delete();
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Logout berhasil.'
        ]);
    }
}
