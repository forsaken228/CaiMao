//
//  CMAddressList.h
//  CaiMao
//
//  Created by MAC on 16/6/29.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAddressList : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

{
    UITableView *_listTableView;
  
    UITapGestureRecognizer *tap;
        
    
}
@property(nonatomic,strong)NSMutableArray *dataSourceArray;

-(id)initWithAddressList:(NSMutableArray*)arr;

-(void)ShowAlert;
-(void)dimissAlert;
@property(nonatomic,assign)id delegate;
@end
@protocol AddressListDelegate <NSObject>

-(void)alertViewShowAddressWithRow:(NSInteger)aRow;
-(void)tapDismissView;
@end
