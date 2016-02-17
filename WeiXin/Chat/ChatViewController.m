//
//  ChatViewController.m
//  ChatDemo
//
//  Created by 张齐朴 on 16/1/6.
//  Copyright © 2016年 张齐朴. All rights reserved.
//

#import "ChatViewController.h"
#import "QPMessageModel.h"

#import "QPChatBaseCell.h"
#import "QPChatTextCell.h"
#import "QPChatAudioCell.h"
#import "QPChatImageCell.h"

#import "QPChatStateMachine.h"
#import "TextVoiceInputView.h"

#import <objc/runtime.h>

#import "XMPPManager.h"

NSString *ChatTextCellId  = @"ChatTextCellId";
NSString *ChatAudioCellId = @"ChatAudioCellId";
NSString *ChatImageCellId = @"ChatImageCellId";

@interface ChatViewController ()

@property (nonatomic, strong) QPChatStateMachine *stateMachine;

@end

@implementation ChatViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.messages     = [NSMutableArray array];
        self.stateMachine = [[QPChatStateMachine alloc] initWithChatController:self];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark LifeCycle
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self setBackgroundImage];
    [self addTapBackGesture];
    [self addInputToolBar];
    [self addEmotionView];
    [self addExtendMenuView];
    [self addMessages];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveXmppMessage:)
                                                 name:XMPPDidReceiveMessageNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:XMPPDidReceiveMessageNotification
                                                  object:nil];
}


- (void)setBackgroundImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
    self.tableView.backgroundView = imageView;
}

- (void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)addTapBackGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackAction)];
    [self.view addGestureRecognizer:tap];
}

- (void)addMessages
{
    QPMessageModel *model1 = [[QPMessageModel alloc] init];
    model1.messageType = MessageTypeText;
    model1.time = @"2016-01-01 15:37";
    model1.nickname = @"张齐朴";
    model1.content = @"文";
    model1.isLeft = YES;
    
    QPMessageModel *model11 = [[QPMessageModel alloc] init];
    model11.messageType = MessageTypeText;
    model11.time = nil;
    model11.nickname = @"张齐朴";
    model11.content = @"文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字";
    model11.isLeft = NO;
    
    QPMessageModel *model2 = [[QPMessageModel alloc] init];
    model2.messageType = MessageTypeAudio;
    model2.time = nil;
    model2.nickname = @"张齐朴";
    model2.content = @"12";
    model2.isLeft = YES;
    
    QPMessageModel *model22 = [[QPMessageModel alloc] init];
    model22.messageType = MessageTypeAudio;
    model22.time = @"2016-01-01 15:37";
    model22.nickname = @"张齐朴";
    model22.content = @"12";
    model22.isLeft = NO;
    
    QPMessageModel *model3 = [[QPMessageModel alloc] init];
    model3.messageType = MessageTypeImage;
    model3.time = @"2016-01-01 15:37";
    model3.nickname = @"张齐朴";
    model3.content = @"luyi.jpg";
    model3.isLeft = YES;
    
    QPMessageModel *model33 = [[QPMessageModel alloc] init];
    model33.messageType = MessageTypeImage;
    model33.time = nil;
    model33.nickname = @"张齐朴";
    model33.content = @"luyi.jpg";
    model33.isLeft = NO;
    
    [self.messages addObjectsFromArray:@[model1, model11, model2, model22, model3, model33]];
    
    [self.tableView reloadData];
    [self scrollToBottom];
}

- (void)insertMessageWithType:(MessageType)type andContent:(NSString *)content isLeft:(BOOL)isLeft
{
    QPMessageModel *model3 = [[QPMessageModel alloc] init];
    model3.messageType = type;
    model3.time = @"2016-01-01 15:37";
    model3.nickname = @"张齐朴";
    model3.content = content;
    model3.isLeft = isLeft;
    
    [self.messages addObject:model3];
}

- (void)addInputToolBar
{
    self.inputToolBar = [[QPInputToolBar alloc] initWithFrame:
                         CGRectMake(0,
                                    CGRectGetHeight(self.view.bounds) - kToolBarHeight,
                                    CGRectGetWidth(self.view.bounds),
                                    kToolBarHeight)];
    self.inputToolBar.inputToolBarDelegate = self;
    
    [self.view addSubview:self.inputToolBar];
    
    self.tableView.frame = CGRectMake(CGRectGetMinX(self.tableView.frame),
                                      CGRectGetMinY(self.tableView.frame),
                                      CGRectGetWidth(self.tableView.frame),
                                      CGRectGetHeight(self.tableView.frame) - kToolBarHeight);
}

- (void)addEmotionView
{
    self.emotionView = [[QPEmotionView alloc] initWithFrame:
                        CGRectMake(0,
                                   CGRectGetHeight(self.view.bounds) + kEmotionViewHeight,
                                   CGRectGetWidth(self.view.bounds),
                                   kEmotionViewHeight)];
    self.emotionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.emotionView.delegate        = self;
    
    [self.view addSubview:self.emotionView];
}

- (void)addExtendMenuView
{
    self.extendMenuView = [[QPExtendMenuView alloc] initWithFrame:
                           CGRectMake(0,
                                      CGRectGetHeight(self.view.bounds) + kExtendMenuViewHeight,
                                      CGRectGetWidth(self.view.bounds),
                                      kExtendMenuViewHeight)];
    self.extendMenuView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    [self.view addSubview:self.extendMenuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark TableViewDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义三种cell：文字（带表情） 图片 声音
    
    NSString *cellId = ChatTextCellId;
    Class class = [QPChatTextCell class];
    QPMessageModel *model = self.messages[indexPath.row];
    
    switch (model.messageType) {
        case MessageTypeText:
            cellId = ChatTextCellId;
            class = [QPChatTextCell class];
            break;
        case MessageTypeAudio:
            cellId = ChatAudioCellId;
            class = [QPChatAudioCell class];
            break;
        case MessageTypeImage:
            cellId = ChatImageCellId;
            class = [QPChatImageCell class];
            break;
            
        default:
            break;
    }
    
    QPChatBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setupContentWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QPMessageModel *model = self.messages[indexPath.row];
    
    return model.cellHeight;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark QPInputToolBarDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)inputToolBarSendText:(QPInputToolBar *)inputToolBar
{
    TextVoiceInputView *textVoiceView = self.inputToolBar.middleBarButtonItem.customView;
    UITextView *textView              = textVoiceView.inputTextView;
    
    if ([textView.text length] > 0 == NO) return;
    
    [self sendXmppMessage:textView.text];
    
    [self insertMessageWithType:MessageTypeText andContent:textView.text isLeft:NO];
    
    textView.text = @"";
    [textVoiceView textViewDidChange:textView];
    
    [self.tableView reloadData];
    [self scrollToBottom];
    
}

- (void)inputToolBarBeginTextInput:(QPInputToolBar *)inputToolBar
{
    [self.stateMachine changeToState:QPChatInputStateKeyboardUpTextInput];
}

- (void)inputToolBarLeftBarButtonItemClicked:(QPInputToolBar *)inputToolBar
{
    UIButton *leftButton = objc_getAssociatedObject(inputToolBar.leftBarButtonItem.customView, "leftButton");
    
    if (leftButton.isSelected == NO) {
        [self.stateMachine changeToState:QPChatInputStateKeyboardUpTextInput];
    } else {
        [self.stateMachine changeToState:QPChatInputStateBottomVoiceInput];
    }
}

- (void)inputToolBarRightFirstBarButtonItemClicked:(QPInputToolBar *)inputToolBar
{
    [self.view endEditing:YES];
    
    [self.stateMachine changeToState:QPChatInputStateEmotionInput];
}

- (void)inputToolBarRightSecondBarButtonItemClicked:(QPInputToolBar *)inputToolBar
{
    [self.view endEditing:YES];
    
    [self.stateMachine changeToState:QPChatInputStateExtendMenu];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark QPEmotionViewDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)emotionViewDidSelectedEmoj:(NSString *)emojiString
{
    TextVoiceInputView *textVoiceView = self.inputToolBar.middleBarButtonItem.customView;
    UITextView *textView              = textVoiceView.inputTextView;
    NSMutableAttributedString *as     = [[NSMutableAttributedString alloc] initWithString:emojiString];
    
    // 插入表情后textView字体会变，这里恢复之前设置的字体
    [textView.textStorage appendAttributedString:as];
    [textView setFont:[UIFont systemFontOfSize:14]];
    [textView setTextColor:[UIColor darkGrayColor]];
    
    [textVoiceView textViewDidChange:textView];
}

- (void)emotionViewDidSendEmoj
{
    [self inputToolBarSendText:self.inputToolBar];
}

- (void)tapBackAction
{
    [self.view endEditing:YES];
    
    [self.stateMachine changeToState:QPChatInputStateBottomTextInput];
}

- (void)scrollToBottom
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count] - 1
                                                              inSection:0]
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark XMPP Somethings
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)didReceiveXmppMessage:(NSNotification *)notification
{
    NSString *content = notification.object;
    if (!content) {
        return ;
    }
    
    [self insertMessageWithType:MessageTypeText andContent:content isLeft:YES];
    
    [self.tableView reloadData];
    [self scrollToBottom];
}

- (void)sendXmppMessage:(NSString *)content
{
    if ([content length] > 0) {
        if ([content isEqualToString:@"file"]) {
            [[XMPPManager sharedXMPPManager] fileSendingWithUserName:@"huangjiasha"];
        } else {
            [[XMPPManager sharedXMPPManager] sendMessageWithText:content];
        }
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
