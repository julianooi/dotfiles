function! neoformat#formatters#templ#enabled() abort
    return ['templ']
endfunction

function! neoformat#formatters#templ#templ() abort
    return {
        \ 'exe': 'templ',
        \ 'args': ['fmt'],
        \ 'stdin': 1
        \ }
endfunction

