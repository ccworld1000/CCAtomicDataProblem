//
//  ViewController.m
//  CCAtomicDataProblem
//
//  Created by CC on 2021/1/17.
//

#import "ViewController.h"

@interface ViewController ()

@property NSInteger count;

@end

@implementation ViewController

- (void) testCount: (int) loopCount {
    int loop =  10000;
    
    if (loopCount > loop) {
        loop = loopCount;
    }
    
    self.count = 0;
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.cc.CCAtomicDataProblem.1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("com.cc.CCAtomicDataProblem.2", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue1, ^{
        for (int i = 0; i < loop; i++) {
            self.count = self.count + 1;
        }
    });
    
    dispatch_async(queue2, ^{
        for (int i = 0; i < loop; i++) {
            self.count = self.count + 1;
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"self.count = %ld", (long)self.count);
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testCount:10000];
}


@end
