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

typedef enum {
	PFAxisDirectionNone,
	PFAxisDirectionPositive = 1,
	PFAxisDirectionNegative = -1
} PFAxisDirection;

static CGFloat PFAxisDirectionMinimumDistance = 0.033f;

static PFAxisDirection PFAxisDirectionMake(CGFloat fromCoordinate, CGFloat toCoordinate, BOOL sensitive) {
	PFAxisDirection direction = PFAxisDirectionNone;
	
	CGFloat distance = fabs(fromCoordinate - toCoordinate);
				
	if (distance > PFAxisDirectionMinimumDistance || sensitive) {
		if (fromCoordinate > toCoordinate) {
			direction = PFAxisDirectionPositive;
		} else if (fromCoordinate < toCoordinate) {
			direction = PFAxisDirectionNegative;
		}
	}
	
	return direction;
}

static PFAxisDirection PFDirectionMakeXAxis(CGPoint fromPoint, CGPoint toPoint) {
	return PFAxisDirectionMake(fromPoint.x, toPoint.x, NO);
}

static PFAxisDirection PFDirectionMakeYAxis(CGPoint fromPoint, CGPoint toPoint) {
	return PFAxisDirectionMake(fromPoint.y, toPoint.y, NO);
}

static PFAxisDirection PFDirectionMakeXAxisSensitive(CGPoint fromPoint, CGPoint toPoint) {
	return PFAxisDirectionMake(fromPoint.x, toPoint.x, YES);
}

static PFAxisDirection PFDirectionMakeYAxisSensitive(CGPoint fromPoint, CGPoint toPoint) {
	return PFAxisDirectionMake(fromPoint.y, toPoint.y, YES);
}