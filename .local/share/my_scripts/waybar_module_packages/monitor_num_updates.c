#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
	int numChars = 6; // allows to store up to 5 digits. The 6th is the null terminator character ('\0')

	char total_pkgs[numChars];
	char aur_pkgs[numChars];
	char tooltip[50];

	FILE *fp1 = popen("$AUR_HELPER -Quq | wc -l", "r");
	FILE *fp2 = popen("$AUR_HELPER -Quaq | wc -l", "r");

	if (fgets(total_pkgs, sizeof(total_pkgs), fp1) != NULL &&
		fgets(aur_pkgs, sizeof(aur_pkgs), fp2) != NULL) {

		// Remove trailing newline character
		total_pkgs[strcspn(total_pkgs, "\n")] = 0;
		aur_pkgs[strcspn(aur_pkgs, "\n")] = 0;

		int official_pkgs = atoi(total_pkgs) - atoi(aur_pkgs);

		snprintf(tooltip, sizeof(tooltip), "Official: %i\rAUR: %s", official_pkgs, aur_pkgs);
		printf("%s", tooltip);
	}
}
