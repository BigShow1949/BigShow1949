//This file is part of SphereView.
//
//SphereView is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.
//
//SphereView is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with SphereView.  If not, see <http://www.gnu.org/licenses/>.

#import "PFGoldenSectionSpiral.h"

@implementation PFGoldenSectionSpiral

+ (NSArray *)sphere:(NSInteger)n {
	NSMutableArray* result = [NSMutableArray arrayWithCapacity:n];
	
	CGFloat N = n;
	CGFloat inc = M_PI * (3 - sqrt(5));
    CGFloat off = 2 / N;
	for (NSInteger k=0; k<N; k++) {
        CGFloat y = k * off - 1 + (off / 2);
        CGFloat r = sqrt(1 - y*y);
        CGFloat phi = k * inc;
		
		
		PFPoint point = PFPointMake(cos(phi)*r, y, sin(phi)*r);
		
		NSValue *v = [NSValue value:&point withObjCType:@encode(PFPoint)];
		
        [result addObject:v];
	}
	
	return result;
}

@end
