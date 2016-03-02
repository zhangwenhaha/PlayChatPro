
#import <UIKit/UIKit.h>

typedef enum {
    ZWTopicTypeAll = 1,
    ZWTopicTypePicture = 10,
    ZWTopicTypeWord = 29,
    ZWTopicTypeVoice = 31,
    ZWTopicTypeVideo = 41
} ZWTopicType;

UIKIT_EXTERN CGFloat const ZWTitlesViewH;

UIKIT_EXTERN CGFloat const ZWTitlesViewy;

/** 精华－Cell － 图片贴纸的最大高度  */
UIKIT_EXTERN CGFloat const ZWTopicCellPictureMaxH;
/** 精华－Cell － 图片贴纸超过最大高度，改为固定尺寸*/
UIKIT_EXTERN CGFloat const ZWTopicCellPictureBreakH;


/** ZWTopicUser - 性别属性值*/
UIKIT_EXTERN NSString * const ZWTopicUserSexMale;

UIKIT_EXTERN NSString * const ZWTopicUserSexFeMale;