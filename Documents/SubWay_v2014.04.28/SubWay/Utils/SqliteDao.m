//
//  SqliteDao.m
//  SubWay
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//





#import "SqliteDao.h"

@implementation SqliteDao

#pragma mark-查询全部的站点
+(NSMutableArray *)queryStation
{
    NSMutableArray *places=[[NSMutableArray alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db)
     {
        FMResultSet *rs = [db executeQuery:@"select ZLATITUDE,ZLONGITUDE,ZMAPX,ZMAPY,ZENGLISHNAME,ZNAME,ZOPEN,ZSTATIONID from ZSTATION"];
        while ([rs next])
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"ZLATITUDE"] forKey:@"ZLATITUDE"];
            [dict setValue:[rs objectForColumnName:@"ZLONGITUDE"] forKey:@"ZLONGITUDE"];
            [dict setValue:[rs objectForColumnName:@"ZMAPX"] forKey:@"ZMAPX"];
            [dict setValue:[rs objectForColumnName:@"ZMAPY"] forKey:@"ZMAPY"];
            [dict setValue:[rs objectForColumnName:@"ZENGLISHNAME"] forKey:@"ZENGLISHNAME"];
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
            [dict setValue:[rs objectForColumnName:@"ZOPEN"] forKey:@"ZOPEN"];
            [dict setValue:[rs objectForColumnName:@"ZSTATIONID"] forKey:@"ZSTATIONID"];
            [places addObject:dict];
        }
    }];
    return places;
}
#pragma mark-查询该站点的详细信息
+(NSMutableDictionary *)findStationDetailInfo:(NSString *)zname
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select ZLATITUDE,ZLONGITUDE,ZMAPX,ZMAPY,ZENGLISHNAME,ZNAME,ZOPEN,ZSTATIONID from ZSTATION where ZNAME=?";
        FMResultSet *rs = [db executeQuery:sql,zname];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"ZLATITUDE"] forKey:@"ZLATITUDE"];
            [dict setValue:[rs objectForColumnName:@"ZLONGITUDE"] forKey:@"ZLONGITUDE"];
            [dict setValue:[rs objectForColumnName:@"ZMAPX"] forKey:@"ZMAPX"];
            [dict setValue:[rs objectForColumnName:@"ZMAPY"] forKey:@"ZMAPY"];
            [dict setValue:[rs objectForColumnName:@"ZENGLISHNAME"] forKey:@"ZENGLISHNAME"];
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
            [dict setValue:[rs objectForColumnName:@"ZOPEN"] forKey:@"ZOPEN"];
            [dict setValue:[rs objectForColumnName:@"ZSTATIONID"] forKey:@"ZSTATIONID"];
        }
    }];
    return dict;
}
#pragma mark-根据station id查询出几号线
+(NSMutableArray *)findLineByStationId:(NSString *)name
{
     NSMutableArray *array=[[NSMutableArray alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db)
     {
         NSString *sql=@"select ZLINE from ZLINESTATION where ZSTATION=(select Z_PK from ZSTATION where ZNAME=?)";
         FMResultSet *rs = [db executeQuery:sql,name];
         
         NSMutableArray *a=[[NSMutableArray alloc]init];
         while ([rs next])
         {
             [a addObject:[rs objectForColumnName:@"ZLINE"]];
         }
         for (NSString *s in a)
         {
             FMResultSet *rs = [db executeQuery:@"select * from ZLINE where Z_PK=?",s];
             while ([rs next])
             {
                NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                [dict setValue:[rs objectForColumnName:@"ZLINENAME"] forKey:@"ZLINENAME"];
                [dict setValue:[rs objectForColumnName:@"ZLINENUMBER"] forKey:@"ZLINENUMBER"];
                [dict setValue:[rs objectForColumnName:@"ZLINEENGLISHNAME"] forKey:@"ZLINEENGLISHNAME"];
                [dict setValue:[rs objectForColumnName:@"ZCOLOR"] forKey:@"ZCOLOR"];
                [dict setValue:[rs objectForColumnName:@"ZLINEID"] forKey:@"ZLINEID"];
                [array addObject:dict];
            }
         }
     }];
    //NSLog(@"---line-%@",array);
    return array;
}
#pragma mark- 查找该站点的服务设施
+(NSMutableArray *)findDeviceByStationId:(NSString *)englishName
{
     NSMutableArray *array=[[NSMutableArray alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select ZNAME,ZLOCATION,ZCATEGORY from ZDEVICE where ZSTATION=(select Z_PK from ZSTATION where ZNAME=?)";
        FMResultSet *rs = [db executeQuery:sql,englishName];
        while ([rs next])
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
            [dict setValue:[rs objectForColumnName:@"ZLOCATION"] forKey:@"ZLOCATION"];
            [dict setValue:[rs objectForColumnName:@"ZCATEGORY"] forKey:@"ZCATEGORY"];
            [array addObject:dict];
        }
    }];
    return array;
}
#pragma mark -根据类型id查询出类型名字
+(NSMutableDictionary *)findCategoryByCategoryId:(NSString *)categoryId
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select ZNAME from ZCATEGORY where Z_PK=?";
        FMResultSet *rs = [db executeQuery:sql,categoryId];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
        }
    }];
    return dict;
}
#pragma mark- 查找该站点的出口信息
+(NSMutableArray *)findEntranceByStationId:(NSString *)englishName
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZENTRANCE where ZSTATION=(select Z_PK from ZSTATION where ZNAME=?)";
        FMResultSet *rs = [db executeQuery:sql,englishName];
        while ([rs next])
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"ZLETTER"] forKey:@"ZLETTER"];
            [dict setValue:[rs objectForColumnName:@"ZDETAIL"] forKey:@"ZDETAIL"];
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
            [dict setValue:[rs objectForColumnName:@"ZNUMBER"] forKey:@"ZNUMBER"];
            [dict setValue:[rs objectForColumnName:@"ZOPEN"] forKey:@"ZOPEN"];
            [array addObject:dict];
        }
    }];
//    for (NSString *s in array) {
//        NSLog(@"%@",s);
//    }
    return array;
}
#pragma mark- 查找该站点的起始服务时间
+(NSMutableArray *)findStartAndEndTime:(NSString *)englishName
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZSTATIONSERVICETIME where ZSTATION=(select Z_PK from ZSTATION where ZNAME=?) order by ZLASTMODIFYTIME desc";
        FMResultSet *rs = [db executeQuery:sql,englishName];
        while ([rs next])
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"ZSTARTTIME"] forKey:@"ZSTARTTIME"];
            [dict setValue:[rs objectForColumnName:@"ZENDTIME"] forKey:@"ZENDTIME"];
            [dict setValue:[rs objectForColumnName:@"ZSTATION"] forKey:@"ZSTATION"];
            [dict setValue:[rs objectForColumnName:@"ZENDSTATION"] forKey:@"ZENDSTATION"];
            [array addObject:dict];
        }
    }];
    return array;
}
#pragma mark -查询该站点去往什么方向的起终服务时间
+(NSMutableDictionary *)findStartAndEndTime1:(NSString *)name str:(NSString *)endStation
{
     NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZSTATIONSERVICETIME where ZSTATION=(select Z_PK from ZSTATION where ZNAME=?) and ZENDSTATION=(select Z_PK from ZSTATION where ZNAME=?)";
        FMResultSet *rs = [db executeQuery:sql,name,endStation];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"ZSTARTTIME"] forKey:@"ZSTARTTIME"];
            [dict setValue:[rs objectForColumnName:@"ZENDTIME"] forKey:@"ZENDTIME"];
            [dict setValue:[rs objectForColumnName:@"ZSTATION"] forKey:@"ZSTATION"];
            [dict setValue:[rs objectForColumnName:@"ZENDSTATION"] forKey:@"ZENDSTATION"];
        }
    }];
    return dict;
}
#pragma mark-根据终点站id查找终点地名
+(NSMutableDictionary *)findPlaceByEndStation:(NSString *)endStationId
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZSTATION where Z_PK=?";
        FMResultSet *rs = [db executeQuery:sql,endStationId];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
        }
    }];
    return dict;
}
#pragma mark -查询几号线的所有站点
+(NSMutableArray *)findAllPlacesByLineId:(NSString *)lineId
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZSTATION s,ZLINESTATION l where ZLINE=(select ZLINEID from ZLINE where ZLINEID=?) and s.Z_PK=l.ZSTATION";
        FMResultSet *rs = [db executeQuery:sql,lineId];
        while ([rs next])
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
            [array addObject:dict];
        }
    }];
    //NSLog(@"-%@号线的所有站点--%@",lineId,array);
    return array;
}
#pragma mark -根据起点和终点计算出票价
+(NSMutableDictionary *)findTicketPriceByStationId:(NSString *)startStationId str:(NSString *)endStationId
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZTICKETPRICE where ZSTARTSTATIONID=(select ZSTATIONID from ZSTATION where ZNAME=?) and ZENDSTATIONID=(select ZSTATIONID from ZSTATION where ZNAME=?)";
        FMResultSet *rs = [db executeQuery:sql,startStationId,endStationId];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"ZPRICE"] forKey:@"ZPRICE"];
        }
    }];
    return dict;
}
#pragma mark- 查询起始时间
+(NSMutableDictionary *)findTimeStartAndEnd:(NSString *)startStationId str:(NSString *)endStationId
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZTRAVELTIME where ZSTARTSTATIONID=(select ZSTATIONID from ZSTATION where ZNAME=?) and ZENDSTATIONID=(select ZSTATIONID from ZSTATION where ZNAME=?)";
        FMResultSet *rs = [db executeQuery:sql,startStationId,endStationId];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"ZTIME"] forKey:@"ZTIME"];
            [dict setValue:[rs objectForColumnName:@"ZSTOPTIME"] forKey:@"ZSTOPTIME"];
        }
    }];
    return dict;
}
#pragma mark - 根据地面拼音查找地点
+(NSMutableArray *)findPlaceByPinyin:(NSString *)Pinyin
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=[NSString stringWithFormat:@"select * from ZSTATION where ZPINYIN like '%@%%'",Pinyin];
        FMResultSet *rs = [db executeQuery:sql,Pinyin];
        while ([rs next])
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setValue:[rs objectForColumnName:@"ZNAME"] forKey:@"ZNAME"];
            [array addObject:dict];
        }
    }];
    return array;
}
#pragma mark - 查询该线的颜色
+(NSMutableDictionary *)findColor:(NSString *)zlineId
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [self execSqlInFmdb:^(FMDatabase *db) {
        NSString *sql=@"select * from ZLINE where ZLINEID=?";
        FMResultSet *rs = [db executeQuery:sql,zlineId];
        while ([rs next])
        {
            [dict setValue:[rs objectForColumnName:@"ZCOLOR"] forKey:@"ZCOLOR"];
        }
    }];
    return dict;
}
+ (void) execSqlInFmdb:(void (^)(FMDatabase *db))block {
   
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    if ([db open]) {
        @try {
            block(db);
        }
        @catch (NSException *exception) {
            NSLog(@"TWFmdbUtil exec sql exception: %@", exception);
        }
        @finally {
            [db close];
        }
    } else {
        NSLog(@"db open failed, path:%@, errorMsg:%@", DATABASE_PATH, [db lastError]);
    }
    db = nil;
}
#pragma mark -图片翻转
+(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
   
    CGContextSetShouldAntialias(context,true);
    CGContextSetAllowsAntialiasing(context,NO);
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
