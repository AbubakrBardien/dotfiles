{
    pkgs ? import (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/02c087f3fe673c9e317f206a627cb6b910336dbe.tar.gz";
        sha256 = "1l60ar0j7j7jrrg4r7j4kscrih0qn2n0lslffzflhv86lyq650r2";
    }) { },
}:
pkgs.mkShell {
    packages = [
        pkgs.cmake
        /*nixfmt:disable*/
        pkgs.clang-tools  # clangd, clang-format, clang-tidy
        pkgs.cpplint      # Coding standard
        pkgs.cmake-format # matches .cmake-format.yaml
        /*nixfmt:enable*/
    ];
}
