#import "RegisterViewController.h"
#import "MailboxViewController.h"
#import "TelephoneViewController.h"

@interface RegisterViewController ()
@property (strong, nonatomic) MailboxViewController *mailboxViewController;
@property (strong, nonatomic) TelephoneViewController *telephoneViewController;
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mailboxViewController = [self.storyboard
                               instantiateViewControllerWithIdentifier:
                               @"Mailbox"];
    [self.view insertSubview:self.mailboxViewController.view atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (!self.mailboxViewController.view.superview) {
        self.mailboxViewController = nil;
    } else {
        self.telephoneViewController = nil;
    }
}

- (IBAction)switchViews:(id)sender {
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (!self.telephoneViewController.view.superview) {
        if (!self.telephoneViewController) {
            self.telephoneViewController = [self.storyboard
                                         instantiateViewControllerWithIdentifier:@"Telephone"];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                               forView:self.view cache:YES];
        [self.mailboxViewController.view removeFromSuperview];
        [self.view insertSubview:self.telephoneViewController.view atIndex:0];
        self.title = @"手机号注册";
    } else {
        if (!self.mailboxViewController) {
            self.mailboxViewController = [self.storyboard
                                       instantiateViewControllerWithIdentifier:@"MailBox"];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                               forView:self.view cache:YES];
        [self.telephoneViewController.view removeFromSuperview];
        [self.view insertSubview:self.mailboxViewController.view atIndex:0];
        self.title = @"邮箱注册";
    }
    [UIView commitAnimations];
}



@end
