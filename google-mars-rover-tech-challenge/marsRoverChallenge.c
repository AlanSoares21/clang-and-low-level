#include <stdio.h>
#include <unistd.h>

char orientations[] = {'N', 'E', 'S', 'W'};

int rotateLeft(int orientationIndex) {
    int index = orientationIndex - 1;
    if (index < 0)
        return 3;
    if (index > 3)
        return 0;
    return index;
}

int rotateRigth(int orientationIndex) {
    int index = orientationIndex + 1;
    if (index < 0)
        return 3;
    if (index > 3)
        return 0;
    return index;
}

int getOrientationIndex(char value) {
    for (int i = 0; i < 4; i++)
    {
        if (orientations[i] == value)
            return i;
    }
    return -1;
}

int moveY(int orientationIndex) {
    if (orientations[orientationIndex] == 'S')
        return -1;
    else if (orientations[orientationIndex] == 'N')
        return 1;
    return 0;
}

int moveX(int orientationIndex) {
    if (orientations[orientationIndex] == 'W')
        return -1;
    else if (orientations[orientationIndex] == 'E')
        return 1;
    return 0;
}

int main()
{
    // printf("initiated \n");
    
    int maxX = 0;
    
    scanf("%d", &maxX);
    
    int maxY = 0;
    scanf("%d", &maxY);

    // printf("the plateau upper right coordinates are (%d, %d) \n", maxX, maxY);

    int roversCount = 0;
    while (roversCount < 2) {
        int currentX = -1;
        scanf("%d", &currentX);

        int currentY = -1;
        scanf("%d", &currentY);
        
        char orientation = ' ';
        do {
            scanf("%c", &orientation);
        } while (orientation == ' ');
        int orientationIndex = getOrientationIndex(orientation);
        if (orientationIndex == -1) {
            printf("Error orientation index is -1. Orientation: %c", orientation);
            _exit(1);
        }

        // printf("the rover %d is: (%d, %d) to %c \n", roversCount, currentX, currentY, orientation);
        
        char line[100];
        int lineSize = scanf("%s", &line);

        // printf("the rover line %d is: %s with size %d \n", roversCount, line, lineSize);
        // printf("string %s \n", line);
        for (int i = 0; line[i] != '\n'; i++)
        {
            // printf("numero %d, char %c \n", i, line[i]);
            switch (line[i])
            {
                case 'L':
                    orientationIndex = rotateLeft(orientationIndex);
                    continue;
                case 'R':
                    orientationIndex = rotateRigth(orientationIndex);
                    continue;
                case 'M':
                    currentX += moveX(orientationIndex);
                    currentY += moveY(orientationIndex);
                    continue;
                default:
            }
            // printf(" parando no numero %d, char %c, da string %s \n", i, line[i], line);
            break;
        }
        printf("%d %d %c \n", currentX, currentY, orientations[orientationIndex]);
        roversCount++;
    }
    /* code */
    // printf("finished \n");
    return 0;
}
