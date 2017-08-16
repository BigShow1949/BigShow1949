//
//  MVPCounterViewController.h
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

/* V层
 这里的View与MVC中的V又有一些小差别，这个View可以是viewcontroller、view等控件。Presenter通过向View传model数据进行交互。
 (如果抽取出counterView, 那么V层就不是ViewController, 是view了)
 */
@interface MVPCounterViewController : UIViewController

@end
