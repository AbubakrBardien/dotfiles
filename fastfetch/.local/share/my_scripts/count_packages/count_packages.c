#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

	FILE* fp1 = popen("$AUR_HELPER -Qen | wc -l", "r");
	FILE* fp2 = popen("$AUR_HELPER -Qem | wc -l", "r");
	FILE* fp3 = popen("flatpak list --app | wc -l", "r");
	FILE* fp4 = popen("flatpak uninstall --unused", "r");
	FILE* fp5 = popen("$AUR_HELPER -Qdt | wc -l", "r");

	int numChars = 6; // allows to store up to 5 digits.
					  // The 6th is the null terminator character ('\0')

	char pacman_pkgs[numChars];
	char aur_pkgs[numChars];
	char flatpaks[numChars];
	char flatpak_orphaned_pkgs[28];
	char orphaned_pkgs[numChars];

	if (fgets(pacman_pkgs, sizeof(pacman_pkgs), fp1) != NULL &&
		fgets(aur_pkgs, sizeof(aur_pkgs), fp2) != NULL &&
		fgets(flatpaks, sizeof(flatpaks), fp3) != NULL &&
		fgets(flatpak_orphaned_pkgs, sizeof(flatpak_orphaned_pkgs), fp4) != NULL &&
		fgets(orphaned_pkgs, sizeof(orphaned_pkgs), fp5) != NULL) {

		// Remove trailing newline character
		pacman_pkgs[strcspn(pacman_pkgs, "\n")] = 0;
		aur_pkgs[strcspn(aur_pkgs, "\n")] = 0;
		flatpaks[strcspn(flatpaks, "\n")] = 0;

		// If there are orphaned packages from flatpak
		if (strcmp(flatpak_orphaned_pkgs, "Nothing unused to uninstall") != 0) {
			FILE* fp6 = popen("flatpak uninstall --unused | wc -l", "r");

			fgets(flatpak_orphaned_pkgs, sizeof(flatpak_orphaned_pkgs), fp6);

			orphaned_pkgs[strcspn(orphaned_pkgs, "\n")] = 0;
			flatpak_orphaned_pkgs[strcspn(flatpak_orphaned_pkgs, "\n")] = 0;

			sprintf(orphaned_pkgs, "%d", atoi(orphaned_pkgs) + (atoi(flatpak_orphaned_pkgs) - 4));

			pclose(fp6);
		} else {
			orphaned_pkgs[strcspn(orphaned_pkgs, "\n")] = 0;
		}

		char output_str[45] = "";

		strcat(output_str, pacman_pkgs);
		strcat(output_str, " (Pacman)");

		if (strcmp(aur_pkgs, "0") != 0) { // If more than 0 AUR packages
			strcat(output_str, ", ");
			strcat(output_str, aur_pkgs);
			strcat(output_str, " (AUR)");
		}

		if (strcmp(flatpaks, "0") != 0) { // If more than 0 flatpaks packages
			strcat(output_str, ", ");
			strcat(output_str, flatpaks);
			strcat(output_str, " (Flathub)");
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
	pclose(fp5);

	return 0;
}
