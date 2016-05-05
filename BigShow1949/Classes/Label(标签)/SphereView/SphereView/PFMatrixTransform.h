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

static PFMatrix PFMatrixTransform3DMakeFromPFPoint(PFPoint point) {
	CGFloat pointRef[1][4] = {{point.x, point.y, point.z, 1}};
	
	PFMatrix matrix = PFMatrixMakeFromArray(1, 4, *pointRef);
	
	return matrix;
}

static PFMatrix PFMatrixTransform3DMakeTranslation(PFPoint point) {
	CGFloat T[4][4] = {
		{1, 0, 0, 0},
		{0, 1, 0, 0},
		{0, 0, 1, 0}, 
		{point.x, point.y, point.z, 1}
	};
	
	PFMatrix matrix = PFMatrixMakeFromArray(4, 4, *T);
		
	return matrix;
}

static PFMatrix PFMatrixTransform3DMakeXRotation(PFRadian angle) {
	CGFloat c = cos(PFRadianMake(angle));
	CGFloat s = sin(PFRadianMake(angle));
	
	CGFloat T[4][4] = {
		{1, 0, 0, 0},
		{0, c, s, 0},
		{0, -s, c, 0}, 
		{0, 0, 0, 1}
	};
	
	PFMatrix matrix = PFMatrixMakeFromArray(4, 4, *T);
	
	return matrix;
}

static PFMatrix PFMatrixTransform3DMakeXRotationOnPoint(PFPoint point, PFRadian angle) {
	PFMatrix T = PFMatrixTransform3DMakeTranslation(PFPointMake(-point.x, -point.y, -point.z));
	PFMatrix R = PFMatrixTransform3DMakeXRotation(angle);
	PFMatrix T1 = PFMatrixTransform3DMakeTranslation(point);

	return PFMatrixMultiply(PFMatrixMultiply(T, R), T1);
}

static PFMatrix PFMatrixTransform3DMakeYRotation(PFRadian angle) {
	CGFloat c = cos(PFRadianMake(angle));
	CGFloat s = sin(PFRadianMake(angle));
	
	CGFloat T[4][4] = {
		{c, 0, -s, 0},
		{0, 1, 0, 0},
		{s, 0, c, 0}, 
		{0, 0, 0, 1}
	};
	
	PFMatrix matrix = PFMatrixMakeFromArray(4, 4, *T);
	
	return matrix;
}

static PFMatrix PFMatrixTransform3DMakeYRotationOnPoint(PFPoint point, PFRadian angle) {
	PFMatrix T = PFMatrixTransform3DMakeTranslation(PFPointMake(-point.x, -point.y, -point.z));
	PFMatrix R = PFMatrixTransform3DMakeYRotation(angle);
	PFMatrix T1 = PFMatrixTransform3DMakeTranslation(point);
	
	return PFMatrixMultiply(PFMatrixMultiply(T, R), T1);
}

static PFMatrix PFMatrixTransform3DMakeZRotation(PFRadian angle) {
	CGFloat c = cos(PFRadianMake(angle));
	CGFloat s = sin(PFRadianMake(angle));
	
	CGFloat T[4][4] = {
		{c, s, 0, 0},
		{-s, c, 0, 0},
		{0, 0, 1, 0}, 
		{0, 0, 0, 1}
	};
	
	PFMatrix matrix = PFMatrixMakeFromArray(4, 4, *T);
	
	return matrix;
}

static PFMatrix PFMatrixTransform3DMakeZRotationOnPoint(PFPoint point, PFRadian angle) {
	PFMatrix T = PFMatrixTransform3DMakeTranslation(PFPointMake(-point.x, -point.y, -point.z));
	PFMatrix R = PFMatrixTransform3DMakeZRotation(angle);
	PFMatrix T1 = PFMatrixTransform3DMakeTranslation(point);
	
	return PFMatrixMultiply(PFMatrixMultiply(T, R), T1);
}