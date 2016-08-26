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

#import "PFMatrix.h"

struct PFPoint {
	CGFloat x;
	CGFloat y;
	CGFloat z;
};
typedef struct PFPoint PFPoint;

static PFPoint PFPointMake(CGFloat x, CGFloat y, CGFloat z) {
    PFPoint p;
	p.x = x;
	p.y = y;
	p.z = z;
	
	return p;
}

static PFPoint PFPointMakeFromMatrix(PFMatrix matrix) {
	return PFPointMake(matrix.data[0][0], matrix.data[0][1], matrix.data[0][2]);
}

static NSString *NSStringFromPFPoint(PFPoint point) {
	NSString *str = [NSString stringWithFormat:@"(%f,%f,%f)", point.x, point.y, point.z];
	
	return str;
}


#pragma mark -
#pragma mark CGPoint methods

static CGPoint CGPointMakeNormalizedPoint(CGPoint point, CGFloat distance) {
	CGPoint nPoint = CGPointMake(point.x * 1/distance, point.y * 1/distance);
	
	return nPoint;
}

