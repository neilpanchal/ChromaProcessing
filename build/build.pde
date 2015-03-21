
int PALETTE_SIZE = 600;
int CANVAS_MIN = 0;
int CANVAS_MAX = 600;

// Chroma[][] testColors;
Chroma testColor;

void setup() {

    size(600, 600, "processing.core.PGraphicsRetina2D");
    noStroke();
    noLoop();
    // testColors = new Chroma[PALETTE_SIZE][PALETTE_SIZE];
    testColor = new Chroma("#FF0000");
    println(testColor.getRed());
    // printColor("Test Color: ", testColor);
}

void draw() {

    background(255);
    // plotHC(testColors);
}

// void plotHC(Chroma[][] chromaPalette) {
//     smooth();

//     float L = 80;
//     float C;
//     float H;

//     int R;
//     int G;
//     int B;

//     for (int i=0; i < PALETTE_SIZE; i++) {
//         for (int j=0; j < PALETTE_SIZE; j++) {

//             C = map(i, 0, PALETTE_SIZE, 0, 120);
//             H = map(j, 0, PALETTE_SIZE, 0, 360);

//             chromaPalette[i][j] = new Chroma(L, C, H, 255, ColorSpace.LCH);
//         }
//     }

//     // Draw
//     println("Plotting...");

//     for (int i=0; i < width; i++) {
//         for (int j=0; j < height; j++) {
//             int p = (int)map(i, 0, width, 0, PALETTE_SIZE);
//             int q = (int)map(j, 0, height, 0, PALETTE_SIZE);

//             R = chromaPalette[p][q].getRed();
//             G = chromaPalette[p][q].getGreen();
//             B = chromaPalette[p][q].getBlue();

//             if (chromaPalette[p][q].getClipFlag()) {
//                 fill(255, 255, 255, 255);
//             } else {
//                 fill(R,G,B,255);
//             }
//             rect(j, i, (CANVAS_MAX-CANVAS_MIN)/PALETTE_SIZE, (CANVAS_MAX-CANVAS_MIN)/PALETTE_SIZE);
//         }
//     }
// }

// void plotHL(Chroma[][] chromaPalette) {
//     smooth();

//     float L;
//     float C = 100;
//     float H;

//     int R;
//     int G;
//     int B;

//     for (int i=0; i < PALETTE_SIZE; i++) {
//         for (int j=0; j < PALETTE_SIZE; j++) {

//             L = map(i, 0, PALETTE_SIZE, 0, 100);
//             H = map(j, 0, PALETTE_SIZE, 0, 360);

//             chromaPalette[i][j] = new Chroma(L, C, H, 255, ColorSpace.LCH);
//         }
//     }

//     // Draw
//     println("Plotting...");

//     for (int i=0; i < width; i++) {
//         for (int j=0; j < height; j++) {
//             int p = (int)map(i, 0, width, 0, PALETTE_SIZE);
//             int q = (int)map(j, 0, height, 0, PALETTE_SIZE);

//             R = chromaPalette[p][q].getRed();
//             G = chromaPalette[p][q].getGreen();
//             B = chromaPalette[p][q].getBlue();

//             if (chromaPalette[p][q].getClipFlag()) {
//                 fill(255, 255, 255, 255);
//             } else {
//                 fill(R,G,B,255);
//             }
//             rect(i, j, (CANVAS_MAX-CANVAS_MIN)/PALETTE_SIZE, (CANVAS_MAX-CANVAS_MIN)/PALETTE_SIZE);
//         }
//     }
// }

// void printColor(String chromaName, Chroma printColor) {
//     println(chromaName + "RGB:\t\t" + printColor.getRed() + "\t\t" +
//         printColor.getGreen() + "\t\t" +
//         printColor.getBlue() + "\t\t" +
//         printColor.getClipFlag());

//     float[] chromaLab = printColor.getLabComponents();
//     float[] chromaLch = printColor.getLchComponents();

//     println(chromaName + "Lab:\t\t" + chromaLab[0] + "\t\t" +
//         chromaLab[1] + "\t\t" +
//         chromaLab[2] + "\t\t");

//     println(chromaName + "Lch:\t\t" + chromaLch[0] + "\t\t" +
//         chromaLch[1] + "\t\t" +
//         chromaLch[2] + "\t\t");
// }
