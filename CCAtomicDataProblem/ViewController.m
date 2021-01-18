//
//  ViewController.m
//  CCAtomicDataProblem
//
//  Created by CC on 2021/1/17.
//

#import "ViewController.h"

@interface ViewController () {
    int defaultCount;
}

@property NSInteger count;
@property (nonatomic, copy) NSString *cString;

@end

@implementation ViewController

- (void) testcString {
    dispatch_queue_t queue = dispatch_queue_create("com.cc.CCAtomicDataProblem.0", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < self->defaultCount * self->defaultCount; i++) {
        dispatch_async(queue, ^{
            self.cString = [NSString stringWithFormat:@"cString test %d times", i + 1];
            NSLog(@"%@", self.cString);
        });
    }
}

- (void) testCount: (int) loopCount {
    int loop = defaultCount;
    
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

- (void) loadingData {
    defaultCount = 10000;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadingData];
    
    [self testCount:defaultCount];
}


@end
