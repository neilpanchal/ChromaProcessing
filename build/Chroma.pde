/////////////////////////////////////////////////////////////////////////////////////////
/*
Author: Neil Panchal
Website: http://neil.engineer/

Copyright 2015 Neil Panchal. All Rights Reserved.

Description: Chroma is a color conversion class for Processing.

Purpose: Primary objective of Chroma is to help the end user seamlessly & effortlessly create colors that are perceptually uniform.

Usage: Please see the README.md file

References:  Color conversion methods are borrowed from various places as detailed below.

*   Gregory Aisch: https://github.com/gka/chroma.js
*   http://developer.classpath.org/doc/java/awt/Color-source.html
*   http://stackoverflow.com/a/7898685
*   http://www.cs.rit.edu/~ncs/color/t_convert.html

*/
/////////////////////////////////////////////////////////////////////////////////////////



public class Chroma {

    // VARIABLES
    private int red;
    private int green;
    private int blue;
    private int alpha;
    private int rgba;

    private boolean clip;

    // CONSTANTS
    private static final float L_MIN = 0.0;
    private static final float L_MAX = 1.70;
    private static final float H_MIN = 0.0;
    private static final float H_MAX = 360.0;
    private static final float C_MIN = 0.0;
    private static final float C_MAX = 5.0;

    private static final float K = 18.0;
    private static final float X = 0.950470;
    private static final float Y = 1.0;
    private static final float Z = 1.088830;


    //CONSTRUCTORS
    /////////////////////////////////////////////////////////////////////////////////////

    public Chroma (float input1, float input2, float input3, float input4, ColorSpace colorSpace) {

        switch (colorSpace) {
            case RGB:
            chromaRGB(input1, input2, input3, input4);
            break;
            case HSV:
            chromaHSV(input1, input2, input3, input4);
            break;
            case HSL:
            chromaHSL(input1, input2, input3, input4);
            break;
            case LAB:
            chromaLAB(input1, input2, input3, input4);
            break;
            case LCH:
            chromaLCH(input1, input2, input3, input4);
            break;
        }
    }

    // Default Alpha Channel is Opaque
    public Chroma (float red_, float green_, float blue_, ColorSpace colorSpace) {
        this(red_, green_, blue_, 255, colorSpace);
    }

    // Default ColorSpace is RGB
    public Chroma (int red_, int green_, int blue_) {

        this(red_, green_, blue_, 255, ColorSpace.RGB);
    }

    // Default Monochromatic Color
    public Chroma(int gs_, int alpha_) {

        this(gs_, gs_, gs_, alpha_, ColorSpace.RGB);
    }

    // Default Monochromatic Opaque Color
    public Chroma(int gs_) {

        this(gs_, gs_, gs_, 255, ColorSpace.RGB);
    }

    // Default Black
    public Chroma () {

        this(0, 0, 0, 255, ColorSpace.RGB);
    }

    public Chroma(String hex_) {

        this(   Integer.parseInt(hex_.substring(1,3), 16),
                Integer.parseInt(hex_.substring(3,5), 16),
                Integer.parseInt(hex_.substring(5,7), 16));
    }


    // COLOR TRANSFORMATION METHODS
    /////////////////////////////////////////////////////////////////////////////////////

    private void chromaRGB(float red_, float green_, float blue_, float alpha_) {

        this.red =   Math.round(red_);
        this.green = Math.round(green_);
        this.blue  = Math.round(blue_);
        this.alpha = Math.round(alpha_);

        this.clip = clipped();

        this.rgba = limit(this.alpha) << 24 | limit(this.red) << 16 | limit(this.green) << 8 | limit(this.blue);

    }

    private void chromaHSV(float hue_, float sat_, float val_, float alpha_) {

        // Initialize local variables for RGB
        float red_ = 0;
        float green_ = 0;
        float blue_ = 0;

        // Convert value from 0-1 to 0-255
        val_ *= 255;


        if (sat_ == 0) {
            red_ = green_ = blue_ = val_;
        } else {

            // Wrap hue if is out of 0-360 range
            if (hue_ == 360) hue_ = 0;
            if (hue_ > 360) hue_ -= 360;
            if (hue_ < 0)  hue_ += 360;

            // Transforming chromaticity plane to bottom 3 faces of the RGB cube
            hue_ /= 60;
            int i = (int)Math.floor(hue_);
            float f = hue_ - i;
            float p = val_ * (1 - sat_);
            float q = val_ * (1 - sat_ * f);
            float t = val_ * (1 - sat_ * (1 - f));

            switch(i) {
                case 0: red_ = val_;  green_ = t;  blue_ = p;  break;
                case 1: red_ = q;  green_ = val_;  blue_ = p;  break;
                case 2: red_ = p;  green_ = val_;  blue_ = t;  break;
                case 3: red_ = p;  green_ = q;  blue_ = val_;  break;
                case 4: red_ = t;  green_ = p;  blue_ = val_;  break;
                case 5: red_ = val_;  green_ = p;  blue_ = q;  break;
                default: break;
            }
        }
        // set RGB values
        chromaRGB(red_, green_, blue_, alpha_);
    }

    private void chromaHSL(float hue_, float sat_, float lgt_, float alpha_) {

        sat_ *= ((lgt_ < 0.5) ? lgt_ : 1 - lgt_);
        chromaHSV(hue_, (2*sat_)/(lgt_+sat_), lgt_+sat_, alpha_);
    }

    private void chromaLCH(float l_, float c_, float h_, float alpha_) {

        h_ = h_ * (float)Math.PI / 180;
        chromaLAB(l_, (float)Math.cos(h_)*c_, (float)Math.sin(h_)*c_, alpha_);
    }

    private void chromaLAB(float l_, float a_, float b_, float alpha_) {

        float y = (l_ + 16) / 116;
        float x = y + a_ / 500;
        float z = y - b_ / 200;

        x = lab_xyz(x) * X;
        y = lab_xyz(y) * Y;
        z = lab_xyz(z) * Z;

        float red_ = xyz_rgb(3.2404542 * x - 1.5371385 * y - 0.4985314 * z);
        float green_ = xyz_rgb(-0.9692660 * x + 1.8760108 * y + 0.0415560 * z);
        float blue_ = xyz_rgb(0.0556434 * x - 0.2040259 * y + 1.0572252 * z);

        chromaRGB(red_, green_, blue_, alpha_);
    }

    // COMPONENTS METHODS
    /////////////////////////////////////////////////////////////////////////////////////


    public int getColor() {
        return rgba;
    }

    public int getRed() {
        return red;
    }

    public int getGreen() {
        return green;
    }

    public int getBlue() {
        return blue;
    }

    public int getAlpha() {
        return alpha;
    }

    public void setRGB(int red_, int green_, int blue_, int alpha_) {
        chromaRGB(red_, green_, blue_, alpha_);
    }

    public void setRGB(int red_, int green_, int blue_) {
        chromaRGB(red_, green_, blue_, 255);
    }

    public void setLAB(float l_, float a_, float b_, float alpha_) {
        chromaLAB(l_, a_, b_, alpha_);
    }

    public void setLAB(float l_, float a_, float b_) {
        chromaLAB(l_, a_, b_, 255);
    }

    public void setLCH(float l_, float c_, float h_, float alpha_) {
        chromaLCH(l_, c_, h_, alpha_);
    }

    public void setLCH(float l_, float c_, float h_) {
        chromaLCH(l_, c_, h_, 255);
    }

    public boolean clipped() {
        return this.red < 0 || this.blue < 0 || this.green < 0 ||
                this.red > 255 || this.blue > 255 || this.green > 255;
    }
    public boolean clippedRed() {
        return this.red < 0 || this.red > 255;
    }

    public boolean clippedGreen() {
        return this.green < 0 || this.green > 255;
    }

    public boolean clippedBlue() {
        return this.blue < 0 || this.blue > 255;
    }

    // MATH & UTILITY METHODS
    /////////////////////////////////////////////////////////////////////////////////////

    private float lab_xyz(float x) {

        if (x > 0.206893034) {
            return x * x * x;
        } else {
            return (x - 4.0/29.0) / 7.787037;
        }
    }

    private float xyz_rgb(float r) {

        return Math.round(255 * (r <= 0.00304 ? 12.92 * r : 1.055 * Math.pow(r, 1 / 2.4) - 0.055));

    }

    private int limit(int input) {

        return Math.max(Math.min(input, 255),0);
    }

    // PRINT METHODS
    /////////////////////////////////////////////////////////////////////////////////////

    public String toString() {

        StringBuilder colorString = new StringBuilder();

        colorString.append("[ RGB Color ]");
        colorString.append(System.getProperty("line.separator"));

        colorString.append("Binary:\t" + Integer.toBinaryString(rgba));
        colorString.append(System.getProperty("line.separator"));

        colorString.append("RGBA:\t"
            + String.format("%03d", (rgba >> 16) & 0xFF) + "\t"
            + String.format("%03d", (rgba >> 8) & 0xFF) + "\t"
            + String.format("%03d", rgba & 0xFF) + "\t"
            + String.format("%03d", (rgba >> 24) & 0xFF));

        colorString.append(System.getProperty("line.separator"));

        return colorString.toString();

    }

}
