#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

	FILE *fp1 = popen("$AUR_HELPER -Qen | wc -l", "r");
	FILE *fp2 = popen("$AUR_HELPER -Qem | wc -l", "r");
	FILE *fp3 = popen("$AUR_HELPER -Qdt | wc -l", "r");

	int numChars = 6; // allows to store up to 5 digits.
					  // The 6th is the null terminator character ('\0')

	char pacman_pkgs[numChars];
	char aur_pkgs[numChars];
	char orphened_pkgs[numChars];

	if (fgets(pacman_pkgs, sizeof(pacman_pkgs), fp1) != NULL &&
		fgets(aur_pkgs, sizeof(aur_pkgs), fp2) != NULL &&
		fgets(orphened_pkgs, sizeof(orphened_pkgs), fp3) != NULL) {

		// Remove trailing newline character
		pacman_pkgs[strcspn(pacman_pkgs, "\n")] = 0;
		aur_pkgs[strcspn(aur_pkgs, "\n")] = 0;
		orphened_pkgs[strcspn(orphened_pkgs, "\n")] = 0;

		printf("%s (Pacman), %s (AUR), %s (orphaned)", pacman_pkgs, aur_pkgs, orphened_pkgs);
	}

	pclose(fp1);
	pclose(fp2);
	pclose(fp3);

	return 0;
}
