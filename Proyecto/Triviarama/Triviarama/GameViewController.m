/*
 Archivo: GameViewController.m
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 20/Octubre/2014
 Fecha de última actualización: 23/Octubre/2014
 Descripción general: Controlador que maneja los elementos de la vista correspondiente al juego de la aplicacion
 
 Triviarama - Memorama que consiste en emparejar cada pregunta de trivia con su respuesta correspondiente.
 Copyright (C) 2014 - ITESM
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program. If not, see <http://www.gnu.org/licenses/>.
 
 Authors:
 
 ITESM representatives
 Ing. Martha Sordia Salinas <msordia@itesm.mx>
 Ing. Mario de la Fuente <mario.delafuente@itesm.mx>
 
 ITESM students
 Andrés Gerardo Cavazos Hernández – A01195067
 Roberto Carlos Rivera Martínez – A00618181
 Fernando Javier Garza Brambila – A01034753
 Marialicia Villarreal García – A00811095
 */

#import "GameViewController.h"
#import "ResultViewController.h"

@interface GameViewController () {
    NSMutableArray *questionsFromService;
    NSMutableArray *cardsOfGame;
    NSMutableDictionary *pairs;
    BOOL doZoom[20], zoom, goLose;
    CGPoint zoomO;
    CGAffineTransform zoomOut;
    int taps, timerCount, wrongMoves, points, indexView1,indexView2, winnerCounter;
    NSTimer *timer;
    NSDate *timerDate;
    NSDateFormatter *formatter;
    int unlockCards;
    Card *cardPair1, *cardPair2;
    UIView *viewPair1, *viewPair2;
    NSString *categoryName;
}

@end


@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    categoryName = [self prepareCategoryNameForImage:[self.dataOfMenu valueForKey:@"category"]];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackground.jpg"]];
    [self initializeZoom];
    zoom=YES;
    timerCount=0;
    formatter =   [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss"];
    timerDate= [formatter dateFromString:@"05:00"];
    points=0;
    wrongMoves=0;
    [self setBackgrounds];
    // Image View of category selected
    self.categoryImageView.image = [UIImage imageNamed:categoryName];
    unlockCards=0;
    goLose=YES;
    //Prepare connection to web service
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loading.frame = CGRectMake(0, 0, 40, 40);
    self.loading.center = self.view.center;
    [self.view addSubview:self.loading];
    winnerCounter=0;
    self.responseData = [[NSMutableData alloc] init];
    
    pairs = [[NSMutableDictionary alloc] init];
    cardsOfGame = [[NSMutableArray alloc] init];
    
    
    //Call web service
    [self loadDataWebService];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setBackgrounds{
    UIGraphicsBeginImageContext(self.cardView1.frame.size);
    UIGraphicsBeginImageContext(self.cardView1.frame.size);
    [[UIImage imageNamed:[self getImageBackgroundName:NO]] drawInRect:self.cardView1.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.cardView1.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView2.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView3.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView4.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView5.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView6.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView7.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView8.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView9.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView10.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView11.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView12.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView13.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView14.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView15.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView16.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView17.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView18.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView19.backgroundColor= [UIColor colorWithPatternImage:image];
    self.cardView20.backgroundColor= [UIColor colorWithPatternImage:image];

}

-(NSString*) getImageBackgroundName:(BOOL) side{
    if ([categoryName isEqualToString:@"Animals.png"]) {
        if (side) {
            return @"CartaAdelanteAmarillo.png";
        }
        return @"CartaAtrasAmarillo.png";
    } else if ([categoryName isEqualToString:@"BooksAuthors.png"]) {
        if (side) {
            return @"CartaAdelanteAqua.png";
        }
        return @"CartaAtrasAqua.png";
    } else if ([categoryName isEqualToString:@"Fashion.png"]) {
        if (side) {
            return @"CartaAdelanteAzul.png";
        }
        return @"CartaAtrasAzul.png";
    } else if ([categoryName isEqualToString:@"Food.png"]) {
        if (side) {
            return @"CartaAdelanteNaranja.png";
        }
        return @"CartaAtrasNaranja.png";
    } else if ([categoryName isEqualToString:@"History.png"]) {
        if (side) {
            return @"CartaAdelanteRoja.png";
        }
        return @"CartaAtrasRoja.png";
    } else if ([categoryName isEqualToString:@"Quotes.png"]) {
        if (side) {
            return @"CartaAdelanteRoja2.png";
        }
        return @"CartaAtrasRoja2.png";
    } else if ([categoryName isEqualToString:@"Science.png"]) {
        if (side) {
            return @"CartaAdelanteRosa.png";
        }
        return @"CartaAtrasRosa.png";
    } else if ([categoryName isEqualToString:@"Sports.png"]) {
        if (side) {
            return @"CartaAdelanteRosa2.png";
        }
        return @"CartaAtrasRosa2.png";
    } else if ([categoryName isEqualToString:@"TravelTourism.png"]) {
        if (side) {
            return @"CartaAdelanteTurquesa.png";
        }
        return @"CartaAtrasTurquesa.png";
    } else if ([categoryName isEqualToString:@"Movies.png"]) {
        if (side) {
            return @"CartaAdelanteVerde.png";
        }
        return @"CartaAtrasVerde.png";
    } else if ([categoryName isEqualToString:@"WordOrigins.png"]) {
        if (side) {
            return @"CartaAdelanteVerdeClaro.png";
        }
        return @"CartaAtrasVerdeClaro.png";
    } else {
        return @"-1";
    }
}
-(void) initializeZoom{
    for (int i =0; i<20; i++) {
        doZoom[i]=YES;
    }
}

- (void)increaseTimerCount
{
    timerDate = [NSDate dateWithTimeInterval:-1.0 sinceDate:timerDate];
    timerCount++;
    if (timerCount== 301 && goLose) {
        [self goToLoser];
    }
    self.timerLabel.text = [formatter stringFromDate:timerDate];
}

- (void)stopTimer
{
    [timer invalidate];
}
-(void)rotateCard:(UIView*)card location:(CGPoint)location cardObject:(Card *) cardData{
    
    [self.view bringSubviewToFront:card];
    unlockCards+=1;
    if (unlockCards==1) {
        cardPair1=cardData;
        viewPair1=card;
    }
    else if(unlockCards==2){
        cardPair2=cardData;
        viewPair2=card;
    }
    zoom=NO;
    zoomOut= CATransform3DGetAffineTransform(card.layer.transform);
    zoomO = card.layer.anchorPoint;
    UIGraphicsBeginImageContext(card.frame.size);
    [[UIImage imageNamed:[self getImageBackgroundName:YES]] drawInRect:card.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    card.backgroundColor= [UIColor colorWithPatternImage:image];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 300, 20)];
    
    [titleLabel setFont:[UIFont fontWithName: @"System Bold" size: 14.0f]];
    if([cardData isQuestion])
        titleLabel.text= @"Question";
    else
        titleLabel.text=@"Answer";
    [card addSubview:titleLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 107, 120)];
    descriptionLabel.numberOfLines = 8;
    [descriptionLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
    descriptionLabel.text= [cardData desc];
    [card addSubview:descriptionLabel];
    
  
    CGPoint pointToScaleTo = CGPointMake(location.x, location.y);
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;
    
    CGFloat scaleFactorX = 2.5f;
    CGFloat scaleFactorY = 2.5f;
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scaleFactorX, scaleFactorY);
    
    [UIView animateWithDuration:.5f delay:0.0f options:0 animations:^{
        card.layer.anchorPoint = CGPointMake(pointToScaleTo.x/(viewWidth), pointToScaleTo.y/(viewHeight));
        card.layer.transform = CATransform3DMakeAffineTransform(scaleTransform);
    } completion:^(BOOL finished) {}];
    
}

-(void) zoomOutCard: (UIView*)card{
    [UIView animateWithDuration:.5f delay:0.0f options:0 animations:^{
        card.transform = zoomOut;
        
        card.layer.anchorPoint = zoomO;
    } completion:^(BOOL finished) {}];
    zoom=YES;
    if (unlockCards==2) {
        [self evaluateCards];
    }
}

-(void) evaluateCards{
    if([[pairs objectForKey: cardPair1.desc] isEqualToString:cardPair2.desc] || [[pairs objectForKey:cardPair2.desc] isEqualToString:cardPair1.desc]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"131662__bertrof__game-sound-correct-v2" ofType:@"wav"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        [self.audioPlayer play];
        points+= cardPair1.value;
        self.pointsLabel.text = [NSString stringWithFormat:@"%d", points];
        winnerCounter++;
        if (winnerCounter==3) {
            [self goToWinner];
        }
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"131657__bertrof__game-sound-wrong" ofType:@"wav"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        [self.audioPlayer play];
        wrongMoves++;
        self.wrongMovesLabel.text = [NSString stringWithFormat:@"%d", wrongMoves];
        doZoom[indexView1]=YES;
        doZoom[indexView2]=YES;
        [self lockCard];

    }
    unlockCards=0;
}

-(void) goToLoser{
    ResultViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"lose"];
    int score = points / (wrongMoves + (timerCount/2));
    NSDictionary *dataOfScore = [[NSDictionary alloc] initWithObjectsAndKeys:self.pointsLabel.text, @"points", self.timerLabel.text, @"time", self.wrongMovesLabel.text, @"wrongMoves", [NSString stringWithFormat:@"%d", score], @"score", nil];
    [myController setDataOfScore:dataOfScore];
    [self stopTimer];
    [self.navigationController pushViewController: myController animated:YES];
}

- (void) goToWinner
{
        ResultViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"result"];
        int score = points / (wrongMoves + (timerCount/2));
        NSDictionary *dataOfScore = [[NSDictionary alloc] initWithObjectsAndKeys:self.pointsLabel.text, @"points", self.timerLabel.text, @"time", self.wrongMovesLabel.text, @"wrongMoves", [NSString stringWithFormat:@"%d", score], @"score", nil];
        [myController setDataOfScore:dataOfScore];
        [self stopTimer];
        goLose=NO;
        [self.navigationController pushViewController: myController animated:YES];
 
}

-(void) lockCard{
    UIGraphicsBeginImageContext(viewPair1.frame.size);
    [[UIImage imageNamed:[self getImageBackgroundName:NO]] drawInRect:viewPair1.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    viewPair1.backgroundColor= [UIColor colorWithPatternImage:image];
    viewPair2.backgroundColor= [UIColor colorWithPatternImage:image];
    for(UIView *view in viewPair1.subviews)
    {
        [view removeFromSuperview];
    }
    for(UIView *view in viewPair2.subviews)
    {
        [view removeFromSuperview];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    taps= [[touches anyObject] tapCount];
}

- (void) setDataOfMenu:(id)dataOfMenu
{
    _dataOfMenu = dataOfMenu;
}

- (NSString *)prepareCategoryNameForImage:(NSString *)stringCategory {
    stringCategory = [stringCategory stringByReplacingOccurrencesOfString:@"&" withString:@""];
    stringCategory = [stringCategory stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *stringCategoryImage = [[NSMutableString alloc] initWithString:stringCategory];
    [stringCategoryImage appendString:@".png"];
    stringCategory = stringCategoryImage;
    return stringCategory;
}

-(void) loadDataWebService {
    NSString *url = [[NSString alloc] initWithFormat:@"http://jservice.io/api/clues/?category=%@",[self.dataOfMenu valueForKey:@"idCategory"]];
    NSURL *myUrl = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:myUrl cachePolicy: NSURLRequestReloadIgnoringCacheData timeoutInterval:-1];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    [self.loading startAnimating];
}

-(void) assignCards {
    for(int i=0; i<20; i+=2) {
        [pairs setObject:[cardsOfGame[i] desc] forKey:[cardsOfGame[i+1] desc]];
    }
    
    for (int i = 0; i < cardsOfGame.count; i++) {
        int randomInt1 = arc4random() % [cardsOfGame count];
        int randomInt2 = arc4random() % [cardsOfGame count];
        [cardsOfGame exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
    }
    
}

#pragma mark - NSURLConnectionDelegate Protocol
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.responseData = nil;
    self.connection = nil;
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error to connect to web service" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alerta show];
    goLose=NO;
    [self.navigationController popViewControllerAnimated:YES];
    [self.loading stopAnimating];
}

#pragma mark NSURLConnectionDataDelegate Protocol
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error;
    
    //Json received like array
    questionsFromService = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    
    if(questionsFromService.count == 0) {
        //Alert message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There are no questions on the web service" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        goLose=NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        int randomQuestion;
        int rangeOfQuestions = 0;
        int maxNumberOfCards = 10;
        int points;
        int value;
        Card *myCard;
        for (int i=0; i<maxNumberOfCards; i++) {
            randomQuestion = (arc4random() % 10) + rangeOfQuestions;
            if(([[questionsFromService[randomQuestion] objectForKey:@"question"] isEqualToString:@""]) || ([[questionsFromService[randomQuestion] objectForKey:@"answer"] isEqualToString:@""])) {
                maxNumberOfCards += 1;
            } else {
                myCard= [[Card alloc]init];
                [myCard setDesc:[questionsFromService[randomQuestion] objectForKey:@"question"]];
                points = arc4random() % 2;
                value = [self getValueOfLevel:[self.dataOfMenu valueForKey:@"level"] randomValue:points];
                myCard.value = value;
                myCard.isQuestion = YES;
                [cardsOfGame addObject:myCard];
                 myCard= [[Card alloc]init];
                myCard.desc = [questionsFromService[randomQuestion] objectForKey:@"answer"];
                myCard.value = value;
                myCard.isQuestion = NO;
                [cardsOfGame addObject:myCard];
                rangeOfQuestions += 10;
            }
        }
        [self assignCards];
    }
    
    [self.loading stopAnimating];
}

- (int) getValueOfLevel:(NSString *)level randomValue:(int) value {
    if([level isEqualToString:@"Easy"]) {
        return 100;
    } else if([level isEqualToString:@"Medium"]) {
        if(value == 0)
            return 200;
        else
            return 300;
    } else if([level isEqualToString:@"Hard"]) {
        if(value == 0)
            return 400;
        else
            return 500;
    } else {
        return 0;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
    NSInteger statusCode = [httpResponse statusCode];
    NSLog(@"Connection status %li", (long)statusCode);
    
    //Initialize in 0 bytes responseData
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //Collect the response from the server
    [self.responseData appendData:data];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapCard1:(id)sender {
    if (doZoom[0] && zoom) {
    [self rotateCard:self.cardView1 location:[sender locationInView:self.view] cardObject:cardsOfGame[0]];
        doZoom[0]=NO;
        if(unlockCards==1){
            indexView1=0;
        }
        else if(unlockCards==2){
            indexView2=0;
        }
    }
    else if(taps==2 && !doZoom[0]){
        [self zoomOutCard:self.cardView1];
    }
}

- (IBAction)tapCard2:(id)sender {
    if (doZoom[1] && zoom) {
    [self rotateCard:self.cardView2 location:[sender locationInView:self.view] cardObject:cardsOfGame[1]];
        doZoom[1]=NO;
        if(unlockCards==1){
            indexView1=1;
        }
        else if(unlockCards==2){
            indexView2=1;
        }
    }
    else if(taps==2 && !doZoom[1]){
        [self zoomOutCard:self.cardView2];
    }
}

- (IBAction)tapCard3:(id)sender {
    if (doZoom[2] && zoom) {
    [self rotateCard:self.cardView3 location:[sender locationInView:self.view] cardObject:cardsOfGame[2]];
        doZoom[2]=NO;
        if(unlockCards==1){
            indexView1=2;
        }
        else if(unlockCards==2){
            indexView2=2;
        }
    }
    else if(taps==2 && !doZoom[2]){
        [self zoomOutCard:self.cardView3];
    }
}

- (IBAction)tapCard4:(id)sender {
    if (doZoom[3] && zoom) {
    [self rotateCard:self.cardView4 location:[sender locationInView:self.view] cardObject:cardsOfGame[3]];
        doZoom[3]=NO;
        if(unlockCards==1){
            indexView1=3;
        }
        else if(unlockCards==2){
            indexView2=3;
        }
    }
    else if(taps==2 && !doZoom[3]){
        [self zoomOutCard:self.cardView4];
    }
}

- (IBAction)tapCard5:(id)sender {
    if (doZoom[4] && zoom) {
    [self rotateCard:self.cardView5 location:[sender locationInView:self.view] cardObject:cardsOfGame[4]];
        doZoom[4]=NO;
        if(unlockCards==1){
            indexView1=4;
        }
        else if(unlockCards==2){
            indexView2=4;
        }
    }
    else if(taps==2 && !doZoom[4]){
        [self zoomOutCard:self.cardView5];
    }
}

- (IBAction)tapCard6:(id)sender {
    if (doZoom[5] && zoom) {
        [self rotateCard:self.cardView6 location:[sender locationInView:self.view] cardObject:cardsOfGame[5]];
        doZoom[5]=NO;
        if(unlockCards==1){
            indexView1=5;
        }
        else if(unlockCards==2){
            indexView2=5;
        }
    }
    else if(taps==2 && !doZoom[5]){
        [self zoomOutCard:self.cardView6];
    }
}

- (IBAction)tapCard7:(id)sender {
    if (doZoom[6] && zoom) {
        [self rotateCard:self.cardView7 location:[sender locationInView:self.view] cardObject:cardsOfGame[6]];
        doZoom[6]=NO;
        if(unlockCards==1){
            indexView1=6;
        }
        else if(unlockCards==2){
            indexView2=6;
        }
    }
    else if(taps==2 && !doZoom[6]){
        [self zoomOutCard:self.cardView7];
    }
}

- (IBAction)tapCard8:(id)sender {
    if (doZoom[7] && zoom) {
        [self rotateCard:self.cardView8 location:[sender locationInView:self.view] cardObject:cardsOfGame[7]];
        doZoom[7]=NO;
        if(unlockCards==1){
            indexView1=7;
        }
        else if(unlockCards==2){
            indexView2=7;
        }
    }
    else if(taps==2 && !doZoom[7]){
        [self zoomOutCard:self.cardView8];
    }
}

- (IBAction)tapCard9:(id)sender {
    if (doZoom[8] && zoom) {
        [self rotateCard:self.cardView9 location:[sender locationInView:self.view] cardObject:cardsOfGame[8]];
        doZoom[8]=NO;
        if(unlockCards==1){
            indexView1=8;
        }
        else if(unlockCards==2){
            indexView2=8;
        }
    }
    else if(taps==2 && !doZoom[8]){
        [self zoomOutCard:self.cardView9];
    }
}

- (IBAction)tapCard10:(id)sender {
    if (doZoom[9] && zoom) {
        [self rotateCard:self.cardView10 location:[sender locationInView:self.view] cardObject:cardsOfGame[9]];
        doZoom[9]=NO;
        if(unlockCards==1){
            indexView1=9;
        }
        else if(unlockCards==2){
            indexView2=9;
        }
    }
    else if(taps==2 && !doZoom[9]){
        [self zoomOutCard:self.cardView10];
    }
}

- (IBAction)tapCard11:(id)sender {
    if (doZoom[10] && zoom) {
        [self rotateCard:self.cardView11 location:[sender locationInView:self.view] cardObject:cardsOfGame[10]];
        doZoom[10]=NO;
        if(unlockCards==1){
            indexView1=10;
        }
        else if(unlockCards==2){
            indexView2=10;
        }
    }
    else if(taps==2 && !doZoom[10]){
        [self zoomOutCard:self.cardView11];
    }
}

- (IBAction)tapCard12:(id)sender {
    if (doZoom[11] && zoom) {
        [self rotateCard:self.cardView12 location:[sender locationInView:self.view] cardObject:cardsOfGame[11]];
        doZoom[11]=NO;
        if(unlockCards==1){
            indexView1=11;
        }
        else if(unlockCards==2){
            indexView2=11;
        }
    }
    else if(taps==2 && !doZoom[11]){
        [self zoomOutCard:self.cardView12];
    }
}

- (IBAction)tapCard13:(id)sender {
    if (doZoom[12] && zoom) {
        [self rotateCard:self.cardView13 location:[sender locationInView:self.view] cardObject:cardsOfGame[12]];
        doZoom[12]=NO;
        if(unlockCards==1){
            indexView1=12;
        }
        else if(unlockCards==2){
            indexView2=12;
        }
    }
    else if(taps==2 && !doZoom[12]){
        [self zoomOutCard:self.cardView13];
    }
}

- (IBAction)tapCard14:(id)sender {
    if (doZoom[13] && zoom) {
        [self rotateCard:self.cardView14 location:[sender locationInView:self.view] cardObject:cardsOfGame[13]];
        doZoom[13]=NO;
        if(unlockCards==1){
            indexView1=13;
        }
        else if(unlockCards==2){
            indexView2=13;
        }
    }
    else if(taps==2 && !doZoom[13]){
        [self zoomOutCard:self.cardView14];
    }
}

- (IBAction)tapCard15:(id)sender {
    if (doZoom[14] && zoom) {
        [self rotateCard:self.cardView15 location:[sender locationInView:self.view] cardObject:cardsOfGame[14]];
        doZoom[14]=NO;
        if(unlockCards==1){
            indexView1=14;
        }
        else if(unlockCards==2){
            indexView2=14;
        }
    }
    else if(taps==2 && !doZoom[14]){
        [self zoomOutCard:self.cardView15];
    }
}

- (IBAction)tapCard16:(id)sender {
    if (doZoom[15] && zoom) {
        [self rotateCard:self.cardView16 location:[sender locationInView:self.view] cardObject:cardsOfGame[15]];
        doZoom[15]=NO;
        if(unlockCards==1){
            indexView1=15;
        }
        else if(unlockCards==2){
            indexView2=15;
        }
    }
    else if(taps==2 && !doZoom[15]){
        [self zoomOutCard:self.cardView16];
    }
}

- (IBAction)tapCard17:(id)sender {
    if (doZoom[16] && zoom) {
        [self rotateCard:self.cardView17 location:[sender locationInView:self.view] cardObject:cardsOfGame[16]];
        doZoom[16]=NO;
        if(unlockCards==1){
            indexView1=16;
        }
        else if(unlockCards==2){
            indexView2=16;
        }
    }
    else if(taps==2 && !doZoom[16]){
        [self zoomOutCard:self.cardView17];
    }
}

- (IBAction)tapCard18:(id)sender {
    if (doZoom[17] && zoom) {
        [self rotateCard:self.cardView18 location:[sender locationInView:self.view] cardObject:cardsOfGame[17]];
        doZoom[17]=NO;
        if(unlockCards==1){
            indexView1=17;
        }
        else if(unlockCards==2){
            indexView2=17;
        }
    }
    else if(taps==2 && !doZoom[17]){
        [self zoomOutCard:self.cardView18];
    }
}

- (IBAction)tapCard19:(id)sender {
    if (doZoom[18] && zoom) {
        [self rotateCard:self.cardView19 location:[sender locationInView:self.view] cardObject:cardsOfGame[18]];
        doZoom[18]=NO;
        if(unlockCards==1){
            indexView1=18;
        }
        else if(unlockCards==2){
            indexView2=18;
        }
    }
    else if(taps==2 && !doZoom[18]){
        [self zoomOutCard:self.cardView19];
    }
}

- (IBAction)tapCard20:(id)sender {
    if (doZoom[19] && zoom) {
        [self rotateCard:self.cardView20 location:[sender locationInView:self.view] cardObject:cardsOfGame[19]];
        doZoom[19]=NO;
        if(unlockCards==1){
            indexView1=19;
        }
        else if(unlockCards==2){
            indexView2=19;
        }
    }
    else if(taps==2 && !doZoom[19]){
        [self zoomOutCard:self.cardView20];
    }
}
@end
