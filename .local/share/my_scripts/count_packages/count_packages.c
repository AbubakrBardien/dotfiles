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
	char orphaned_pkgs[numChars];

	if (fgets(pacman_pkgs, sizeof(pacman_pkgs), fp1) != NULL &&
		fgets(aur_pkgs, sizeof(aur_pkgs), fp2) != NULL &&
		fgets(orphaned_pkgs, sizeof(orphaned_pkgs), fp3) != NULL) {

		// Remove trailing newline character
		pacman_pkgs[strcspn(pacman_pkgs, "\n")] = 0;
		aur_pkgs[strcspn(aur_pkgs, "\n")] = 0;
		orphaned_pkgs[strcspn(orphaned_pkgs, "\n")] = 0;

		char output_str[45] = "";

		strcat(output_str, pacman_pkgs);
		strcat(output_str, " (Pacman)");

		if (strcmp(aur_pkgs, "0") != 0) { // If more than 0 AUR packages
			strcat(output_str, ", ");
			strcat(output_str, aur_pkgs);
			strcat(output_str, " (AUR)");
		}

		if (strcmp(orphaned_pkgs, "0") != 0) { // If more than 0 orphaned packages
			strcat(output_str, ", ");
			strcat(output_str, orphaned_pkgs);
			strcat(output_str, " (orphaned)");
		}

		printf("%s", output_str);
	}

	pclose(fp1);
	pclose(fp2);
	pclose(fp3);

	return 0;
}
