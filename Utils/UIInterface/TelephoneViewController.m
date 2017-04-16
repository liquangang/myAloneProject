#import "TelephoneViewController.h"
#import "APPUserPrefs.h"
#import "LoginViewController.h"

@interface TelephoneViewController ()
@property (retain, nonatomic) LoginViewController *loginViewController;
@property (retain, nonatomic) UIWindow *window;
@end

@implementation TelephoneViewController

@synthesize userName,userTelephone,userPassword,loginViewController,window;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)outDone:(id)sender{
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)registers:(id)sender{
    
    int ret = -1;
    ret = [APPUserPrefs registersByTelephone:userName UserPassword:userPassword UserTelephone:userTelephone];
    if (ret == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"MessageBox"
                              message:@"注册成功！"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
        self.loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        self.window.rootViewController = self.loginViewController;
        [self presentModalViewController:self.loginViewController animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"MessageBox"
                              message:@"登录失败！"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        [alert show];
    }
    
}

@end
