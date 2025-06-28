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
use App\Models\UserLevel;
use Illuminate\Support\Facades\Http;
use Tymon\JWTAuth\Facades\JWTAuth;

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
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Username tidak ditemukan.'
            ], 401);
        }

        if (! $user || ! Hash::check($password, $user->password)) {
            return response()->json(['error' => 'Invalid login'], 401);
        }

        // Pakai JWT manual:
        $token = JWTAuth::fromUser($user);

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
                $dosenJson = Http::get('https://ti054d02.agussbn.my.id/api/pegawai-ringkas');
                if ($dosenJson->successful()) {
                    $datadosenJson = json_decode($dosenJson->body(), true);
                    // Coba cocokkan NIP dari user dengan data dosen yang diambil dari API eksternal
                    $dosen = collect($datadosenJson)->firstWhere('nip', $user->nip);

                    if ($dosen) {
                        $userData['nip'] = $user->nip;

                        $kelasDosen = SiapKelasMK::where('id_pegawai', $dosen['id_pegawai'])->first();
                        if ($kelasDosen) {
                            $idUnik = $kelasDosen->id_pegawai;
                            $idKelasMk = $kelasDosen->id_kelas_mk;
                        } else {
                            $idUnik = $idUnik = $dosen['id_pegawai'] ?? null;
                            $idKelasMk = null;
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
                        'message' => 'Gagal mengambil data Dosen/Admin.',
                        'status' => $dosenJson->status()
                    ], $dosenJson->status());
                }
            } catch (\Exception $e) {
                return response()->json([
                    'success' => false,
                    'message' => 'Terjadi kesalahan saat mengakses data Dosen/Admin.',
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
            // 'test' => $idUnikBukanDosen,
            'id_kelas_mk' => $idKelasMk ?? null,
            'user' => $userData
        ]);
    }

    // API Create User
    public function createUser(Request $request)
    {
        $validateData = $request->validate([
            'nip' => 'required|string|max:255',
            'nim' => 'nullable|string|max:255',
            'level' => 'required|exists:user_level,id_level',
            'email' => 'nullable|email|max:255',
            'no_telp' => 'nullable|string|max:15',
            'password' => 'required|string',
        ]);

        // Create new user
        $user = User::create($validateData);

        if ($user) {
            return response()->json([
                'success' => true,
                'message' => 'User berhasil dibuat.',
                'user' => $user
            ], 201); // Created
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Gagal membuat user.'
            ], 500); // Internal Server Error
        }
    }

    // API Update User
    public function updateUser(Request $request, $id)
    {
        $validateData = $request->validate([
            'nip' => 'nullable|string|max:255,' . $id,
            'nim' => 'nullable|string|max:255,' . $id,
            'level' => 'nullable|exists:user_level,id_level',
            'email' => 'nullable|email|max:255,' . $id,
            'no_telp' => 'nullable|string|max:15',
            'password' => 'nullable|string',
        ]);

        // Find user by ID
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ditemukan.'
            ], 404); // Not Found
        }

        // Update user data
        $user->update($validateData);

        return response()->json([
            'success' => true,
            'message' => 'User berhasil diperbarui.',
            'user' => $user
        ]);
    }

    // Menampilkan data Level(role)
    public function indexLevel()
    {
        $level = UserLevel::all();
        try {
            if ($level->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Data level tidak ditemukan.'
                ], 404); // Not Found
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat mengambil data level.',
                'error' => $e->getMessage()
            ], 500); // Internal Server Error
        }

        return response()->json([
            'success' => true,
            'message' => 'Data level berhasil diambil.',
            'data' => $level
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
