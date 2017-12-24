nasm -g -f macho64 -o "${1}.o" "${1}.asm"
ld -lc -macosx_version_min 10.13 -lSystem -o "$1" "${1}.o"
./"${1}"
