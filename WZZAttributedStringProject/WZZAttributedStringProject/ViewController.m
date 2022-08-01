//
//  ViewController.m
//  WZZAttributedStringProject
//
//  Created by wyq_iMac on 2022/7/29.
//

#import "ViewController.h"
#import "WZZAttributedString.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //链接及挂件示例
    NSURL * link = [NSURL URLWithString:@"http://www.baidu.com"];
    WZZAttributedString * linkText = [WZZAttributedString stringWithText:@"链接及挂件示例："].setupFont([UIFont systemFontOfSize:15])
        .appendNewString(@"点击->").setupFont([UIFont systemFontOfSize:15])
        .appendNewString(@"").setupImageAttachment([UIImage imageNamed:@"link"], CGRectMake(0, -5, 20, 20))
        .appendNewString(@"查看链接").setupStringId(@"link").setupLink(link).setupColor([UIColor colorWithRed:0.189 green:0.45 blue:0.86 alpha:1.0]).setupFont([UIFont systemFontOfSize:15])
        .appendNewString(@"(温馨提示:点击链接操作仅在UITextView中生效)").setupColor([UIColor orangeColor]).setupFont([UIFont italicSystemFontOfSize:10]);
    self.textView.linkTextAttributes = [linkText findSubStringWithId:@"link"].attributesDictionary;
    self.textView.attributedText = linkText.attributedText;
    
    //颜色及字体示例
    WZZAttributedString * colorText = [WZZAttributedString stringWithText:@"颜色及字体示例："]
        .appendNewString(@"红色11号字").setupColor([UIColor redColor]).setupFont([UIFont systemFontOfSize:11])
        .appendNewString(@"绿色13号加粗").setupColor([UIColor greenColor]).setupFont([UIFont boldSystemFontOfSize:13])
        .appendNewString(@"蓝色20号斜体").setupFont([UIFont italicSystemFontOfSize:20]).setupColor([UIColor blueColor]);
    
    //文字阴影和下划线
    NSShadow * shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, 1);
    shadow.shadowColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    WZZAttributedString * shadowlineText = [WZZAttributedString stringWithText:@"阴影和下划线示例："]
        .appendNewString(@"文字阴影").setupShadow(shadow)
        .appendNewString(@"文字下划线").setupUnderlineColor([UIColor orangeColor]).setupUnderlineStyle(@(NSUnderlineStyleThick))
        .appendNewString(@"阴影加下划线").setupShadow(shadow).setupUnderlineColor([UIColor orangeColor]).setupUnderlineStyle(@(NSUnderlineStyleDouble));
    
    //段落
    NSString * p1 = @"和单人版相同，温蒂进入游戏时物品栏内就会有阿比盖尔之花 。不过在多人版，只要物品栏有阿比盖尔之花就能任意召唤或收回阿比盖尔，不需要等花朵绽放也不用在花朵旁杀生。多人版召唤阿比盖尔会获得 15 ";
    UIImage * sanimg = [UIImage imageNamed:@"Sanity"];
    NSString * p11 = @"，而收回会失去 15 ";
    NSString * p13 = @"，如果阿比盖尔意外死亡会失去 30  ";
    NSString * p15 = @"。温蒂也可以用阿比盖尔之花切换阿比盖尔的模式，在平静 模式，阿比盖尔会紧跟着温蒂，只有在温蒂尝试攻击，受到攻击或周围有 boss 时才会一起战斗；而在愤怒 模式，阿比盖尔会跟温蒂保持一段距离自由漂浮，并且会攻击周围任何非友善的生物。\n";
    
    NSMutableParagraphStyle * p = [[NSMutableParagraphStyle alloc] init];
    p.firstLineHeadIndent = 20;//首行缩进
    p.minimumLineHeight = 50;//最低行高
    
    //方式1手动拼接
    WZZAttributedString * pText = [WZZAttributedString stringWithText:@"段落示例：\n"].setupFont([UIFont boldSystemFontOfSize:26])
        .appendNewString(p1).setupParagraphStyle(p)
        .appendNewString(@"").setupImageAttachment(sanimg, CGRectMake(0, 0, 20, 20)).setupParagraphStyle(p)
        .appendNewString(p11).setupParagraphStyle(p)
        .appendNewString(@"").setupImageAttachment(sanimg, CGRectMake(0, 0, 20, 20)).setupParagraphStyle(p)
        .appendNewString(p13).setupParagraphStyle(p)
        .appendNewString(@"").setupImageAttachment(sanimg, CGRectMake(0, 0, 20, 20)).setupParagraphStyle(p)
        .appendNewString(p15).setupParagraphStyle(p);
    
    //方式2循环遍历
    NSString * p2 = @"阿比盖尔一开始的血量是 150 Abigail_Badge。她的血量在 1 天后会增加为 300 Abigail_Badge，再 1 天后会变为最高的 600 Abigail_Badge。如果世界上有建造完整装饰的姊妹骨灰坛，这个过程可以加速 4 倍。当温蒂或阿比盖尔死亡时，阿比盖尔的血量会变回最初阶段的 150 Abigail_Badge。阿比盖尔还有一个防御护盾，当受到第一下攻击时，护盾会抵挡接下来 0.5 秒内的所有伤害。";
    NSArray * p2Arr0 = [p2 componentsSeparatedByString:@"Abigail_Badge"];
    NSString * p2Str0 = [p2Arr0 componentsJoinedByString:@"@_@Abigail_Badge@_@"];
    NSArray * p2Arr1 = [p2Str0 componentsSeparatedByString:@"@_@"];
    for (NSString * str in p2Arr1) {
        if ([str isEqualToString:@"Abigail_Badge"]) {
            pText = pText.setupImageAttachment([UIImage imageNamed:str], CGRectMake(0, 0, 20, 20));
        } else {
            pText = pText.appendNewString(str).setupParagraphStyle(p);
        }
    }
    
    self.dataArr = [NSMutableArray array];
    [self.dataArr addObject:colorText];
    [self.dataArr addObject:shadowlineText];
    [self.dataArr addObject:pText];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    WZZAttributedString * string = self.dataArr[indexPath.row];
    cell.textLabel.attributedText = string.attributedText;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)dismissKeyBoard:(id)sender {
    [self.view endEditing:YES];
}

@end
