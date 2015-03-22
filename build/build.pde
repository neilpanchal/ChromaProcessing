import controlP5.*;
// Download ControlP5 library: http://www.sojamo.de/libraries/controlP5

ControlP5 cp5;
int PALETTE_SIZE = 450;

Chroma[][] plotColors;
Chroma testColor;
int lumaValue = 50;
int chromaValue = 50;

void setup() {

    size(1200, 600, "processing.core.PGraphicsRetina2D");
    smooth();
    noStroke();
    frameRate(30);

    cp5 = new ControlP5(this);
    cp5.setColorBackground(#CCCCCC).setColorForeground(#777777).setColorActive(#000000);

    cp5.addSlider("lumaValue").setPosition(50,25).setRange(0,100).setSize(500, 15);
    cp5.addSlider("chromaValue").setPosition(650,25).setRange(0,128).setSize(500, 15);

}

void draw() {

    background(255);
    plotCH(50, 50, PALETTE_SIZE, PALETTE_SIZE, lumaValue);
    plotHL(650, 50, PALETTE_SIZE, PALETTE_SIZE, chromaValue);
}


void plotCH(int x, int y, int x_size, int y_size, int L) {


    float C;
    float H;
    plotColors = new Chroma[x_size][y_size];

    for (int i=0; i < x_size; i++) {
        for (int j=0; j < y_size; j++) {
            C = map(i, 0, y_size, 0, 120);
            H = map(j, 0, x_size, 0, 360);
            plotColors[i][j] = new Chroma(L, C, H, 255, ColorSpace.LCH);
            if (plotColors[i][j].clipped()) {
                fill(255);
            } else {
                fill(plotColors[i][j].getColor());
            }
            rect(y+j, x+i, 1, 1);
        }
    }
}


void plotHL(int x, int y, int x_size, int y_size, int C) {


    float L;
    float H;
    plotColors = new Chroma[x_size][y_size];

    for (int i=0; i < x_size; i++) {
        for (int j=0; j < y_size; j++) {
            L = map(j, 0, y_size, 0, 120);
            H = map(i, 0, x_size, 0, 360);
            plotColors[i][j] = new Chroma(L, C, H, 255, ColorSpace.LCH);
            if (plotColors[i][j].clipped()) {
                fill(255);
            } else {
                fill(plotColors[i][j].getColor());
            }
            rect(x+i, y+j, 1, 1);
        }
    }
}
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
