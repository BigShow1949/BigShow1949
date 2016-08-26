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

#define PFMatrixMaxSize 4

struct PFMatrix {
	NSInteger m;
	NSInteger n;
	
	CGFloat data[PFMatrixMaxSize][PFMatrixMaxSize];
};
typedef struct PFMatrix PFMatrix;

static PFMatrix PFMatrixMake(NSInteger m, NSInteger n) {
    PFMatrix matrix;
	matrix.m = m;
	matrix.n = n;
	
	for(NSInteger i=0; i<m; i++){
		for(NSInteger j=0; j<n; j++){
			matrix.data[i][j] = 0;
		}
	}
	
	return matrix;
}

static PFMatrix PFMatrixMakeFromArray(NSInteger m, NSInteger n, CGFloat *data) {
    PFMatrix matrix = PFMatrixMake(m, n);

	for (int i=0; i<m; i++) {
		CGFloat *t = data+(i*sizeof(CGFloat));
		for (int j=0; j<n; j++) {
			matrix.data[i][j] = *(t+j);
		}
	}
	
	return matrix;
}

static PFMatrix PFMatrixMakeIdentity(NSInteger m, NSInteger n) {
	PFMatrix matrix = PFMatrixMake(m, n);
	
	for(NSInteger i=0; i<m; i++){
		matrix.data[i][i] = 1;
	}
	
	return matrix;
}

static PFMatrix PFMatrixMultiply(PFMatrix A, PFMatrix B) {
	PFMatrix R = PFMatrixMake(A.m, B.n);
	
	for(NSInteger i=0; i<A.m; i++){
		for(NSInteger j=0; j<B.n; j++){
			for(NSInteger k=0; k < A.n; k++){
				R.data[i][j] += A.data[i][k] * B.data[k][j];
			}
		}
	}
	
	return R;
}

static NSString *NSStringFromPFMatrix(PFMatrix matrix) {
	NSMutableString *str = [NSMutableString string];
	
	[str appendString:@"{"];
	for(NSInteger i=0; i<matrix.m; i++){
		[str appendString:@"\n{"];
		for(NSInteger j=0; j<matrix.n; j++){
			[str appendFormat:@"%f",matrix.data[i][j]];
			
			if (j+1 < matrix.n) {
				[str appendString:@","];
			}
		}
		[str appendString:@"}"];
		
		if (i+1 < matrix.m) {
			[str appendString:@","];
		}
	}
	[str appendString:@"\n}"];
	
	return str;
}
