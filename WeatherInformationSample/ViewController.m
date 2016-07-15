//
//  ViewController.m
//  WeatherInformationSample
//
//  Created by hirauchi.shinichi on 2016/07/13.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *degLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{

    NSString *API_KEY = @"26axxxxxxxxxxxxxxxxxxxxxxxxxxca2";
//    NSString *hostname = @"api.openweathermap.org";
    NSString *hostname = @"localhost:3000";
    NSString *url = [NSString stringWithFormat:@"http://%@/data/2.5/weather?q=Tokyo,jp&units=metric&APPID=%@",hostname,API_KEY];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:2 error:nil];
             NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"json string: %@", json);

             NSArray  *weather = responseObject[@"weather"];
             NSDictionary  *main = responseObject[@"main"];
             NSDictionary  *wind = responseObject[@"wind"];
             NSString *url = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",weather[0][@"icon"]];
             NSData *dt = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
             self.iconImage.image = [[UIImage alloc] initWithData:dt];
             self.descriptionLabel.text = [NSString stringWithFormat:@"%@",weather[0][@"description"]];
             self.tempLabel.text = [NSString stringWithFormat:@"温度　%@",main[@"temp"]];
             self.humidityLabel.text = [NSString stringWithFormat:@"湿度　%@ ％",main[@"humidity"]];
             self.speedLabel.text = [NSString stringWithFormat:@"風速　%@ m/s",wind[@"speed"]];
             self.degLabel.text = [NSString stringWithFormat:@"風向き　%@",wind[@"deg"]];
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"ERROR");
         }
     ];
}

@end
