
#import "PlaceholderTextView.h"

@implementation PlaceholderTextView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setPlaceholder:@""];
        
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }

    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{

    if (_placeholder != placeholder) {
        
        _placeholder = placeholder;
        
        [self.placeHolderShowLabel removeFromSuperview];
        
        self.placeHolderShowLabel = nil;
        
        [self setNeedsDisplay];
        
        
    }

}

- (void)textChanged:(NSNotification *)notification{

    if ([[self placeholder] length] == 0) {
        return;
    }
    
    if ([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }
    
    else{
    
        [[self viewWithTag:999] setAlpha:0];
    }

}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];

    if ([[self placeholder] length] > 0) {
        if (_placeHolderShowLabel == nil) {
            _placeHolderShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, 0)];
            _placeHolderShowLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderShowLabel.numberOfLines = 0;
            _placeHolderShowLabel.font = self.font;
            _placeHolderShowLabel.backgroundColor = [UIColor clearColor];
            _placeHolderShowLabel.textColor = self.placeholderColor;
            _placeHolderShowLabel.alpha = 0;
            _placeHolderShowLabel.tag = 999;
            [self addSubview:_placeHolderShowLabel];
        }
        _placeHolderShowLabel.text = self.placeholder;
        [_placeHolderShowLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderShowLabel];
    }
    
    if ([[self text] length] == 0 && [[self placeholder] length] >0) {
        [[self viewWithTag:999] setAlpha:1.0];
    }

}



@end
