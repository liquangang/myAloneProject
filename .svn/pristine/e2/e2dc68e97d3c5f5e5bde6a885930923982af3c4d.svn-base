#import "MailboxViewController.h"
#import "LoginViewController.h"
#import "APPUserPrefs.h"

@interface MailboxViewController ()
@property (retain, nonatomic) LoginViewController *loginViewController;
@property (retain, nonatomic) UIWindow *window;

@end

@implementation MailboxViewController

@synthesize userName,userMailbox,userPassword,loginViewController,window;

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
    ret = [APPUserPrefs registersByMailbox:userName UserPassword:userPassword UserMailbox:userMailbox];
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
