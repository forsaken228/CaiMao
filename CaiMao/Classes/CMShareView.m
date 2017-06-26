//
//  CMShareView.m
//  CaiMao
//
//  Created by MAC on 16/10/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMShareView.h"
@interface CMShareView ()
{
    UIButton *platomBtn;
}
@property (strong, nonatomic) UIView *bgView;//分享主view

@property (strong, nonatomic) UIView *shareView;//分享主view
@property (strong, nonatomic) UILabel *detailLabel;//选项view
@property (strong, nonatomic) UIButton *smsShareBtn;
@property (strong, nonatomic) UIButton *cancelBtn;//取消
@property (strong, nonatomic) UIView *fgxView;//分割线view

@end
@implementation CMShareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.alpha = 0.85f;
//        self.backgroundColor = UIColorFromRGB(0x999999);
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
//       
//        [self addGestureRecognizer:tap];
        [self addView];
    }
    return self;
}
-(void)addView{
    

    [self addSubview:self.bgView];
    [self addSubview:self.shareView];
  
    [self.shareView addSubview:self.detailLabel];
   
    //通讯录
    [self.shareView addSubview:self.smsShareBtn];

    [self.smsShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@39);
        make.left.equalTo(self.shareView.mas_left).offset(30);
        make.right.equalTo(self.shareView.mas_right).offset(-30);
        make.top.equalTo(self.shareView.mas_top).offset(10);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.smsShareBtn);
        make.top.equalTo(self.smsShareBtn.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    NSArray *titleArr=@[@"QQ好友",@"QQ空间",@"微信好友",@"朋友圈",@"新浪微博"];
    for (int i=0;i<titleArr.count; i++) {
        UIImage *image=[UIImage imageNamed:titleArr[i]];
        platomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        platomBtn.frame=CGRectMake( f_i5real(40)+(i%5)*( f_i5real(40)+ f_i5real(10)),95, f_i5real(40),  f_i5real(40));
        [platomBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        platomBtn.titleLabel.font= [UIFont systemFontOfSize:10.0];
        platomBtn.titleLabel.textAlignment= NSTextAlignmentCenter;
        [platomBtn setTitleColor:UIColorFromRGB(0x818181)
         forState:UIControlStateNormal];
        [platomBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [platomBtn setContentVerticalAlignment: UIControlContentVerticalAlignmentTop];
        
        [platomBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
        //[platomBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -image.size.height, 0)];
        [platomBtn setTitleEdgeInsets:UIEdgeInsetsMake(50,-60,0,0)];
        
        platomBtn.tag=11+i;
        [platomBtn addTarget:self action:@selector(sharePlatformsClick:) forControlEvents:UIControlEventTouchUpInside];
        [platomBtn setImage:image forState:UIControlStateNormal];
        [self.shareView addSubview:platomBtn];
        
    }
    //分割线
    //[self.shareView addSubview:self.fgxView];
    //分割线
//    [self.fgxView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(platomBtn.mas_bottom).offset(30);
//        make.left.equalTo(self.shareView.mas_left).offset(20);
//        make.right.equalTo(self.shareView.mas_right).offset(-20);
//        make.height.mas_equalTo(@0.5);
//    }];
    //取消
    [self.shareView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.shareView);
        make.bottom.equalTo(self.shareView.mas_bottom);
        make.height.equalTo(@40);
        
    }];
}
-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.frame];
        _bgView.userInteractionEnabled=YES;
        _bgView.backgroundColor=[UIColor blackColor];
        _bgView.alpha=0.52f;
              UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        
              [_bgView addGestureRecognizer:tap];
}
    return _bgView;

    
}
//分享的主view
- (UIView *)shareView {
    if (!_shareView) {
        _shareView = [[UIView alloc] init];
        _shareView.backgroundColor = UIColorFromRGB(0xe5e5e5);
        _shareView.alpha=0.95f;
        _shareView.frame = CGRectMake(0, CMScreenH - 215, CMScreenW,215);
    }
    return _shareView;
}


-(void)dismissView{
    
    [self removeFromSuperview];
}
-(UIButton*)smsShareBtn{
    if (!_smsShareBtn) {
        _smsShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smsShareBtn setBackgroundColor:RedButtonColor];
        [_smsShareBtn setTitle:@"邀请通信录中的好友" forState:UIControlStateNormal];
        _smsShareBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [_smsShareBtn addTarget:self action:@selector(sharePlatformsClick:) forControlEvents:UIControlEventTouchUpInside];
        _smsShareBtn.tag=10;
    }
    return _smsShareBtn;

    
}
-(UILabel*)detailLabel{
    
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = UIColorFromRGB(0x989898);
        _detailLabel.text=@"你也可以用以下方式邀请好友";
        _detailLabel.textAlignment=NSTextAlignmentCenter;
        _detailLabel.font=[UIFont systemFontOfSize:12.0];
    }
    return _detailLabel;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setBackgroundColor:UIColorFromRGB(0xf9f9f9)];
        [_cancelBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        _cancelBtn.tag=16;
        _cancelBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(sharePlatformsClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

//分割线
- (UIView *)fgxView {
    if (!_fgxView) {
        _fgxView = [[UIView alloc] init];
        _fgxView.backgroundColor = [UIColor grayColor];
    }
    return _fgxView;
}
-(void)sharePlatformsClick:(UIButton*)shareBtn{
    switch (shareBtn.tag) {
        case 10:
            [self shareDelegateShareType:CMShareViewTypeSms];
            break;
        case 11:
            [self shareDelegateShareType:CMShareViewTypeQQ];
            break;
        case 12:
            [self shareDelegateShareType:CMShareViewTypeQzone];
            break;
        case 13:
            [self shareDelegateShareType:CMShareViewTypeWechat];
            break;
        case 14:
            [self shareDelegateShareType:CMShareViewTypeFriends];
            break;
        case 15:
            [self shareDelegateShareType:CMShareViewTypeWebo];
            break;
        case 16:
            [self dismissView];
            break;
            
        default:
            break;
    }
    
}
- (void)shareDelegateShareType:(CMShareViewType)type {
    if ([self.delegate respondsToSelector:@selector(shareViewShareType:)]) {
        [self.delegate shareViewShareType:type];
    }
}

@end
