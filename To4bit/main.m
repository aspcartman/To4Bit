//
//  main.m
//  To4bit
//
//  Created by ASPCartman on 24/03/15.
//  Copyright (c) 2015 None. All rights reserved.
//

#import <AppKit/AppKit.h>

int main(int argc, const char * argv[]) {
	if (argc != 1)
	{
		return -1;
	}
	
	NSImage *image = [NSImage imageNamed:@"lol.jpg"];
	NSBitmapImageRep* raw_img = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
//	raw_img = [raw_img bitmapImageRepByConvertingToColorSpace:[NSColorSpace genericGrayColorSpace] renderingIntent:NSColorRenderingIntentDefault];
	FILE *f = fopen("lol.txt", "w");
	
	uint8 result = 0;
	for (uint y=0; y < raw_img.size.height; ++y)
	{
		for (uint x=0; x < raw_img.size.width; ++x)
		{
			NSColor* color = [raw_img colorAtX:x y:y];
			CGFloat c =  (color.redComponent + color.greenComponent + color.blueComponent) / 3.f;
			result = result + ( ((uint8)(c * 0b11)) << ((x % 4)*2));
			if (x%4==3)
			{
				fwrite(&result, sizeof(result), 1, f);
				NSLog(@"%f = %d",c, (int)result);
				result = 0;
			}
			
		}
//		printf("\n");
	}
    return 0;
}
