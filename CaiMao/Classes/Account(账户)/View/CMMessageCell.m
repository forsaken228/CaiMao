//
//  CMMessageCell.m
//  CaiMao
//
//  Created by MAC on 16/6/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMessageCell.h"
//#import "UIImageView+WebCache.h"
@implementation CMMessageCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor=ViewBackColor;
            [self addSubview:self.messageImageView];
        [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(self.messageImageView.image.size.height));
            make.width.mas_equalTo(f_i5real(self.messageImageView.image.size.width));
            make.centerX.equalTo(self.mas_centerX).offset(15);
            make.top.equalTo(self.mas_top).offset(30);
        }];
        
        //右边时间
      
        [self addSubview:self.timeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);

            make.centerX.width.equalTo(self.messageImageView);
            make.bottom.equalTo(self.messageImageView.mas_top).offset(-8);
        }];
        
       
      
        [self.messageImageView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);

            make.left.equalTo(self.messageImageView.mas_left).offset(15);
            make.right.equalTo(self.messageImageView.mas_right).offset(-10);
            make.top.equalTo(self.messageImageView.mas_top).offset(10);
        }];
        
       
        [self.messageImageView addSubview:self.detailBtn];
        
        [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@80);
            make.left.equalTo(self.messageImageView.mas_left).offset(15);
            make.bottom.equalTo(self.messageImageView.mas_bottom).offset(-8);
        }];
        
        
        UIImageView *list=[[UIImageView alloc]init];
        // list.frame=CGRectMake(295,16, 7,11);
        list.image=[UIImage imageNamed:@"listOpen.png"];
        [self addSubview:list];
        
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.messageImageView.mas_right).offset(-15);
            make.centerY.equalTo(self.detailBtn);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
        }];

        
        //分割线
        UIView *line=[UIView new];
        line.backgroundColor=separateLineColor;
       
        [self.messageImageView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            
            make.right.equalTo(list.mas_right);
            make.left.equalTo(self.detailBtn.mas_left);
            make.bottom.equalTo(self.detailBtn.mas_top).offset(-10);
        }];
        
        
        
        [self addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(self.headImageView.image.size.height));
            make.width.mas_equalTo(f_i5real(self.headImageView.image.size.width));
            make.right.equalTo(self.messageImageView.mas_left).offset(-5);
            make.bottom.equalTo(self.detailBtn.mas_bottom)                                                                                        ;
        }];
        //消息
        [self addSubview:self.headRightRed];
        [self.headRightRed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@8);
            make.top.equalTo(self.headImageView.mas_top);
            make.left.equalTo(self.headImageView.mas_right).offset(-3);
        }];
        //接收信息label
            }
   return self;
}

#pragma mark Lazy
-(UIImageView*)messageImageView{
    if (!_messageImageView) {
        UIImage *Bgimage=[UIImage imageNamed:@"messageBg"];
        _messageImageView=[[UIImageView alloc]init];
        
        _messageImageView.image=[Bgimage stretchableImageWithLeftCapWidth:(Bgimage.size.width/2.0 )topCapHeight:(Bgimage.size.height/2.0 )];
        _messageImageView.userInteractionEnabled=YES;
  
    }
    
    return _messageImageView;
}
-(UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]init];
        _timeLabel.textColor=[UIColor lightGrayColor];
        _timeLabel.font=[UIFont systemFontOfSize:14];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    return _timeLabel;
}

-(UILabel*)messageLabel{
    if (!_messageLabel) {
        _messageLabel=[[UILabel alloc]init];
        _messageLabel.numberOfLines=0;
        _messageLabel.font=[UIFont systemFontOfSize:14.0];
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        
    }
    return _messageLabel;
}
-(UIButton*)detailBtn{
    if (!_detailBtn) {
        //详情按钮
        _detailBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _detailBtn.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [_detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        _detailBtn.titleLabel.textColor=CMColor(0, 113, 248);
        [_detailBtn addTarget:self action:@selector(DetailbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _detailBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    }
    return _detailBtn;
    
}
-(UIImageView*)headImageView{
    if (!_headImageView) {
        //左边头像
       // UIImage *headimage=[UIImage imageNamed:@"msgHead"];
       _headImageView=[[UIImageView alloc]init];
        _headImageView.image=[UIImage imageNamed:@"msgHead"];
        

    }
    return _headImageView;
}
-(UILabel*)headRightRed{
    if (!_headRightRed) {
        _headRightRed=[[UILabel alloc]init];
        _headRightRed.backgroundColor=RedButtonColor;
        _headRightRed.layer.cornerRadius=4;
        _headRightRed.hidden=YES;
        _headRightRed.layer.masksToBounds=YES;
 
    }
    
    return _headRightRed;
    
}

-(void)DetailbtnClick:(id)sender{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(detailButtonActionWithIndex:)]) {
        [self.delegate  detailButtonActionWithIndex:self.indexpath];
    }
    
}


@end
