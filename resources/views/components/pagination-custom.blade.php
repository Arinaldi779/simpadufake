@if ($paginator->hasPages())
    <div class="pagination">
        <span>
            Showing {{ $paginator->firstItem() }} to {{ $paginator->lastItem() }} of {{ $paginator->total() }} results
        </span>

        <div class="page-buttons">
            {{-- Tombol Sebelumnya --}}
            @if ($paginator->onFirstPage())
                <button disabled>&lt;</button>
            @else
                <button onclick="window.location='{{ $paginator->previousPageUrl() }}'">&lt;</button>
            @endif

            {{-- Nomor Halaman --}}
            @foreach ($elements as $element)
                @if (is_string($element))
                    <button disabled>{{ $element }}</button>
                @endif

                @if (is_array($element))
                    @foreach ($element as $page => $url)
                        @if ($page == $paginator->currentPage())
                            <button class="current">{{ $page }}</button>
                        @else
                            <button onclick="window.location='{{ $url }}'">{{ $page }}</button>
                        @endif
                    @endforeach
                @endif
            @endforeach

            {{-- Tombol Selanjutnya --}}
            @if ($paginator->hasMorePages())
                <button onclick="window.location='{{ $paginator->nextPageUrl() }}'">&gt;</button>
            @else
                <button disabled>&gt;</button>
            @endif
        </div>
    </div>
@endif
