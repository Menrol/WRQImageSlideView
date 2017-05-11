# WRQImageSlideView
提供简单的接口创建图片轮播器，使用了KVO，可以在`- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context` 方法中添加点击图片要进入的界面\
## 代码示例
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建url数组
    NSArray *urls = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", nil];
    //创建image数组
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"main_img%d.png",i + 1]];
        [images addObject:image];
    }
    
    //创建轮播器
    WRQImageSlideView *imageSlideView = [[WRQImageSlideView alloc]initWithFrame:CGRectMake(W*0.05, 20, W*0.9, H*0.28) TimeInterval:2 Images:images Urls:urls Observer:self];
    [self.view addSubview:imageSlideView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSString *urlString = (NSString *)[change objectForKey:@"new"];
    NSLog(@"点击了%@",urlString);
    //在这里添加要推的视图控制器
}
```
## 参数
- 时间间隔
- 图片的数组
- 点击图片的链接的数组
- 观察者
- 在观察方法中添加视图控制器
