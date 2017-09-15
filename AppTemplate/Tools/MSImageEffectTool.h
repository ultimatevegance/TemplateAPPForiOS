//
//  MSImageEffectTool.h
//  AppTemplate
//
//  Created by MonsterSucker on 10/09/2017.
//  Copyright © 2017 MonsterTechStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

typedef NS_ENUM(NSUInteger, CIEffect) {
    CIEffectCIMaskedVariableBlur,
    CIEffectCILinearToSRGBToneCurve,
    CIEffectCIPhotoEffectInstant,
    CIEffectCIPhotoEffectMono,
    CIEffectCICIKaleidoscope,
    CIEffectCISixfoldReflectedTile,
    CIEffectCICITriangleKaleidoscope,
    CIEffectCITriangleTile,
    CIEffectCICICrystallize ,
    CIEffectCIDepthOfField,
    CIEffectCIHexagonalPixellate,
    CIEffectCIComicEffect,
    CIEffectCITwelvefoldReflectedTile,
    CIEffectCIGlassDistortion,
    CIEffectCIGammaAdjust
};


@interface MSImageEffectTool : NSObject

+ (UIImage *)blurredImageWithImage:(UIImage *)sourceImage;

+ (UIImage *)processImageWithCIEffect:(CIEffect)Effect InputImage:(UIImage *)inputImage;

@end
