//
//  MSImageEffectTool.m
//  AppTemplate
//
//  Created by MonsterSucker on 10/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import "MSImageEffectTool.h"
@implementation MSImageEffectTool

+ (UIImage*)blurredImageWithImage:(UIImage *)sourceImage {
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *retVal = [UIImage imageWithCGImage:cgImage];
    
    if (cgImage) {
        CGImageRelease(cgImage);
    }
    
    return retVal;
}

+ (UIImage *)processImageWithCIEffect:(CIEffect)Effect InputImage:(UIImage *)inputImage {
    UIImage *outputImage ;
    switch (Effect) {
        case CIEffectCIMaskedVariableBlur: {
            
            return outputImage;
            break;
 
        }
            
        case CIEffectCILinearToSRGBToneCurve:{
            
            return outputImage;
            break;
            
        }

        case CIEffectCIPhotoEffectInstant:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCIPhotoEffectMono:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCICIKaleidoscope:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCISixfoldReflectedTile:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCICITriangleKaleidoscope:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCITriangleTile:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCICICrystallize:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCIDepthOfField:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCIHexagonalPixellate:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCIComicEffect:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCITwelvefoldReflectedTile:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCIGlassDistortion:{
            
            return outputImage;
            break;
            
        }

            
        case CIEffectCIGammaAdjust:{
            
            return outputImage;
            break;
            
        }
        default:
            break;
    }
}
@end
