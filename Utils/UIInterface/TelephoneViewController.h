#import <UIKit/UIKit.h>

@interface TelephoneViewController : UIViewController{
    IBOutlet UITextField *userName;
    IBOutlet UITextField *userTelephone;
    IBOutlet UITextField *userPassword;
}

@property (nonatomic,strong) UITextField *userName;
@property (nonatomic,strong) UITextField *userTelephone;
@property (nonatomic,strong) UITextField *userPassword;

- (IBAction)registers:(id)sender;
- (IBAction)outDone:(id)sender;

@end
