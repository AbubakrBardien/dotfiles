{
    pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
    packages = [
        # C/C++ Tools
        pkgs.clang-tools
        pkgs.cmake
    ];
}
