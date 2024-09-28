#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    int numChars = 6; // allows to store up to 5 digits. The 6th is the null terminator character ('\0')
    
    char official_pkgs[numChars];
    char aur_pkgs[numChars];
    char tooltip[50];
    
    FILE *fp1 = popen("pacman -Qun | wc -l", "r");
    FILE *fp2 = popen("pacman -Qum | wc -l", "r");

    if (fgets(official_pkgs, sizeof(official_pkgs), fp1) != NULL &&
        fgets(aur_pkgs, sizeof(aur_pkgs), fp2) != NULL) {
        
        // Remove trailing newline character
        official_pkgs[strcspn(official_pkgs, "\n")] = 0;
        aur_pkgs[strcspn(aur_pkgs, "\n")] = 0;

        snprintf(tooltip, sizeof(tooltip), "Official: %s\rAUR: %s", official_pkgs, aur_pkgs); 
        printf(tooltip);
    }
}
