//
// License: BOSL2
// BSD 2-Clause License
//
// Copyright (c) 2017-2019, Revar Desmera
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

/* [Box] */
size = 20; // [5:40]

/* [Hidden] */

// onescad: BOSL2/builtins.scad
//////////////////////////////////////////////////////////////////////
/// Undocumented LibFile: builtins.scad
///   This file has indirect calls to OpenSCAD's builtin functions and modules.
/// Includes:
///   use <BOSL2/builtins.scad>
//////////////////////////////////////////////////////////////////////


/// Section: Builtin Functions

/// Section: Builtin Modules

module _square(size,center=false) square(size,center=center);

module _color(color,a) if (color==undef || color=="default") children(); else color(color,a) children();

module _cube(size,center) cube(size,center=center);

module _cylinder(h,r1,r2,center,r,d,d1,d2) cylinder(h,r=r,d=d,r1=r1,r2=r2,d1=d1,d2=d2,center=center);

module _multmatrix(m) multmatrix(m) children();

module _translate(v) translate(v) children();

module _rotate(a,v) rotate(a=a,v=v) children();

module _scale(v) scale(v) children();

// onescad: BOSL2/std.scad
//////////////////////////////////////////////////////////////////////
// LibFile: std.scad
//   File that includes the standard BOSL include files.
// Includes:
//   include <BOSL2/std.scad>
//////////////////////////////////////////////////////////////////////

assert(version_num()>=20210100, "BOSL2 requires OpenSCAD version 2021.01 or later.");

// onescad: BOSL2/constants.scad
//////////////////////////////////////////////////////////////////////
// LibFile: constants.scad
//   Constants for directions (used with anchoring), and for specifying line termination for
//   use with geometry.scad.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Constants provided by the library
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// a value that the user should never enter randomly.
// Used internally as a sentinel for an undefined value.
_UNDEF="LRG+HX7dy89RyHvDlAKvb9Y04OTuaikpx205CTh8BSI";

// Constant: IDENT
// Synopsis: A constant, the 3D identity transformation matrix.
// SynTags: Mat
// Topics: Constants, Affine, Matrices, Transforms
// See Also: ident()
// Description: Identity transformation matrix for three-dimensional transforms.  Equal to `ident(4)`.
IDENT=ident(4);

// Section: Directional Vectors
//   Vectors useful for `rotate()`, `mirror()`, and `anchor` arguments for `cuboid()`, `cyl()`, etc.

// Constant: LEFT
// Synopsis: The left-wards (X-) direction vector constant `[-1,0,0]`.
// Topics: Constants, Vectors
// See Also: RIGHT, FRONT, BACK, UP, DOWN, CENTER
// Description: Vector pointing left.  [-1,0,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=LEFT);
LEFT  = [-1,  0,  0];

// Constant: RIGHT
// Synopsis: The right-wards (X+) direction vector constant `[1,0,0]`.
// Topics: Constants, Vectors
// See Also: LEFT, FRONT, BACK, UP, DOWN, CENTER
// Description: Vector pointing right.  [1,0,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=RIGHT);
RIGHT = [ 1,  0,  0];

// Constant: FRONT
// Aliases: FWD, FORWARD
// Synopsis: The front-wards (Y-) direction vector constant `[0,-1,0]`.
// Topics: Constants, Vectors
// See Also: LEFT, RIGHT, BACK, UP, DOWN, CENTER
// Description: Vector pointing forward.  [0,-1,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=FRONT);
FRONT = [ 0, -1,  0];

FWD = FRONT;

// Constant: BACK
// Synopsis: The backwards (Y+) direction vector constant `[0,1,0]`.
// Topics: Constants, Vectors
// See Also: LEFT, RIGHT, FRONT, UP, DOWN, CENTER
// Description: Vector pointing back.  [0,1,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=BACK);
BACK  = [ 0,  1,  0];

// Constant: BOTTOM
// Aliases: BOT, DOWN
// Synopsis: The down-wards (Z-) direction vector constant `[0,0,-1]`.
// Topics: Constants, Vectors
// See Also: LEFT, RIGHT, FRONT, BACK, UP, CENTER
// Description: Vector pointing down.  [0,0,-1]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=BOTTOM);
BOTTOM  = [ 0,  0, -1];

BOT = BOTTOM;

DOWN = BOTTOM;

// Constant: TOP
// Aliases: UP
// Synopsis: The top-wards (Z+) direction vector constant `[0,0,1]`.
// Topics: Constants, Vectors
// See Also: LEFT, RIGHT, FRONT, BACK, DOWN, CENTER
// Description: Vector pointing up.  [0,0,1]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=TOP);
TOP = [ 0,  0,  1];

UP = TOP;

// Constant: CENTER
// Aliases: CTR, CENTRE
// Synopsis: The center vector constant `[0,0,0]`.
// Topics: Constants, Vectors
// See Also: LEFT, RIGHT, FRONT, BACK, UP, DOWN
// Description: Zero vector.  Centered.  [0,0,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=CENTER);
CENTER = [ 0,  0,  0];

CTR = CENTER;

// Section: Line specifiers
//   Used by functions in geometry.scad for specifying whether two points
//   are treated as an unbounded line, a ray with one endpoint, or a segment
//   with two endpoints.  

// Constant: SEGMENT
// Synopsis: A constant for specifying a line segment in various geometry.scad functions.  `[true,true]`
// Topics: Constants, Lines
// See Also: RAY, LINE
// Description: Treat a line as a segment.  [true, true]
// Example: Usage with line_intersection:
//    line1 = 10*[[9, 4], [5, 7]];
//    line2 = 10*[[2, 3], [6, 5]];
//    isect = line_intersection(line1, line2, SEGMENT, SEGMENT);
SEGMENT = [true,true];

// Constant: RAY
// Synopsis: A constant for specifying a ray line in various geometry.scad functions.  `[true,false]`
// Topics: Constants, Lines
// See Also: SEGMENT, LINE
// Description: Treat a line as a ray, based at the first point extending through the second point.  [true, false]
// Example: Usage with line_intersection:
//    line = [[-30,0],[30,30]];
//    pt = [40,25];
//    closest = line_closest_point(line,pt,RAY);
RAY = [true, false];

// Constant: LINE
// Synopsis: A constant for specifying an unbounded line in various geometry.scad functions.  `[false,false]`
// Topics: Constants, Lines
// See Also: RAY, SEGMENT
// Description: Treat a line as an unbounded line.  [false, false]
// Example: Usage with line_intersection:
//    line1 = 10*[[9, 4], [5, 7]];
//    line2 = 10*[[2, 3], [6, 5]];
//    isect = line_intersection(line1, line2, LINE, SEGMENT);
LINE = [false, false];

// onescad: BOSL2/transforms.scad
//////////////////////////////////////////////////////////////////////
// LibFile: transforms.scad
//   Functions and modules that provide shortcuts for translation,
//   rotation and mirror operations.  Also provided are skew and frame_map,
//   which remaps the coordinate axes.  The shortcuts can act on
//   geometry, like the usual OpenSCAD rotate() and translate(). They
//   also work as functions that operate on lists of points in various
//   forms: paths, VNFS and bezier patches. Lastly, the function form
//   of the shortcuts can return a matrix representing the operation
//   the shortcut performs. The rotation and scaling shortcuts accept
//   an optional centerpoint for the rotation or scaling operation.
//   .
//   Almost all of the transformation functions take a point, a point
//   list, bezier patch, or VNF as a second positional argument to
//   operate on.  The exceptions are rot(), frame_map() and skew().
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Shortcuts for translation, rotation, etc.  Can act on geometry, paths, or can return a matrix.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Affine Transformations
//   OpenSCAD provides various built-in modules to transform geometry by
//   translation, scaling, rotation, and mirroring.  All of these operations
//   are affine transformations.  A three-dimensional affine transformation
//   can be represented by a 4x4 matrix.  The transformation shortcuts in this
//   file generally have three modes of operation.  They can operate
//   directly on geometry like their OpenSCAD built-in equivalents.  For example,
//   `left(10) cube()`.  They can operate on a list of points (or various other
//   types of geometric data).  For example, operating on a list of points: `points = left(10, [[1,2,3],[4,5,6]])`.
//   The third option is that the shortcut can return the transformation matrix
//   corresponding to its action.  For example, `M=left(10)`.
//   .
//   This capability allows you to store and manipulate transformations, and can
//   be useful in more advanced modeling.  You can multiply these matrices
//   together, analogously to applying a sequence of operations with the
//   built-in transformations.  So you can write `zrot(37)left(5)cube()`
//   to perform two operations on a cube.  You can also store
//   that same transformation by multiplying the matrices together: `M = zrot(37) * left(5)`.
//   Note that the order is exactly the same as the order used to apply the transformation.
//   .
//   Suppose you have constructed `M` as above.  What now?  You can use
//   the OpensCAD built-in `multmatrix` to apply it to some geometry:  `multmatrix(M) cube()`.
//   Alternative you can use the BOSL2 function `apply` to apply `M` to a point, a list
//   of points, a bezier patch, or a VNF.  For example, `points = apply(M, [[3,4,5],[5,6,7]])`.
//   Note that the `apply` function can work on both 2D and 3D data, but if you want to
//   operate on 2D data, you must choose transformations that don't modify z
//   .
//   You can use matrices as described above without understanding the details, just
//   treating a matrix as a box that stores a transformation.  The OpenSCAD manual section for multmatrix
//   gives some details of how this works.  We'll elaborate a bit more below.  An affine transformation
//   matrix for three dimensional data is a 4x4 matrix.  The top left 3x3 portion gives the linear
//   transformation to apply to the data.  For example, it could be a rotation or scaling, or combination of both.
//   The 3x1 column at the top right gives the translation to apply.  The bottom row should be `[0,0,0,1]`.  That
//   bottom row is only present to enable
//   the matrices to be multiplied together.  OpenSCAD ignores it and in fact `multmatrix` 
//   accepts a 3x4 matrix, where that row is missing.  In order for a matrix to act on a point you have to
//   augment the point with an extra 1, making it a length 4 vector.  In OpenSCAD you can then compute the
//   the affine transformed point as `tran_point = M * point`.  However, this syntax hides a complication that
//   arises if you have a list of points.  A list of points like `[[1,2,3,1],[4,5,6,1],[7,8,9,1]]` has the augmented points
//   as row vectors on the list.  In order to transform such a list, it needs to be muliplied on the right
//   side, not the left side.
_NO_ARG = [true,[123232345],false];

function move(v=[0,0,0], p=_NO_ARG) =
    is_string(v) ? (
        assert(is_vnf(p) || is_path(p),"String movements only work with point lists and VNFs")
        let(
             center = v=="centroid" ? centroid(p)
                    : v=="mean" ? mean(p)
                    : v=="box" ? mean(pointlist_bounds(p))
                    : assert(false,str("Unknown string movement ",v))
        )
        move(-center,p=p)
      )
    :
    assert(is_vector(v) && (len(v)==3 || len(v)==2), "Invalid value for `v`")
    let(
        m = affine3d_translate(point3d(v))
    )
    p==_NO_ARG ? m : apply(m, p);

function translate(v=[0,0,0], p=_NO_ARG) = move(v=v, p=p);

// Function&Module: right()
// Aliases: xmove()
//
// Synopsis: Translates children rightward (X+).
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Translation
// See Also: move(), left(), fwd(), back(), down(), up()
//
// Usage: As Module
//   right(x) CHILDREN;
// Usage: Translate Points
//   pts = right(x, p);
// Usage: Get Translation Matrix
//   mat = right(x);
//
// Description:
//   Moves geometry or data to the right (in the X+ direction) by the specified amount.  (If `x` is negative motion is to the left.)
//   * If called as a module, moves all children right.
//   * If called as a function with the `p` argument, returns the translated version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without the `p` argument, returns a 4x4 tranformation matrix.
//   . 
//   You can also call this as `xmove()`.  
// Arguments:
//   x = Scalar amount to move right.
//   p = (function only) A point, list of points or VNF to be translated.
//
// Example:
//   #sphere(d=10);
//   right(20) sphere(d=10);
//
// Example(NORENDER):
//   pt1 = right(20, [23,42]);           // Returns: [43,42]
//   pt2 = right(20, [15,23,42]);        // Returns: [35,23,42]
//   pt3 = right(3, [[1,2,3],[4,5,6]]);  // Returns: [[4,2,3], [7,5,6]]
//   pt4 = xmove(-2, [1,2,3]);           // Returns: [-1,2,3]
//   mat3d = right(4);  // Returns: [[1,0,0,4],[0,1,0,0],[0,0,1,0],[0,0,0,1]]
module right(x=0, p) {
    req_children($children);    
    assert(is_undef(p), "Module form `right()` does not accept p= argument.");
    assert(is_finite(x), "Invalid number")
    translate__1([x,0,0]) children();
}

function fwd(y=0, p=_NO_ARG) =
    assert(is_finite(y), "Invalid number")
    move([0,-y,0],p=p);

// Function&Module: back()
// Aliases: ymove()
//
// Synopsis: Translates children backward (Y+).
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Translation
// See Also: move(), left(), right(), fwd(), down(), up()
//
// Usage: As Module
//   back(y) CHILDREN;
// Usage: Translate Points
//   pts = back(y, p);
// Usage: Get Translation Matrix
//   mat = back(y);
//
// Description:
//   Moves geometry or data forward (in the Y+ direction) by the specified amount.  (If `y` is negative motion is forward.)
//   * If called as a module, moves all children forward.
//   * If called as a function with the `p` argument, returns the translated version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without the `p` argument, returns a 4x4 transformation matrix.
//   .
//   You can also call this as `ymove()`.  
// Arguments:
//   y = Scalar amount to move back.
//   p = (function only) A point, list of points or VNF to be translated.
//
// Example:
//   #sphere(d=10);
//   back(20) sphere(d=10);
//
// Example(NORENDER):
//   pt1 = back(20, [23,42]);           // Returns: [23,62]
//   pt2 = back(20, [15,23,42]);        // Returns: [15,43,42]
//   pt3 = back(3, [[1,2,3],[4,5,6]]);  // Returns: [[1,5,3], [4,8,6]]
//   pt4 = ymove(4, [2,2,2]);             // Returns: [2,6,2]
//   mat3d = back(4);  // Returns: [[1,0,0,0],[0,1,0,4],[0,0,1,0],[0,0,0,1]]
module back(y=0, p) {
    req_children($children);    
    assert(is_undef(p), "Module form `back()` does not accept p= argument.");
    assert(is_finite(y), "Invalid number")
    translate__1([0,y,0]) children();
}

function back(y=0,p=_NO_ARG) =
    assert(is_finite(y), "Invalid number")
    move([0,y,0],p=p);

// Function&Module: down()
//
// Synopsis: Translates children downward (Z-).
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Translation
// See Also: move(), left(), right(), fwd(), back(), up()
//
// Usage: As Module
//   down(z) CHILDREN;
// Usage: Translate Points
//   pts = down(z, p);
// Usage: Get Translation Matrix
//   mat = down(z);
//
// Description:
//   Moves geometry or data dwon (in the Z- direction) by the specified amount.  (If `z` is negative motion is upward.)
//   * If called as a module, moves all children down.
//   * If called as a function with the `p` argument, returns the translated version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without the `p` argument, returns a 4x4 transformation matrix. 
//
// Arguments:
//   z = Scalar amount to move down
//   p = Either a point, or a list of points to be translated when used as a function.
//
// Example:
//   #sphere(d=10);
//   down(20) sphere(d=10);
//
// Example(NORENDER):
//   pt1 = down(20, [15,23,42]);        // Returns: [15,23,22]
//   pt2 = down(3, [[1,2,3],[4,5,6]]);  // Returns: [[1,2,0], [4,5,3]]
//   mat3d = down(4);  // Returns: [[1,0,0,0],[0,1,0,0],[0,0,1,-4],[0,0,0,1]]
module down(z=0, p) {
    req_children($children);    
    assert(is_undef(p), "Module form `down()` does not accept p= argument.");
    translate__1([0,0,-z]) children();
}

function down(z=0, p=_NO_ARG) =
    assert(is_finite(z), "Invalid number")
    move([0,0,-z],p=p);

// Function&Module: up()
// Aliases: zmove()
//
// Synopsis: Translates children upward (Z+).
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Translation
// See Also: move(), left(), right(), fwd(), back(), down()
//
// Usage: As Module
//   up(z) CHILDREN;
// Usage: Translate Points
//   pts = up(z, p);
// Usage: Get Translation Matrix
//   mat = up(z);
//
// Description:
//   Moves geometry or data up (in the Z+ direction) by the specified amount.  (If `z` is negative motion is downward.)
//   * If called as a module, moves all children up
//   * If called as a function with the `p` argument, returns the translated version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without the `p` argument, returns a 4x4 transformation matrix.
//   .
//   You can also call this as `zmove()`.  
// Arguments:
//   z = Scalar amount to move up.
//   p = Either a point, or a list of points to be translated when used as a function.
//
// Example:
//   #sphere(d=10);
//   up(20) sphere(d=10);
//
// Example(NORENDER):
//   pt1 = up(20, [15,23,42]);        // Returns: [15,23,62]
//   pt2 = up(3, [[1,2,3],[4,5,6]]);  // Returns: [[1,2,6], [4,5,9]]
//   p53 = zmove(-2, [3,3,3]);        // Returns: [3,3,1]
//   mat3d = up(4);  // Returns: [[1,0,0,0],[0,1,0,0],[0,0,1,4],[0,0,0,1]]
module up(z=0, p) {
    req_children($children);      
    assert(is_undef(p), "Module form `up()` does not accept p= argument.");
    assert(is_finite(z), "Invalid number");
    translate__1([0,0,z]) children();
}

function up(z=0, p=_NO_ARG) =
    assert(is_finite(z), "Invalid number")
    move([0,0,z],p=p);

//////////////////////////////////////////////////////////////////////
// Section: Rotations
//////////////////////////////////////////////////////////////////////


// Function&Module: rot()
//
// Synopsis: Rotates children in various ways.
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: xrot(), yrot(), zrot(), tilt()
//
// Usage: As a Module
//   rot(a, [cp=], [reverse=]) CHILDREN;
//   rot([X,Y,Z], [cp=], [reverse=]) CHILDREN;
//   rot(a, v, [cp=], [reverse=]) CHILDREN;
//   rot(from=, to=, [a=], [reverse=]) CHILDREN;
// Usage: As a Function to transform data in `p`
//   pts = rot(a, p=, [cp=], [reverse=]);
//   pts = rot([X,Y,Z], p=, [cp=], [reverse=]);
//   pts = rot(a, v, p=, [cp=], [reverse=]);
//   pts = rot([a], from=, to=, p=, [reverse=]);
// Usage: As a Function to return a transform matrix
//   M = rot(a, [cp=], [reverse=]);
//   M = rot([X,Y,Z], [cp=], [reverse=]);
//   M = rot(a, v, [cp=], [reverse=]);
//   M = rot(from=, to=, [a=], [reverse=]);
//
// Description:
//   This is an expanded version of the built-in `rotate()` that behaves identically to the built-in with the same arguments,
//   but offers additional capabilities.  
//   You can specify the rotation to perform in one of several ways:
//   * `rot(30)` or `rot(a=30)` rotates 30 degrees around the Z axis.
//   * `rot([20,30,40])` or `rot(a=[20,30,40])` rotates 20 degrees around the X axis, then 30 degrees around the Y axis, then 40 degrees around the Z axis.
//   * `rot(30, [1,1,0])` or `rot(a=30, v=[1,1,0])` rotates 30 degrees around the axis vector `[1,1,0]` (in the right-hand direction).  
//   * `rot(from=[0,0,1], to=[1,0,0])` rotates the `from` vector to line up with the `to` vector, in this case the top to the right and hence equivalent to `rot(a=90,v=[0,1,0]`.  The axis of rotation is perpendicular to the two given vectors.  
//   * `rot(from=[0,1,1], to=[1,1,0], a=45)` rotates 45 degrees around the `from` vector ([0,1,1]) and then rotates the `from` vector to align with the `to` vector.  Equivalent to `rot(from=[0,1,1],to=[1,1,0]) rot(a=45,v=[0,1,1])`.  You can also regard `a` as as post-rotation around the `to` vector.  For this form, `a` must be a scalar.
//   * If the `cp` centerpoint argument is given, then rotations are performed around that centerpoint.  So `rot(args...,cp=[1,2,3])` is equivalent to `move(-[1,2,3])rot(args...)move([1,2,3])`.
//   * If the `reverse` argument is true, then the rotations performed is exactly reversed.
//   .
//   The behavior and return value varies depending on how `rot()` is called:
//   * If called as a module, rotates all children.
//   * If called as a function with the `p=` argument, returns the rotated version of that `p=` argument.  The `p=` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without a `p` argument, returns the 4x4 rotation matrix.
//   .
//   This function (and sometimes {{frame_map()}} are the only two transformations that require
//   that the `p=` argument be given as a named argument rather than a positional argument.  
//
// Arguments:
//   a = Scalar angle or vector of XYZ rotation angles to rotate by, in degrees.  If you use the `from` and `to` arguments then `a` must be a scalar.  Default: `0`
//   v = vector for the axis of rotation.  Default: [0,0,1] or UP
//   ---
//   from = Starting vector for vector-based rotations.
//   to = Target vector for vector-based rotations.
//   cp = centerpoint to rotate around. Default: [0,0,0]
//   reverse = If true, exactly reverses the rotation, including axis rotation ordering.  Default: false
//   p = (function only) A point, list of points, Bezier patch or VNF to be rotated. 
//
// Example:
//   #cube([2,4,9]);
//   rot([30,60,0], cp=[0,0,9]) cube([2,4,9]);
//
// Example:
//   #cube([2,4,9]);
//   rot(30, v=[1,1,0], cp=[0,0,9]) cube([2,4,9]);
//
// Example:
//   #cube([2,4,9]);
//   rot(from=UP, to=LEFT+BACK) cube([2,4,9]);
//
// Example(2D):
//   path = square([50,30], center=true);
//   #stroke(path, closed=true);
//   stroke(rot(30,p=path), closed=true);
module rot(a=0, v, cp, from, to, reverse=false)
{
    req_children($children);        
    m = rot(a=a, v=v, cp=cp, from=from, to=to, reverse=reverse);
    multmatrix__1(m) children();
}

function rot(a=0, v, cp, from, to, reverse=false, p=_NO_ARG) =
    assert(is_undef(from)==is_undef(to), "from and to must be specified together.")
    assert(is_undef(from) || is_vector(from, zero=false), "'from' must be a non-zero vector.")
    assert(is_undef(to) || is_vector(to, zero=false), "'to' must be a non-zero vector.")
    assert(is_undef(v) || is_vector(v, zero=false), "'v' must be a non-zero vector.")
    assert(is_undef(cp) || is_vector(cp), "'cp' must be a vector.")
    assert(is_finite(a) || is_vector(a), "'a' must be a finite scalar or a vector.")
    assert(is_bool(reverse))
    let(
        m = let(
                from = is_undef(from)? undef : point3d(from),
                to = is_undef(to)? undef : point3d(to),
                cp = is_undef(cp)? undef : point3d(cp),
                m1 = !is_undef(from) ?
                        assert(is_num(a)) 
                        affine3d_rot_from_to(from,to) * affine3d_rot_by_axis(from,a)
                   : !is_undef(v)?
                        assert(is_num(a))
                        affine3d_rot_by_axis(v,a)
                   : is_num(a) ? affine3d_zrot(a)
                   : affine3d_zrot(a.z) * affine3d_yrot(a.y) * affine3d_xrot(a.x),
                m2 = is_undef(cp)? m1 : (move(cp) * m1 * move(-cp)),
                m3 = reverse? rot_inverse(m2) : m2
            ) m3
    )
    p==_NO_ARG ? m : apply(m, p);

// Function&Module: xrot()
//
// Synopsis: Rotates children around the X axis using the right-hand rule.
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), yrot(), zrot(), tilt()
//
// Usage: As Module
//   xrot(a, [cp=]) CHILDREN;
// Usage: As a function to rotate points
//   rotated = xrot(a, p, [cp=]);
// Usage: As a function to return rotation matrix
//   mat = xrot(a, [cp=]);
//
// Description:
//   Rotates around the X+ axis by the given number of degrees.  If `cp` is given, rotate around that center point.
//   * If called as a module, rotates all children.
//   * If called as a function with the `p` argument, returns the rotated version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without a `p` argument, returns the 4x4 rotation matrix.
//
// Arguments:
//   a = Rotation angle in degrees. 
//   p = (function only) A point, list of points, Bezier patch or VNF to be rotated. 
//   ---
//   cp = center point to rotate around. Default: [0,0,0]
//
// Example:
//   #cylinder(h=50, r=10, center=true);
//   xrot(90) cylinder(h=50, r=10, center=true);
module xrot(a=0, p, cp)
{
    req_children($children);          
    assert(is_undef(p), "Module form `xrot()` does not accept p= argument.");
    if (a==0) {
        children();  // May be slightly faster?
    } else if (!is_undef(cp)) {
        translate__1(cp) rotate__1([a, 0, 0]) translate__1(-cp) children();
    } else {
        rotate__1([a, 0, 0]) children();
    }
}

function xrot(a=0, p=_NO_ARG, cp) = rot([a,0,0], cp=cp, p=p);

// Function&Module: yrot()
//
// Synopsis: Rotates children around the Y axis using the right-hand rule.
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), zrot(), tilt()
//
// Usage: As Module
//   yrot(a, [cp=]) CHILDREN;
// Usage: Rotate Points
//   rotated = yrot(a, p, [cp=]);
// Usage: Get Rotation Matrix
//   mat = yrot(a, [cp=]);
//
// Description:
//   Rotates around the Y+ axis by the given number of degrees.  If `cp` is given, rotate around that center point. 
//   * If called as a module, rotates all children.
//   * If called as a function with the `p` argument, returns the rotated version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without a `p` argument, returns the 4x4 rotation matrix.
//
// Arguments:
//   a = Rotation angle in degrees.
//   p = (function only) A point, list of points, Bezier patch or VNF to be rotated. 
//   ---
//   cp = center point to rotate around. Default: [0,0,0]
//
// Example:
//   #cylinder(h=50, r=10, center=true);
//   yrot(90) cylinder(h=50, r=10, center=true);
module yrot(a=0, p, cp)
{
    req_children($children);  
    assert(is_undef(p), "Module form `yrot()` does not accept p= argument.");
    if (a==0) {
        children();  // May be slightly faster?
    } else if (!is_undef(cp)) {
        translate__1(cp) rotate__1([0, a, 0]) translate__1(-cp) children();
    } else {
        rotate__1([0, a, 0]) children();
    }
}

// Function&Module: zrot()
//
// Synopsis: Rotates children around the Z axis using the right-hand rule.
// Topics: Affine, Matrices, Transforms, Rotation
// SynTags: Trans, Path, VNF, Mat
// See Also: rot(), xrot(), yrot(), tilt()
//
// Usage: As Module
//   zrot(a, [cp=]) CHILDREN;
// Usage: As Function to rotate points
//   rotated = zrot(a, p, [cp=]);
// Usage: As Function to return rotation matrix
//   mat = zrot(a, [cp=]);
//
// Description:
//   Rotates around the Z+ axis by the given number of degrees.  If `cp` is given, rotate around that center point.
//   * If called as a module, rotates all children.
//   * If called as a function with the `p` argument, returns the rotated version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without a `p` argument, returns the 4x4 rotation matrix.
//
// Arguments:
//   a = Rotation angle in degrees.
//   p = (function only) A point, list of points, Bezier patch or VNF to be rotated. 
//   ---
//   cp = centerpoint to rotate around. Default: [0,0,0]
//
// Example:
//   #cube(size=[60,20,40], center=true);
//   zrot(90) cube(size=[60,20,40], center=true);
module zrot(a=0, p, cp)
{
    req_children($children);    
    assert(is_undef(p), "Module form `zrot()` does not accept p= argument.");
    if (a==0) {
        children();  // May be slightly faster?
    } else if (!is_undef(cp)) {
        translate__1(cp) rotate__1(a) translate__1(-cp) children();
    } else {
        rotate__1(a) children();
    }
}

function zrot(a=0, p=_NO_ARG, cp) = rot(a, cp=cp, p=p);

//////////////////////////////////////////////////////////////////////
// Section: Scaling
//////////////////////////////////////////////////////////////////////


// Function&Module: scale()
//
// Synopsis: Scales children arbitrarily.
// SynTags: Trans, Path, VNF, Mat, Ext
// Topics: Affine, Matrices, Transforms, Scaling
// See Also: xscale(), yscale(), zscale()
//
// Usage: As Module (native OpenSCAD)
//   scale(SCALAR) CHILDREN;
//   scale([X,Y,Z]) CHILDREN;
// Usage: As module with center point (BOSL2 extension)
//   scale(v, cp=) CHILDREN;
// Usage: As module with with scaling direction vector (BOSL2 extension)
//   scale(v, dir=, [cp=]) CHILDREN;
// Usage: Scale Points
//   pts = scale(v, p, [cp=], [dir=]);
// Usage: Get Scaling Matrix
//   mat = scale(v, [cp=], [dir=]);
//
// Description:
//   Scales by the [X,Y,Z] scaling factors given in `v`.  If `v` is given as a scalar number, all axes are scaled uniformly by that amount.  
//   If `v` has fewer than three dimensions, it is padded with 1 values, so scaling by [4] is the same as [4,1,1].  If you give `cp` a 
//   vector value then the scaling is done relative to that specified center point.  If you give the vector `dir` then the scale factor, `v`, must
//   be a scalar and the scaling occurs along the direction of `dir`.  (The sign and magnitude of `dir` don't matter.)
//   * If called as the built-in module, scales all children.
//   * If called as a function with the `p` argument, returns the scaled version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * If called as a function without a `p` argument, returns a 4x4 transformation matrix. 
//
// Arguments:
//   v = Either a numeric uniform scaling factor, or a list of [X,Y,Z] scaling factors.  Default: 1
//   p = (function only) A point, list of points, Bezier patch or VNF to scale.
//   ---
//   cp = If given, centers the scaling on the point `cp`.
//   dir = If given as a vector, scale along the direction of that vector.
//
// Example(NORENDER):
//   pt1 = scale(3, [3,1,4]);        // Returns: [9,3,12]
//   pt2 = scale([2,3,4], [3,1,4]);  // Returns: [6,3,16]
//   pt3 = scale([2,3,4], [[1,2,3],[4,5,6]]);  // Returns: [[2,6,12], [8,15,24]]
//   mat2d = scale([2,3]);    // Returns: [[2,0,0],[0,3,0],[0,0,1]]
//   mat3d = scale([2,3,4]);  // Returns: [[2,0,0,0],[0,3,0,0],[0,0,4,0],[0,0,0,1]]
//
// Example(2D):
//   path = circle(d=50,$fn=12);
//   #stroke(path,closed=true);
//   stroke(scale([1.5,3],path),closed=true);
function scale(v=1, p=_NO_ARG, cp=[0,0,0],dir) =
    assert(is_num(v) || is_vector(v),"Invalid scale")
    assert(p==_NO_ARG || is_list(p),"Invalid point list")
    assert(is_undef(dir) || is_vector(dir),"Invalid dir vector")
    assert(is_vector(cp))
    let(
        m = is_def(dir)? assert(is_num(v),"v must be a scalar when dir is given")
                         assert(len(dir)<=3 && norm(dir)>0, "dir must be a nonzero vector with 3 or fewer entries")
                         rot(from=dir,to=RIGHT,reverse=true)
                           * xscale(v,cp=rot(from=dir,to=RIGHT,p=cp))
                           * rot(from=dir,to=RIGHT)
          :
            let(v=force_list(v,3))
            cp==[0,0,0] ? affine3d_scale(v)
          : affine3d_translate(point3d(cp))
            * affine3d_scale(v)
            * affine3d_translate(point3d(-cp))
    )
    p==_NO_ARG? m : apply(m, p) ;

function xscale(x=1, p=_NO_ARG, cp=0) =
    assert(is_finite(x))
    assert(p==_NO_ARG || is_list(p))
    assert(is_finite(cp) || is_vector(cp))
    let( cp = is_num(cp)? [cp,0,0] : cp )
    scale([x,1,1], cp=cp, p=p);

function yscale(y=1, p=_NO_ARG, cp=0) =
    assert(is_finite(y))
    assert(p==_NO_ARG || is_list(p))
    assert(is_finite(cp) || is_vector(cp))
    let( cp = is_num(cp)? [0,cp,0] : cp )
    scale([1,y,1], cp=cp, p=p);

function zscale(z=1, p=_NO_ARG, cp=0) =
    assert(is_finite(z))
    assert(is_undef(p) || is_list(p))
    assert(is_finite(cp) || is_vector(cp))
    let( cp = is_num(cp)? [0,0,cp] : cp )
    scale([1,1,z], cp=cp, p=p);

//////////////////////////////////////////////////////////////////////
// Section: Reflection (Mirroring)
//////////////////////////////////////////////////////////////////////

// Function&Module: mirror()
//
// Synopsis: Reflects children across an arbitrary plane.
// SynTags: Trans, Path, VNF, Mat, Ext
// Topics: Affine, Matrices, Transforms, Reflection, Mirroring
// See Also: xflip(), yflip(), zflip()
//
// Usage: As Module
//   mirror(v) CHILDREN;
// Usage: As Function
//   pt = mirror(v, p);
// Usage: Get Reflection/Mirror Matrix
//   mat = mirror(v);
//
// Description:
//   Mirrors/reflects across the plane or line whose normal vector is given in `v`.
//   * Called as the built-in module, mirrors all children.
//   * If called as a function with the `p` argument, returns the mirrored version of that `p` argument.  The `p` argument can be a point, list of points, [bezier patch](beziers.scad) or [VNF structure](vnf.scad).
//   * Called as a function without a `p` argument, returns a 4x4 transformation matrix. 
//
// Arguments:
//   v = The normal vector of the line or plane to mirror across.
//   p = (function only) A point, list of points, Bezier patch or VNF to reflect.
//
// Example:
//   n = [1,0,0];
//   module obj() right(20) rotate([0,15,-15]) cube([40,30,20]);
//   obj();
//   mirror(n) obj();
//   rot(a=atan2(n.y,n.x),from=UP,to=n) {
//       color("red") anchor_arrow(s=20, flag=false);
//       color("#7777") cube([75,75,0.1], center=true);
//   }
//
// Example:
//   n = [1,1,0];
//   module obj() right(20) rotate([0,15,-15]) cube([40,30,20]);
//   obj();
//   mirror(n) obj();
//   rot(a=atan2(n.y,n.x),from=UP,to=n) {
//       color("red") anchor_arrow(s=20, flag=false);
//       color("#7777") cube([75,75,0.1], center=true);
//   }
//
// Example:
//   n = [1,1,1];
//   module obj() right(20) rotate([0,15,-15]) cube([40,30,20]);
//   obj();
//   mirror(n) obj();
//   rot(a=atan2(n.y,n.x),from=UP,to=n) {
//       color("red") anchor_arrow(s=20, flag=false);
//       color("#7777") cube([75,75,0.1], center=true);
//   }
//
// Example(2D):
//   n = [0,1];
//   path = rot(30, p=square([50,30]));
//   color("gray") rot(from=[0,1],to=n) stroke([[-60,0],[60,0]]);
//   color("red") stroke([[0,0],10*n],endcap2="arrow2");
//   #stroke(path,closed=true);
//   stroke(mirror(n, path),closed=true);
//
// Example(2D):
//   n = [1,1];
//   path = rot(30, p=square([50,30]));
//   color("gray") rot(from=[0,1],to=n) stroke([[-60,0],[60,0]]);
//   color("red") stroke([[0,0],10*n],endcap2="arrow2");
//   #stroke(path,closed=true);
//   stroke(mirror(n, path),closed=true);
//
function mirror(v, p=_NO_ARG) =
    assert(is_vector(v))
    assert(p==_NO_ARG || is_list(p),"Invalid pointlist")
    let(m = affine3d_mirror(v))
    p==_NO_ARG? m : apply(m,p);

function xflip(p=_NO_ARG, x=0) =
    assert(is_finite(x))
    assert(p==_NO_ARG || is_list(p),"Invalid point list")
    let( v = RIGHT )
    x == 0 ? mirror(v,p=p) :
    let(
        cp = x * v,
        m = move(cp) * mirror(v) * move(-cp)
    )
    p==_NO_ARG? m : apply(m, p);

function yflip(p=_NO_ARG, y=0) =
    assert(is_finite(y))
    assert(p==_NO_ARG || is_list(p),"Invalid point list")
    let( v = BACK )
    y == 0 ? mirror(v,p=p) :
    let(
        cp = y * v,
        m = move(cp) * mirror(v) * move(-cp)
    )
    p==_NO_ARG? m : apply(m, p);

function zflip(p=_NO_ARG, z=0) =
    assert(is_finite(z))
    assert(p==_NO_ARG || is_list(p),"Invalid point list")
    z==0? mirror([0,0,1],p=p) :
    let(m = up(z) * mirror(UP) * down(z))
    p==_NO_ARG? m : apply(m, p);

//////////////////////////////////////////////////////////////////////
// Section: Other Transformations
//////////////////////////////////////////////////////////////////////

// Function&Module: frame_map()
//
// Synopsis: Rotates and possibly skews children from one frame of reference to another.
// SynTags: Trans, Path, VNF, Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot()
//
// Usage: As module
//   frame_map(v1, v2, v3, [reverse=]) CHILDREN;
// Usage: As function to remap points
//   transformed = frame_map(v1, v2, v3, p=points, [reverse=]);
// Usage: As function to return a transformation matrix:
//   map = frame_map(v1, v2, v3, [reverse=]);
//   map = frame_map(x=VECTOR1, y=VECTOR2, [reverse=]);
//   map = frame_map(x=VECTOR1, z=VECTOR2, [reverse=]);
//   map = frame_map(y=VECTOR1, z=VECTOR2, [reverse=]);
//
// Description:
//   Maps one coordinate frame to another.  You must specify two or
//   three of `x`, `y`, and `z`.  The specified axes are mapped to the vectors you supplied, so if you
//   specify x=[1,1] then the x axis is mapped to the line y=x.  If you
//   give two inputs, the third vector is mapped to the appropriate normal to maintain a right hand
//   coordinate system.  If the vectors you give are orthogonal the result is a rotation and the
//   `reverse` parameter supplies the inverse map, which enables you to map two arbitrary
//   coordinate systems to each other by using the canonical coordinate system as an intermediary.
//   You cannot use the `reverse` option with non-orthogonal inputs.  Note that only the direction
//   of the specified vectors matters: the transformation does not apply scaling, though it can
//   skew if your provide non-orthogonal axes.
//   .
//   You can use `frame_map()` as a module, or as a function.  In the functional form, you 
//   need to provide the points to be transformed with the `p=` named argument (except in the
//   less common situation where you give all three of `x`, `y`, and `z`).
//   The functional form with no `p=` argument returns a 4x4 transformation matrix.  
// Arguments:
//   x = Destination 3D vector for x axis.
//   y = Destination 3D vector for y axis.
//   z = Destination 3D vector for z axis.
//   p = (function only) A point, list of points, Bezier patch or VNF to operate on.
//   ---
//   reverse = reverse direction of the map for orthogonal inputs.  Default: false
//
// Example:  Remap axes after linear extrusion
//   frame_map(x=[0,1,0], y=[0,0,1]) linear_extrude(height=10) square(3);
//
// Example: This map is just a rotation around the z axis
//   mat = frame_map(x=[1,1,0], y=[-1,1,0]);
//   multmatrix(mat) frame_ref();
//
// Example:  This map is not a rotation because x and y aren't orthogonal
//   frame_map(x=[1,0,0], y=[1,1,0]) cube(10);
//
// Example:  This sends [1,1,0] to [0,1,1] and [-1,1,0] to [0,-1,1].  (Original directions shown in light shade, final directions shown dark.)
//   mat = frame_map(x=[0,1,1], y=[0,-1,1]) * frame_map(x=[1,1,0], y=[-1,1,0],reverse=true);
//   color("purple",alpha=.2) stroke([[0,0,0],10*[1,1,0]]);
//   color("green",alpha=.2)  stroke([[0,0,0],10*[-1,1,0]]);
//   multmatrix(mat) {
//      color("purple") stroke([[0,0,0],10*[1,1,0]]);
//      color("green") stroke([[0,0,0],10*[-1,1,0]]);
//   }
//
function frame_map(x,y,z, p=_NO_ARG, reverse=false) =
    p != _NO_ARG
    ? apply(frame_map(x,y,z,reverse=reverse), p)
    :
    assert(num_defined([x,y,z])>=2, "Must define at least two inputs")
    let(
        xvalid = is_undef(x) || (is_vector(x) && len(x)==3),
        yvalid = is_undef(y) || (is_vector(y) && len(y)==3),
        zvalid = is_undef(z) || (is_vector(z) && len(z)==3)
    )
    assert(xvalid,"Input x must be a length 3 vector")
    assert(yvalid,"Input y must be a length 3 vector")
    assert(zvalid,"Input z must be a length 3 vector")
    let(
        x = is_undef(x)? undef : unit(x,RIGHT),
        y = is_undef(y)? undef : unit(y,BACK),
        z = is_undef(z)? undef : unit(z,UP),
        map = is_undef(x)? [cross(y,z), y, z] :
            is_undef(y)? [x, cross(z,x), z] :
            is_undef(z)? [x, y, cross(x,y)] :
            [x, y, z]
    )
    reverse? (
        let(
            ocheck = (
                approx(map[0]*map[1],0) &&
                approx(map[0]*map[2],0) &&
                approx(map[1]*map[2],0)
            )
        )
        assert(ocheck, "Inputs must be orthogonal when reverse==true")
        [for (r=map) [for (c=r) c, 0], [0,0,0,1]]
    ) : [for (r=transpose(map)) [for (c=r) c, 0], [0,0,0,1]];

function skew(p=_NO_ARG, sxy, sxz, syx, syz, szx, szy, axy, axz, ayx, ayz, azx, azy) =
    assert(num_defined([sxy,axy]) < 2)
    assert(num_defined([sxz,axz]) < 2)
    assert(num_defined([syx,ayx]) < 2)
    assert(num_defined([syz,ayz]) < 2)
    assert(num_defined([szx,azx]) < 2)
    assert(num_defined([szy,azy]) < 2)
    assert(sxy==undef || is_finite(sxy))
    assert(sxz==undef || is_finite(sxz))
    assert(syx==undef || is_finite(syx))
    assert(syz==undef || is_finite(syz))
    assert(szx==undef || is_finite(szx))
    assert(szy==undef || is_finite(szy))
    assert(axy==undef || is_finite(axy))
    assert(axz==undef || is_finite(axz))
    assert(ayx==undef || is_finite(ayx))
    assert(ayz==undef || is_finite(ayz))
    assert(azx==undef || is_finite(azx))
    assert(azy==undef || is_finite(azy))
    let(
        sxy = is_num(sxy)? sxy : is_num(axy)? tan(axy) : 0,
        sxz = is_num(sxz)? sxz : is_num(axz)? tan(axz) : 0,
        syx = is_num(syx)? syx : is_num(ayx)? tan(ayx) : 0,
        syz = is_num(syz)? syz : is_num(ayz)? tan(ayz) : 0,
        szx = is_num(szx)? szx : is_num(azx)? tan(azx) : 0,
        szy = is_num(szy)? szy : is_num(azy)? tan(azy) : 0,
        m = affine3d_skew(sxy=sxy, sxz=sxz, syx=syx, syz=syz, szx=szx, szy=szy)
    )
    p==_NO_ARG? m : apply(m, p);

// Section: Applying transformation matrices to data

/// Internal Function: is_2d_transform()
/// Usage:
///   bool = is_2d_transform(t);
/// Topics: Affine, Matrices, Transforms, Type Checking
/// See Also: is_affine(), is_matrix()
/// Description:
///   Checks if the input is a 3D transform that does not act on the z coordinate, except possibly
///   for a simple scaling of Z.  An input that is a pure scaling of Z returns false.
/// Arguments:
///   t = The transformation matrix to check.
/// Example:
///   b = is_2d_transform(zrot(45));  // Returns: true
///   b = is_2d_transform(yrot(45));  // Returns: false
///   b = is_2d_transform(xrot(45));  // Returns: false
///   b = is_2d_transform(move([10,20,0]));  // Returns: true
///   b = is_2d_transform(move([10,20,30]));  // Returns: false
///   b = is_2d_transform(scale([2,3,4]));  // Returns: true
function is_2d_transform(t) =    // z-parameters are zero, except we allow t[2][2]!=1 so scale() works
  t[2][0]==0 && t[2][1]==0 && t[2][3]==0 && t[0][2] == 0 && t[1][2]==0 &&
  (t[2][2]==1 || !(t[0][0]==1 && t[0][1]==0 && t[1][0]==0 && t[1][1]==1));

// Function: apply()
//
// Synopsis: Applies a transformation matrix to a point, list of points, array of points, or a VNF.
// SynTags: Path, VNF, Mat
// Topics: Affine, Matrices, Transforms
// See Also: move(), rot(), scale(), skew()
//
// Usage:
//   pts = apply(transform, points);
//
// Description:
//   Applies the specified transformation matrix `transform` to a point, point list, bezier patch or VNF.
//   When `points` contains 2D or 3D points the transform matrix may be a 4x4 affine matrix or a 3x4 
//   matrix&mdash;the 4x4 matrix with its final row removed.  When the data is 2D the matrix must not operate on the Z axis,
//   except possibly by scaling it.  When points contains 2D data you can also supply the transform as
//   a 3x3 affine transformation matrix or the corresponding 2x3 matrix with the last row deleted.
//   .
//   Any other combination of matrices produces an error, including acting with a 2D matrix (3x3) on 3D data.
//   The output of apply is always the same dimension as the input&mdash;projections are not supported.
//   .
//   Note that a matrix with a negative determinant such as any mirror reflection flips the orientation of faces.
//   If the transform matrix is square then apply() checks the determinant and if it is negative, apply() reverses the face order so that
//   the transformed VNF has faces with the same winding direction as the original VNF.  This adjustment applies
//   only to VNFs, not to beziers or point lists.  
//
// Arguments:
//   transform = The 2D (3x3 or 2x3) or 3D (4x4 or 3x4) transformation matrix to apply.
//   points = The point, point list, bezier patch, or VNF to apply the transformation to.
//
// Example(3D):
//   path1 = path3d(circle(r=40));
//   tmat = xrot(45);
//   path2 = apply(tmat, path1);
//   #stroke(path1,closed=true);
//   stroke(path2,closed=true);
//
// Example(2D):
//   path1 = circle(r=40);
//   tmat = translate([10,5]);
//   path2 = apply(tmat, path1);
//   #stroke(path1,closed=true);
//   stroke(path2,closed=true);
//
// Example(2D):
//   path1 = circle(r=40);
//   tmat = rot(30) * back(15) * scale([1.5,0.5,1]);
//   path2 = apply(tmat, path1);
//   #stroke(path1,closed=true);
//   stroke(path2,closed=true);
//
function apply(transform,points) =
    points==[] ? []
  : is_vector(points) ? _apply(transform, [points])[0]    // point
  : is_vnf(points) ?                                      // vnf
        let(
            newvnf = [_apply(transform, points[0]), points[1]],
            reverse = (len(transform)==len(transform[0])) && determinant(transform)<0
        )
        reverse ? vnf_reverse_faces(newvnf) : newvnf
  : is_list(points) && is_list(points[0]) && is_vector(points[0][0])    // bezier patch
        ? [for (x=points) _apply(transform,x)]
  : _apply(transform,points);

function _apply(transform,points) =
    assert(is_matrix(transform),"Invalid transformation matrix")
    assert(is_matrix(points),"Invalid points list")
    let(
        tdim = len(transform[0])-1,
        datadim = len(points[0])
    )
    assert(len(transform)==tdim || len(transform)-1==tdim, "transform matrix height not compatible with width")
    assert(datadim==2 || datadim==3,"Data must be 2D or 3D")
    let(
        scale = len(transform)==tdim ? 1 : transform[tdim][tdim],
        matrix = [for(i=[0:1:tdim]) [for(j=[0:1:datadim-1]) transform[j][i]]] / scale
    )
    tdim==datadim ? [for(p=points) concat(p,1)] * matrix
  : tdim == 3 && datadim == 2 ?
            assert(is_2d_transform(transform), str("Transforms is 3D and acts on Z, but points are 2D"))
            [for(p=points) concat(p,[0,1])]*matrix
  : assert(false, str("Unsupported combination: ",len(transform),"x",len(transform[0])," transform (dimension ",tdim,
                          "), data of dimension ",datadim));

// Saving and restoring of transformations
//
// In this section the standard transformations are redefined so that
// they update $transform
$transform = IDENT;

module translate__1(v)
{
  $transform = $transform * (is_vector(v) && (len(v)==2 || len(v)==3) ? affine3d_translate(point3d(v)) : IDENT);
  _translate(v) children();                   
}

module rotate__1(a,v)
{
  rot3 = is_finite(a) && is_vector(v) && (len(v)==2 || len(v)==3) ? affine3d_rot_by_axis(v,a)
       : is_finite(a) ? affine3d_zrot(a)
       : same_shape(a,[0]) ? affine3d_xrot(a.x)
       : same_shape(a,[0,0]) ? affine3d_yrot(a.y)*affine3d_xrot(a.x)
       : same_shape(a,[0,0,0])? affine3d_zrot(a.z)*affine3d_yrot(a.y)*affine3d_xrot(a.x)
       : IDENT;
  $transform = $transform * rot3;
  _rotate(a=a,v=v) children();
}

module scale__1(v,cp=[0,0,0],dir)
{
  if (cp!=[0,0,0] || is_def(dir))
    multmatrix__1(scale(v,cp=cp,dir=dir)) children();
  else {
    s3 = is_finite(v) ? affine3d_scale([v,v,v])
       : is_vector(v) ? affine3d_scale(v)
       : IDENT;
    $transform = $transform * s3;
    _scale(v) children();
  }  
}

module multmatrix__1(m)
{
   m3 = !is_matrix(m) ? IDENT
      : len(m)>0 && len(m)<=4 && len(m[0])>0 && len(m[0])<=4 ? submatrix_set(IDENT, m)
      : IDENT;
   $transform = $transform * m3;
   _multmatrix(m) children();
}

// onescad: BOSL2/distributors.scad
//////////////////////////////////////////////////////////////////////
// LibFile: distributors.scad
//   Functions and modules to distribute children or copies of children onto
//   a line, a grid, or an arbitrary path.  The $idx mechanism means that
//   the "copies" of children can vary.  Also includes shortcuts for mirroring.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Copy or distribute objects onto a line, grid, or path.  Mirror shortcuts. 
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Function&Module: xcopies()
// Synopsis: Places copies of children along the X axis. 
// SynTags: MatList, Trans
// Topics: Transformations, Distributors, Translation, Copiers
// See Also: move_copies(), ycopies(), zcopies(), line_copies(), grid_copies(), rot_copies(), xrot_copies(), yrot_copies(), zrot_copies(), arc_copies(), sphere_copies()
//
// Usage:
//   xcopies(spacing, [n], [sp=]) CHILDREN;
//   xcopies(l=, [n=], [sp=]) CHILDREN;
//   xcopies(LIST) CHILDREN;
// Usage: As a function to translate points, VNF, or Bezier patches
//   copies = xcopies(spacing, [n], [sp=], p=);
//   copies = xcopies(l=, [n=], [sp=], p=);
//   copies = xcopies(LIST, p=);
// Usage: Get Translation Matrices
//   mats = xcopies(spacing, [n], [sp=]);
//   mats = xcopies(l=, [n=], [sp=]);
//   mats = xcopies(LIST);
// Description:
//   When called as a module, places `n` copies of the children along a line on the X axis.
//   When called as a function, *without* a `p=` argument, returns a list of transformation matrices, one for each copy.
//   When called as a function, *with* a `p=` argument, returns a list of transformed copies of `p=`.
//
// Arguments:
//   spacing = Given a scalar, specifies a uniform spacing between copies. Given a list of scalars, each one gives a specific position along the line. (Default: 1.0)
//   n = Number of copies to place. (Default: 2)
//   ---
//   l = If given, the length to place copies over.
//   sp = If given as a point, copies will be placed on a line to the right of starting position `sp`.  If given as a scalar, copies will be placed on a line segment to the right of starting position `[sp,0,0]`.  If not given, copies will be placed along a line segment that is centered at [0,0,0].
//   p = Either a point, pointlist, VNF or Bezier patch to be translated when used as a function.
//
// Side Effects:
//   `$pos` is set to the relative centerpoint of each child copy, and can be used to modify each child individually.
//   `$idx` is set to the index number of each child being copied.
//
// Examples:
//   xcopies(20) sphere(3);
//   xcopies(20, n=3) sphere(3);
//   xcopies(spacing=15, l=50) sphere(3);
//   xcopies(n=4, l=30, sp=[0,10,0]) sphere(3);
// Example:
//   xcopies(10, n=3) {
//       cube(size=[1,3,1],center=true);
//       cube(size=[3,1,1],center=true);
//   }
// Example:
//   xcopies([1,2,3,5,7]) sphere(d=1);
module xcopies(spacing, n, l, sp)
{
    assert(is_undef(n) || num_defined([l,spacing])==1, "When n is given must give exactly one of spacing or l")
    assert(is_def(n) || num_defined([l,spacing])>=1, "When n is not given must give at least one of spacing or l")  
    req_children($children);
    dir = RIGHT;
    sp = is_finite(sp)? (sp*dir) : sp;
    if (is_vector(spacing)) {
        translate__1(default(sp,[0,0,0])) {
            for (i = idx(spacing)) {
                $idx = i;
                $pos = spacing[i]*dir;
                translate__1($pos) children();
            }
        }
    } else {
        line_copies(
            l=u_mul(l,dir),
            spacing=u_mul(spacing,dir),
            n=n, p1=sp
        ) children();
    }
}

// Function&Module: ycopies()
// Synopsis: Places copies of children along the Y axis. 
// SynTags: MatList, Trans
// Topics: Transformations, Distributors, Translation, Copiers
// See Also: move_copies(), xcopies(), zcopies(), line_copies(), grid_copies(), rot_copies(), xrot_copies(), yrot_copies(), zrot_copies(), arc_copies(), sphere_copies()
//
// Usage:
//   ycopies(spacing, [n], [sp=]) CHILDREN;
//   ycopies(l=, [n=], [sp=]) CHILDREN;
//   ycopies(LIST) CHILDREN;
// Usage: As a function to translate points, VNF, or Bezier patches
//   copies = ycopies(spacing, [n], [sp=], p=);
//   copies = ycopies(l=, [n=], [sp=], p=);
//   copies = ycopies(LIST, p=);
// Usage: Get Translation Matrices
//   mats = ycopies(spacing, [n], [sp=]);
//   mats = ycopies(l=, [n=], [sp=]);
//   mats = ycopies(LIST);
// Description:
//   When called as a module, places `n` copies of the children along a line on the Y axis.
//   When called as a function, *without* a `p=` argument, returns a list of transformation matrices, one for each copy.
//   When called as a function, *with* a `p=` argument, returns a list of transformed copies of `p=`.
//
// Arguments:
//   spacing = Given a scalar, specifies a uniform spacing between copies. Given a list of scalars, each one gives a specific position along the line. (Default: 1.0)
//   n = Number of copies to place on the line. (Default: 2)
//   ---
//   l = If given, the length to place copies over.
//   sp = If given as a point, copies will be place on a line back from starting position `sp`.  If given as a scalar, copies will be placed on a line back from starting position `[0,sp,0]`.  If not given, copies will be placed along a line that is centered at [0,0,0].
//   p = Either a point, pointlist, VNF or Bezier patch to be translated when used as a function.
//
// Side Effects:
//   `$pos` is set to the relative centerpoint of each child copy, and can be used to modify each child individually.
//   `$idx` is set to the index number of each child being copied.
//
// Examples:
//   ycopies(20) sphere(3);
//   ycopies(20, n=3) sphere(3);
//   ycopies(spacing=15, l=50) sphere(3);
//   ycopies(n=4, l=30, sp=[10,0,0]) sphere(3);
// Example:
//   ycopies(10, n=3) {
//       cube(size=[1,3,1],center=true);
//       cube(size=[3,1,1],center=true);
//   }
// Example:
//   ycopies([1,2,3,5,7]) sphere(d=1);
module ycopies(spacing, n, l, sp)
{
    assert(is_undef(n) || num_defined([l,spacing])==1, "When n is given must give exactly one of spacing or l")
    assert(is_def(n) || num_defined([l,spacing])>=1, "When n is not given must give at least one of spacing or l")  
    req_children($children);  
    dir = BACK;
    sp = is_finite(sp)? (sp*dir) : sp;
    if (is_vector(spacing)) {
        translate__1(default(sp,[0,0,0])) {
            for (i = idx(spacing)) {
                $idx = i;
                $pos = spacing[i]*dir;
                translate__1($pos) children();
            }
        }
    } else {
        line_copies(
            l=u_mul(l,dir),
            spacing=u_mul(spacing,dir),
            n=n, p1=sp
        ) children();
    }
}

module line_copies(spacing, n, l, p1, p2)
{
    req_children($children);
    pts = line_copies(spacing=spacing, n=n, l=l, p1=p1, p2=p2, p=[0,0,0]);
    for (i=idx(pts)) {
        $idx = i;
        $pos = pts[i];
        translate__1($pos) children();
    }
}

function line_copies(spacing, n, l, p1, p2, p=_NO_ARG) =
    assert(is_undef(spacing) || is_finite(spacing) || is_vector(spacing))
    assert(!is_list(spacing) || len(spacing)==2 || len(spacing)==3, "Vector `spacing` must have length 2 or 3")
    assert(is_undef(n) || is_finite(n))
    assert(is_undef(l) || is_finite(l) || is_vector(l))
    assert(is_undef(p1) || is_vector(p1))
    assert(is_undef(p2) || is_vector(p2))
    assert(is_undef(p2) || is_def(p1), "If p2 is given must also give p1")
    assert(is_undef(p2) || is_undef(l), "Cannot give both p2 and l")
    assert(is_undef(n) || num_defined([l,spacing,p2])==1,"If n is given then must give exactly one of 'l', 'spacing', or the 'p1'/'p2' pair")
    assert(is_def(n) || num_defined([l,spacing,p2])>=1,"If n is not given then must give at least one of 'l', 'spacing', or the 'p1'/'p2' pair")
    assert(!(is_vector(spacing) && is_vector(l) && vector_angle(spacing,l)>_EPSILON), "Cannot give conflicting vector 'spacing' and vector 'l' value.")
    assert(!(is_vector(spacing) && is_def(p2)), "Cannot combine vector 'spacing' with the 'p1'/'p2' pair")
    let(
        ll = is_def(l)? scalar_vec3(l, 0)
           : is_def(spacing) && is_def(n)? (n-1) * scalar_vec3(spacing, 0)
           : is_def(p1) && is_def(p2)? point3d(p2-p1)
           : undef,
        cnt = is_def(n)? n
            : is_def(spacing) && is_def(ll) ? floor(norm(ll) / norm(scalar_vec3(spacing, 0)) + 1.000001)
            : 2,
        spc = cnt<=1? [0,0,0]
            : is_undef(spacing) && is_def(ll)? ll/(cnt-1) 
            : is_num(spacing) && is_def(ll)? ll/(cnt-1)
            : scalar_vec3(spacing, 0)
    )
    assert(!is_undef(cnt), "Need two of `spacing`, 'l', 'n', or `p1`/`p2` arguments in `line_copies()`.")
    let( spos = !is_undef(p1)? point3d(p1) : -(cnt-1)/2 * spc )
    [for (i=[0:1:cnt-1]) translate(i * spc + spos, p=p)];

// Function&Module: zflip_copy()
// Synopsis: Makes a copy of children mirrored across the Z axis.
// SynTags: MatList, Trans
// Topics: Transformations, Distributors, Translation, Copiers
// See Also: xflip_copy(), yflip_copy(), mirror_copy(), path_copies(), move_copies(), xcopies(), ycopies(), zcopies(), line_copies(), grid_copies() 
//
// Usage:
//   zflip_copy([offset], [z]) CHILDREN;
// Usage: As a function to translate points, VNF, or Bezier patches
//   copies = zflip_copy([offset], [z], p=);
// Usage: Get Translation Matrices
//   mats = zflip_copy([offset], [z]);
//
// Description:
//   When called as a module, makes a copy of the children, mirrored across the Z axis.
//   When called as a function, *without* a `p=` argument, returns a list of transformation matrices, one for each copy.
//   When called as a function, *with* a `p=` argument, returns a list of transformed copies of `p=`.
//
// Arguments:
//   offset = Distance to offset children up, before copying.
//   z = The Z coordinate of the mirroring plane.  Default: 0
//   ---
//   p = Either a point, pointlist, VNF or Bezier patch to be translated when used as a function.
//
// Side Effects:
//   `$orig` is true for the original instance of children.  False for the copy.
//   `$idx` is set to the index value of each copy.
//
//
// Example:
//   zflip_copy() cylinder(h=20, r1=4, r2=0);
//   color("blue",0.25) cube([15,15,0.01], center=true);
//
// Example:
//   zflip_copy(offset=5) cylinder(h=20, r1=4, r2=0);
//   color("blue",0.25) cube([15,15,0.01], center=true);
//
// Example:
//   zflip_copy(z=-5) cylinder(h=20, r1=4, r2=0);
//   color("blue",0.25) down(5) cube([15,15,0.01], center=true);
module zflip_copy(offset=0, z=0)
{
    req_children($children);  
    mirror_copy(v=[0,0,1], offset=offset, cp=[0,0,z]) children();
}

// Function&Module: mirror_copy()
// Synopsis: Makes a copy of children mirrored across a given plane.
// SynTags: MatList, Trans
// Topics: Transformations, Distributors, Translation, Copiers
// See Also: xflip_copy(), yflip_copy(), zflip_copy(), path_copies(), move_copies(), xcopies(), ycopies(), zcopies(), line_copies(), grid_copies() 
//
// Usage:
//   mirror_copy(v, [cp], [offset]) CHILDREN;
// Usage: As a function to translate points, VNF, or Bezier patches
//   copies = mirror_copy(v, [cp], [offset], p=);
// Usage: Get Translation Matrices
//   mats = mirror_copy(v, [cp], [offset]);
//
// Description:
//   When called as a module, makes a copy of the children, mirrored across the given plane.
//   When called as a function, *without* a `p=` argument, returns a list of transformation matrices, one for each copy.
//   When called as a function, *with* a `p=` argument, returns a list of transformed copies of `p=`.
//
// Arguments:
//   v = The normal vector of the plane to mirror across.
//   offset = distance to offset away from the plane.
//   cp = A point that lies on the mirroring plane.
//   ---
//   p = Either a point, pointlist, VNF or Bezier patch to be translated when used as a function.
//
// Side Effects:
//   `$orig` is true for the original instance of children.  False for the copy.
//   `$idx` is set to the index value of each copy.
//
//
// Example:
//   mirror_copy([1,-1,0]) zrot(-45) yrot(90) cylinder(d1=10, d2=0, h=20);
//   color("blue",0.25) zrot(-45) cube([0.01,15,15], center=true);
//
// Example:
//   mirror_copy([1,1,0], offset=5) rot(a=90,v=[-1,1,0]) cylinder(d1=10, d2=0, h=20);
//   color("blue",0.25) zrot(45) cube([0.01,15,15], center=true);
//
// Example:
//   mirror_copy(UP+BACK, cp=[0,-5,-5]) rot(from=UP, to=BACK+UP) cylinder(d1=10, d2=0, h=20);
//   color("blue",0.25) translate([0,-5,-5]) rot(from=UP, to=BACK+UP) cube([15,15,0.01], center=true);
module mirror_copy(v=[0,0,1], offset=0, cp)
{
    req_children($children);  
    cp = is_vector(v,4)? plane_normal(v) * v[3] :
        is_vector(cp)? cp :
        is_num(cp)? cp*unit(v) :
        [0,0,0];
    nv = is_vector(v,4)? plane_normal(v) : unit(v);
    off = nv*offset;
    if (cp == [0,0,0]) {
        translate__1(off) {
            $orig = true;
            $idx = 0;
            children();
        }
        mirror(nv) translate__1(off) {
            $orig = false;
            $idx = 1;
            children();
        }
    } else {
        translate__1(off) {
            $orig = true;
            $idx = 0;
            children();
        }
        translate__1(cp) mirror(nv) translate__1(-cp) translate__1(off) {
            $orig = false;
            $idx = 1;
            children();
        }
    }
}

// onescad: BOSL2/attachments.scad
//////////////////////////////////////////////////////////////////////
// LibFile: attachments.scad
//   The modules in this file allows you to attach one object to another by making one object the child of another object.
//   You can place the child object in relation to its parent object and control the position and orientation
//   relative to the parent.  The modifiers allow you to treat children in ways different from simple union, such
//   as differencing them from the parent, or changing their color.  Attachment works only when the parent and child
//   are both written to support attachment.  Also included in this file  are the tools to make your own "attachable" objects.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Positioning objects on or relative to other objects.  Making your own objects support attachment.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Default values for attachment code.
$tags=undef;

$tag = "";

$save_tag = undef;

$tag_prefix = "";

$overlap = 0;

$color = ["default",undef];

$save_color = undef;

$anchor_override = undef;

$attach_to = undef;

$attach_anchor = [CENTER, CENTER, UP, 0];

$attach_alignment = undef;

$parent_anchor = BOTTOM;

$parent_spin = 0;

$parent_orient = UP;

$parent_size = undef;

$parent_geom = undef;

$parent_parts = undef;

$change_anchors = undef;

$attach_inside = false;

$edge_angle = undef;

$edge_length = undef;

$tags_shown = "ALL";

$tags_hidden = [];

$ghost_this=false;

$ghost=false;

$ghosting=false;

$highlight_this=false;

$highlight=false;

$hide_this=false;

$anchor_inside=false;

_ANCHOR_TYPES = ["intersect","hull"];

// Quantize anchor entry to {-1,0,1}
function _quant_anch(x) = approx(x,0) ? 0 : sign(x);

// Make arbitrary anchor legal for a given geometry
function _make_anchor_legal(anchor,geom) =
    is_string(anchor) ? anchor
  : in_list(geom[0], ["prismoid","trapezoid"]) ? [for(v=anchor) _quant_anch(v)]
  : in_list(geom[0], ["conoid", "extrusion_extent"]) ? [anchor.x,anchor.y, _quant_anch(point3d(anchor).z)]
  : anchor;

// Module: attach()
// Synopsis: Attaches children to a parent object at an anchor point and with anchor orientation.
// SynTags: Trans
// Topics: Attachments
// See Also: attachable(), position(), align(), face_profile(), edge_profile(), corner_profile()
// Usage:
//   PARENT() attach(parent, child, [align=], [spin=], [overlap=], [inside=], [inset=], [shiftout=]) CHILDREN;
//   PARENT() attach(parent, [overlap=], [spin=]) CHILDREN;
// Description:
//   Attaches children to a parent object at an anchor point or points, oriented in the anchor direction.
//   This module differs from {{position()}} and {{align()}} in that it rotates the children to
//   the anchor direction, which generally means it places the children on the surface of a parent.
//   There are two modes of operation, parent anchor (single argument) and parent-child anchor (double argument).
//   In most cases you should use the parent-child (double argument) version of `attach()`.  
//   .
//   The parent-child anchor (double argument) version is usually easier to use, and it is more powerful because it supports
//   alignment.  You provide an anchor on the parent (`parent`) and an anchor on the child (`child`).
//   This module connects the `child` anchor on the child to the `parent` anchor on the parent.  
//   Imagine pointing the parent and child anchor arrows at each other and pushing the objects
//   together until they meet at the anchor point.  The most basic case
//   is `attach(TOP,BOT)`, which puts the bottom of the child onto the top of the parent.  If you
//   do `attach(RIGHT,BOT)` this puts the bottom of the child onto the right anchor of the parent.
//   When an object is attached to the top or bottom, its BACK direction remains pointing BACK.
//   When an object is attached to one of the other anchors its FRONT is pointed DOWN and its
//   BACK pointed UP.  You can change this using the `spin=` argument to attach().  This spin
//   rotates around the attachment vector and is not the same as the spin argument to the child, which
//   will usually rotate around some other axis that may be hard to predict. 
//   For 2D objects you cannot give the `spin=` argument to attach() because this breaks the anchor
//   alignment that attach() creates.  (You can,  however, still give `spin=` to the child, which will
//   misalign the anchors produe by the attachment.)
//   .
//   As with {{align()}} you can use the `align=` parameter to align the child to an edge or corner of the
//   face where that child is attached.  For example, `attach(TOP,BOT,align=RIGHT)` stands the child
//   up on the top while aligning it with the right edge of the top face, and `attach(RIGHT,BOT,align=TOP)` 
//   stands the object on the right face while aligning with the top edge.  If you apply spin using the
//   argument to `attach()`, then it is taken into account for the alignment. However, if you apply spin as
//   a parameter to the child, it is **not** taken into account.  The special spin value "align"
//   spins the child so that the child's BACK direction is pointed toward the aligned edge on the parent. 
//   When you use `align=` you can also adjust the position using `inset=`, which shifts the child
//   inward away from the edge or corner it is aligned to.  The `inset=` parameter is not permitted without `align=`.
//   .
//   The concept of alignment doesn't always make sense for objects without corners, such as spheres or cylinders.
//   In same cases, the alignments using such children may look odd because the alignment computation tries to
//   place a non-existent corner somewhere.  Because attach() doesn't have in formation about the child when
//   it runs, it cannot handle curved shapes differently from cubes, so this behavior cannot be changed.  
//   .
//   Because the attachment process forces an orientation and anchor point for the child, it overrides
//   any such specifications you give to the child:  **both `anchor=` and `orient=` given to the child are
//   ignored** with the **double argument** version of `attach()`.  As noted above, you can give `spin=` to the
//   child but using the `spin=` parameter to `attach()` is more likely to be useful.
//   .
//   If you give `inside=true` then the anchor arrows are lined up so they point the same direction and
//   the child object is located inside the parent.  In this case a default "remove" tag is applied to
//   the children.  
//   .
//   The overlap option and shiftout option both move the object away from its aligned position.  They
//   can be used to prevent coincident faces from creating issues in OpenSCAD by ensuring that the child
//   fully overlaps the parent's face(s).  The `overlap` parameter defaults to the value of `$overlap`, or
//   0 if `$overlap` is not set.  It moves the child object in the direction of the `parent` face when
//   `inside=false` (sinking the child into the parent) and it moves the child in the opposite direction
//   if `inside=true`, shifting the child outward away from the `parent` face.  The child will remain exactly flush
//   with edges it was aligned to using `align=`.  The `overlap` parameter is best suited to externally attached objects (`inside=false`)
//   where the aligned edges should remain perfectly aligned.  The `shiftout` parameter shifts the child outward relative to
//   the `parent` face and also any aligned edges.  The direction of movement does not depend on the `inside` parameter.
//   For an inside child this is equivalent to giving a positive overlap and negative inset value.
//   For a child with `inside=false` it is equivalent to a negative overlap and negative inset.  The `shiftout` parameter
//   is well suited to internal objects where `inside=true` because it shifts to overlap all coincident faces, including
//   faces at aligned edges.  
//   .
//   The single parameter version of `attach()` is rarely needed; to use it, you give only the `parent` anchor.  The `align` direction
//   is not permitted.  In this case the child is placed at the specified parent anchor point
//   and rotated to the anchor direction.  For example, `attach(TOP) cuboid(2);` places a small
//   cube **with its center** located at the TOP anchor of the parent, so just half the cube projects
//   from the parent.  If you want the cube sitting on the parent you need to anchor the cube to its bottom:
//   `attach(TOP) cuboid(2,anchor=BOT);`.
//   .
//   The **single argument** version of `attach()` **respects `anchor=` and `orient=` given to the child.**
//   These options will probably be necessary, in fact, to get the child correctly positioned.  Note that
//   giving `spin=` to `attach()` in this case is the same as applying `zrot()` to the child. 
//   .
//   For a step-by-step explanation of attachments, see the [Attachments Tutorial](Tutorial-Attachment-Relative-Positioning).
// Arguments:
//   parent = The parent anchor point to attach to or a list of parent anchor points.
//   child = Optional child anchor point.  If given, orients the child to connect this anchor point to the parent anchor.
//   ---
//   align = If `child` is given you can specify alignment or list of alistnments to shift the child to an edge or corner of the parent. 
//   inset = Shift aligned children away from their alignment edge/corner by this amount.  Default: 0
//   overlap = Amount to sink child into the parent (or raise child out of parent if `inside=true`).  Equivalent to `down(X)` after the attach (or `up(X)` if `inside=true`).  This defaults to the value in `$overlap`, which is `0` by default.
//   inside = If `child` is given you can set `inside=true` to attach the child to the inside of the parent for diff() operations.  Default: false
//   shiftout = Shift an inside object outward so that it overlaps all the aligned faces.  Default: 0
//   spin = Angle to rotate the child around the axis of the parent anchor.  Can set to "align" to align the child's BACK with the parent aligned edge.  (Permitted only in 3D.)
// Side Effects:
//   `$anchor` set to the parent anchor value used for the child.
//   `$align` set to the align value used for the child.  
//   `$idx` set to a unique index for each child, increasing by alignment first.
//   `$attach_anchor` for each anchor given, this is set to the `[ANCHOR, POSITION, ORIENT, SPIN]` information for that anchor.
//   if inside is true then set default tag to "remove"
//   `$attach_to` is set to the value of the `child` argument, if given.  Otherwise, `undef`
//   `$edge_angle` is set to the angle of the edge if the anchor is on an edge and the parent is a prismoid or vnf with "hull" anchoring
//   `$edge_length` is set to the length of the edge if the anchor is on an edge and the parent is a prismoid or vnf with "hull" anchoring
// Example: Cylinder placed on top of cube:
//   cuboid(50)
//     attach(TOP,BOT) cylinder(d1=30,d2=15,h=25);
// Example: Cylinder on right and front side of cube:
//   cuboid(50)
//     attach([RIGHT,FRONT],BOT) cylinder(d1=30,d2=15,h=25);
// Example:  Using `align` can align child object(s) with edges
//   prismoid(50,25,25) color("green"){
//     attach(TOP,BOT,align=[BACK,FWD]) cuboid(4);
//     attach(RIGHT,BOT,align=[TOP,BOT]) cuboid(4);
//   }
// Example: One aligned to the corner upside down (light blue) and one inset fromt the corner (pink), one aligned on a side (orange) and one rotated and aligned (green).
//   cuboid(30) {
//     attach(TOP,TOP,align=FRONT+RIGHT) color("lightblue") prismoid(5,3,3);
//     attach(TOP,BOT,inset=3,align=FRONT+LEFT) color("pink") prismoid(5,3,3);
//     attach(FRONT,RIGHT,align=TOP) color("orange") prismoid(5,3,3);
//     attach(FRONT,RIGHT,align=RIGHT,spin=90) color("lightgreen") prismoid(5,3,3);    
//   }
// Example: Rotation not a multiple of 90 degrees with alignment.  The children are aligned on a corner.  
//   cuboid(30)
//     attach(FRONT,BOT,spin=33,align=[RIGHT,LEFT,TOP,BOT,RIGHT+TOP])
//       color("lightblue")cuboid(4);
// Example: Anchoring the cone onto the sphere gives a single point of contact. 
//   spheroid(d=20) 
//       attach([1,1.5,1], BOTTOM) cyl(l=11.5, d1=10, d2=5);
// Example: Using the `overlap` option can help:
//   spheroid(d=20) 
//       attach([1,1.5,1], BOTTOM, overlap=1.5) cyl(l=11.5, d1=10, d2=5);
// Example: Alignment works on the sides of cylinders but you can align only with either the top or bototm face:
//   cyl(h=30,d=10)
//     attach([LEFT,[1,1.3]], BOT,align=TOP) cuboid(6);
// Example: Attaching to edges.  The light blue and orange objects are attached to edges.  The purple object is attached to an edge and aligned. 
//   prismoid([20,10],[10,10],7){
//     attach(RIGHT+TOP,BOT,align=FRONT) color("pink")cuboid(2);
//     attach(BACK+TOP, BOT) color("lightblue")cuboid(2);
//     attach(RIGHT+BOT, RIGHT) color("orange")cyl(h=8,d=1);
//   }
// Example: Attaching inside the parent.  For inside attachment the anchors are lined up pointing the same direction, so the most natural way to anchor the child is using its TOP anchor.  This is equivalent to anchoring outside with the BOTTOM anchor and then lowering the child into the parent by its full depth.  
//   back_half()
//     diff()
//     cuboid(20)
//       attach(TOP,TOP,inside=true,shiftout=0.01) cyl(d1=10,d2=5,h=10);
// Example: Attaching inside the parent with alignment
//   diff()
//   cuboid(20){
//     attach(TOP,TOP,inside=true,align=RIGHT,shiftout=.01) cuboid([8,7,3]);
//     attach(TOP,TOP,inside=true,align=LEFT+FRONT,shiftout=0.01) cuboid([3,4,5]);
//     attach(RIGHT+FRONT, TOP, inside=true) cuboid([10,3,5]);
//     attach(RIGHT+FRONT, TOP, inside=true, align=TOP,shiftout=.01) cuboid([5,1,2]);  
//   }
// Example: Attaching a 3d edge mask.  Simple 2d masks can be done using {{edge_profile()}} but this mask varies along its length. In order to correctly position the anchors on the mask we can use `offset=` when creating it with attachable().  
//   module wavy_edge(length,cycles, r, steps, n)
//   {
//     rmin = is_vector(r) ? r[0] : 0.01;
//     rmax = is_vector(r) ? r[1] : r;
//     layers = [for(z=[0:steps])
//                   let(
//                        r=rmin+(rmax-rmin)/2*(cos(z*360*cycles/steps)+1)
//                   )
//                   path3d( concat([[0,0]],
//                                  arc(corner=path2d([BACK,CTR,RIGHT]), n=n, r=r)),
//                           z/steps*length-length/2)
//               ];
//     attachable(size=[rmax,rmax,length], offset=[rmax/2,rmax/2,0]){
//         skin(layers,slices=0);
//         children();
//     }  
//   }            
//   diff()
//   cuboid(25)
//     attach([TOP+RIGHT,TOP+LEFT,TOP+FWD, FWD+RIGHT], FWD+LEFT, inside=true, shiftout=.01)
//       wavy_edge(length=25.1,cycles=1.4,r=4,steps=24,n=15);
module attach(parent, child, overlap, align, spin=0, norot, inset=0, shiftout=0, inside=false, from, to)
{
    dummy3=
      assert(num_defined([to,child])<2, "\nCannot combine deprecated 'to' argument with 'child' parameter.")
      assert(num_defined([from,parent])<2, "\nCannot combine deprecated 'from' argument with 'parent' parameter.")
      assert(spin!="align" || is_def(align), "\nCan set spin to \"align\" only when the 'align' parameter is given.")
      assert(is_finite(spin) || spin=="align", "\nSpin must be a number (unless align is given).")
      assert((is_undef(overlap) || is_finite(overlap)) && (is_def(overlap) || is_undef($overlap) || is_finite($overlap)),
             str("Provided ",is_def(overlap)?"":"$","overlap is not valid."));
    removetag = inside;
    inside = $anchor_inside ? !inside : inside;
    if (is_def(to))
      echo("The 'to' option to attach() is deprecated and will be removed in the future.  Use 'child' instead.");
    if (is_def(from))
      echo("The 'from' option to attach(0 is deprecated and will be removed in the future.  Use 'parent' instead");
    if (norot)
      echo("The 'norot' option to attach() is deprecated and will be removed in the future.  Use position() instead.");
    req_children($children);
    
    dummy=assert($parent_geom != undef, "\nNo object to attach to!")
          assert(is_undef(child) || is_string(child) || (is_vector(child) && (len(child)==2 || len(child)==3)),
                 "\nChild must be a named anchor (a string) or a 2-vector or 3-vector.")
          assert(is_undef(align) || !is_string(child), "\nChild is a named anchor. Named anchors are not supported with align=.");

    two_d = _attach_geom_2d($parent_geom);
    basegeom = $parent_geom[0]=="conoid" ? attach_geom(r=2,h=2,axis=$parent_geom[5])
             : $parent_geom[0]=="prismoid" ? attach_geom(size=[2,2,2],axis=$parent_geom[4])
             : attach_geom(size=[2,2,2]);
    childgeom = attach_geom([2,2,2]);
    child_abstract_anchor = is_vector(child) && !two_d ? _find_anchor(_make_anchor_legal(child,childgeom), childgeom) : undef;
    overlap = (overlap!=undef)? overlap : $overlap;
    parent = first_defined([parent,from]);
    anchors = is_vector(parent) || is_string(parent) ? [parent] : parent;
    align_list = is_undef(align) ? [undef]
               : is_vector(align) || is_string(align) ? [align] : align;
    dummy4 = assert(is_string(parent) || is_list(parent), "\nInvalid parent anchor or anchor list.")
             assert(spin==0 || (!two_d || is_undef(child)), "\nspin is not allowed for 2d objects when 'child' is given.");
    child_temp = first_defined([child,to]);
    child = two_d ? _force_anchor_2d(child_temp) : child_temp;
    dummy2=assert(align_list==[undef] || is_def(child), "\nCannot use 'align' without 'child'.")
           assert(!inside || is_def(child), "\nCannot use 'inside' without 'child'.")
           assert(inset==0 || is_def(child), "\nCannot specify 'inset' without 'child'.")
           assert(inset==0 || is_def(align), "\nCannot specify 'inset' without 'align'.")
           assert(shiftout==0 || is_def(child), "\nCannot specify 'shiftout' without 'child'.");
    factor = inside?-1:1;
    $attach_to = child;
    for (anch_ind = idx(anchors)) {
        dummy=assert(is_string(anchors[anch_ind]) || (is_vector(anchors[anch_ind]) && (len(anchors[anch_ind])==2 || len(anchors[anch_ind])==3)),
                     str("\nParent[",anch_ind,"] is ",anchors[anch_ind]," but it must be a named anchor (string), a 2-vector, or 3-vector."))
              assert(align_list==[undef] || !is_string(anchors[anch_ind]),
                     str("\nParent[",anch_ind,"] is a named anchor (",anchors[anch_ind],"), but named anchors are not supported with align=."));
        anchor = is_string(anchors[anch_ind])? anchors[anch_ind]
               : two_d?_force_anchor_2d(anchors[anch_ind])
               : point3d(anchors[anch_ind]);
        $anchor=anchor;
        anchor_data = _find_anchor(anchor, $parent_geom);
        $edge_angle = len(anchor_data)==5 ? struct_val(anchor_data[4],"edge_angle") : undef;
        $edge_length = len(anchor_data)==5 ? struct_val(anchor_data[4],"edge_length") : undef;
        $edge_end1 = len(anchor_data)==5 ? struct_val(anchor_data[4],"vec") : undef;
        anchor_pos = anchor_data[1];
        anchor_dir = factor*anchor_data[2];
        anchor_spin = two_d || !inside || anchor==TOP || anchor==BOT ? anchor_data[3]
                    : let(spin_dir = rot(anchor_data[3],from=UP, to=-anchor_dir, p=BACK))
                      _compute_spin(anchor_dir,spin_dir);
        parent_abstract_anchor = is_vector(anchor) && !two_d ? _find_anchor(_make_anchor_legal(anchor,basegeom),basegeom) : undef;
        for(align_ind = idx(align_list)){
            align = is_undef(align_list[align_ind]) ? undef
                  : assert(is_vector(align_list[align_ind],2) || is_vector(align_list[align_ind],3), "\nAlign direction must be a 2-vector or 3-vector.")
                    two_d ? _force_anchor_2d(align_list[align_ind])
                  : point3d(align_list[align_ind]);
            spin = is_num(spin) ? spin
                 : align==CENTER ? 0
                 : sum(v_abs(anchor))==1 ?   // parent anchor is a face
                   let(
                       spindir = in_list(anchor,[TOP,BOT]) ? BACK : UP,
                       proj = project_plane(point4d(anchor),[spindir,align]),
                       ang = v_theta(proj[1])-v_theta(proj[0])
                   )
                   ang
                 : // parent anchor is not a face, so must be an edge (corners not allowed)
                   let(
                        nativeback = apply(rot(to=parent_abstract_anchor[2],from=UP)
                                       *affine3d_zrot(parent_abstract_anchor[3]), BACK)
                    )
                    nativeback*align<0 ? -180:0;
            $idx = align_ind+len(align_list)*anch_ind;
            $align=align;
            goodcyl = $parent_geom[0] != "conoid" || is_undef(align) || align==CTR ? true
                    : let(
                           align=rot(from=$parent_geom[5],to=UP,p=align),
                           anchor=rot(from=$parent_geom[5],to=UP,p=anchor)
                      )
                      anchor==TOP || anchor==BOT || align==TOP || align==BOT;
            badcorner = !in_list($parent_geom[0],["conoid","spheroid"]) && !is_undef(align) && align!=CTR && sum(v_abs(anchor))==3;
            badsphere = $parent_geom[0]=="spheroid" && !is_undef(align) && align!=CTR;
            dummy=assert(is_undef(align) || all_zero(v_mul(anchor,align)),
                         str("\nInvalid alignment: align value (",align,") includes component parallel to parent anchor (",anchor,")."))
                  assert(goodcyl, str("\nCannot use align with an anchor on a curved edge or surface of a cylinder at parent anchor (",anchor,")."))
                  assert(!badcorner, str("\nCannot use align at a corner anchor (",anchor,")."))
                  assert(!badsphere, "\nCannot use align on spheres.");
            // Now compute position on the parent (including alignment but not inset) where the child will be anchored
            pos = is_undef(align) ? anchor_data[1] : _find_anchor(anchor+align, $parent_geom)[1];
            $attach_anchor = list_set(anchor_data, 1, pos);      // Never used;  For user informational use?  Should this be set at all?
            // Compute adjustment to the child anchor for position purposes.  This adjustment
            // accounts for the change in the anchor needed to to alignment.
            child_adjustment = is_undef(align)? CTR
                              : two_d ? rot(to=child,from=-factor*anchor,p=align)
                              : apply(   rot(to=child_abstract_anchor[2],from=UP)
                                            * affine3d_zrot(child_abstract_anchor[3])
                                            * affine3d_yrot(inside?0:180)
                                       * affine3d_zrot(-parent_abstract_anchor[3])
                                            *  rot(from=parent_abstract_anchor[2],to=UP)
                                            * rot(v=anchor,-spin),
                                      align);
            // The $anchor_override anchor value forces an override of the *position* only for the anchor
            // used when attachable() places the child
            $anchor_override = all_zero(child_adjustment)? inside?child:undef
                             : child+child_adjustment;

            reference = two_d? BACK : UP;
            // inset_dir is the direction for insetting when alignment is in effect
            inset_dir = is_undef(align) ? CTR
                      : two_d ? rot(to=reference, from=anchor,p=align)
                      : apply(affine3d_yrot(inside?180:0)
                                * affine3d_zrot(-parent_abstract_anchor[3])
                                * rot(from=parent_abstract_anchor[2],to=UP)
                                * rot(v=anchor,-spin),
                              align);
            spinaxis = two_d? UP : anchor_dir;
            olap = - overlap * reference - inset*inset_dir + shiftout * (inset_dir + factor*reference*($anchor_inside?-1:1));
            if (norot || (approx(anchor_dir,reference) && anchor_spin==0)) 
                translate__1(pos) rot(v=spinaxis,a=factor*spin) translate__1(olap) default_tag("remove",removetag) children();
            else  
                translate__1(pos)
                    rot(v=spinaxis,a=factor*spin)
                    rot(anchor_spin,from=reference,to=anchor_dir)
                    translate__1(olap)
                    default_tag("remove",removetag) children();
        }
    }
}

// Section: Tagging

// Module: tag()
// Synopsis: Assigns a tag to an object
// Topics: Attachments
// See Also: tag_this(), force_tag(), recolor(), hide(), show_only(), diff(), intersect()
// Usage:
//   PARENT() tag(tag) CHILDREN;
// Description:
//   Assigns the specified tag to all of the children. Note that if you want
//   to apply a tag to non-tag-aware objects you need to use {{force_tag()}} instead.
//   This works by setting the `$tag` variable, but it provides extra error checking and
//   handling of scopes.  You may set `$tag` directly yourself, but this is not recommended.
//   .
//   For a step-by-step explanation of tagged attachments, see the [Attachments Tutorial](Tutorial-Attachment-Tags).
// Arguments:
//   tag = tag string, which must not contain any spaces.
// Side Effects:
//   Sets `$tag` to the tag you specify, possibly with a scope prefix.
// Example(3D):  Applies the tag to both cuboids instead of having to repeat `$tag="remove"` for each one.
//   diff("remove")
//     cuboid(10){
//       position(TOP) cuboid(3);
//       tag("remove")
//       {
//         position(FRONT) cuboid(3);
//         position(RIGHT) cuboid(3);
//       }
//     }
module tag(tag)
{
    req_children($children);
    check=
      assert(is_string(tag),"\n'tag' must be a string.")
      assert(undef==str_find(tag," "),str("\nTag string \"",tag,"\" contains a space, which is not allowed."));
    $tag = str($tag_prefix,tag);
    children();
}

// Module: default_tag()
// Synopsis: Conditionally set a default tag for all children.
// Topics: Attachments
// See Also: force_tag(), recolor(), hide(), show_only(), diff(), intersect()
// Usage:
//   PARENT() default_tag(tag, [do_tag]) CHILDREN;
// Description:
//   Sets a default tag for all of the children.  This is intended to be used to set a tag for a whole module
//   that is then used outside the module, such as setting the tag to "remove" for easy operation with {{diff()}}.
//   The default_tag() module sets the `$tag` variable only if it is not already
//   set so you can have a module set a default tag of "remove" but that tag can be overridden by a {{tag()}}
//   in force from a parent.  If you use {{tag()}}, it overrides any previously
//   specified tag from a parent, which can be confusing to a user trying to change the tag on a module.
//   The `do_tag` parameter allows you to apply a default tag conditionally without having to repeat the children.  
//   .
//   For a step-by-step explanation of tagged attachments, see the [Attachments Tutorial](Tutorial-Attachment-Tags).
// Arguments:
//   tag = tag string, which must not contain any spaces.
//   do_tag = if false do not set the tag.  Default: true
// Side Effects:
//   Sets `$tag` to the tag you specify, possibly with a scope prefix.
// Example(3D):  The module thing() is defined with {{tag()}} and the user applied tag of "keep_it" is ignored, leaving the user puzzled.
//   module thing() { tag("remove") cuboid(10);}
//   diff()
//     cuboid(20){
//       position(TOP) thing();
//       position(RIGHT) tag("keep_it") thing();
//   }
// Example(3D):  Using default_tag() fixes this problem: the user applied tag does not get overridden by the tag hidden in the module definition.
//   module thing() { default_tag("remove") cuboid(10);}
//   diff()
//     cuboid(20){
//       position(TOP) thing();
//       position(RIGHT) tag("keep_it") thing();
//   }
module default_tag(tag,do_tag=true)
{
    if ($tag=="" && do_tag) tag(tag) children();
    else children();
}

// Section: Making your objects attachable


// Module: attachable()
// Synopsis: Manages the anchoring, spin, orientation, and attachments for an object.
// Topics: Attachments
// See Also: reorient()
// Usage: Square/Trapezoid Geometry
//   attachable(anchor, spin, two_d=true, size=, [size2=], [shift=], [override=], ...) {OBJECT; children();}
// Usage: Circle/Oval Geometry
//   attachable(anchor, spin, two_d=true, r=|d=, ...) {OBJECT; children();}
// Usage: 2D Path/Polygon Geometry
//   attachable(anchor, spin, two_d=true, path=, [extent=], ...) {OBJECT; children();}
// Usage: 2D Region Geometry
//   attachable(anchor, spin, two_d=true, region=, [extent=], ...) {OBJECT; children();}
// Usage: Cubical/Prismoidal Geometry
//   attachable(anchor, spin, [orient], size=, [size2=], [shift=], [override=],  ...) {OBJECT; children();}
// Usage: Cylindrical Geometry
//   attachable(anchor, spin, [orient], r=|d=, l=, [axis=], ...) {OBJECT; children();}
// Usage: Conical Geometry
//   attachable(anchor, spin, [orient], r1=|d1=, r2=|d2=, l=, [axis=], ...) {OBJECT; children();}
// Usage: Spheroid/Ovoid Geometry
//   attachable(anchor, spin, [orient], r=|d=, ...) {OBJECT; children();}
// Usage: Extruded Path/Polygon Geometry
//   attachable(anchor, spin, path=, l=|h=, [extent=], ...) {OBJECT; children();}
// Usage: Extruded Region Geometry
//   attachable(anchor, spin, region=, l=|h=, [extent=], ...) {OBJECT; children();}
// Usage: VNF Geometry
//   attachable(anchor, spin, [orient], vnf=, [extent=], ...) {OBJECT; children();}
// Usage: Pre-Specified Geometry
//   attachable(anchor, spin, [orient], geom=) {OBJECT; children();}
//
// Description:
//   Manages the anchoring, spin, orientation, and attachments for OBJECT, located in a 3D volume or 2D area.
//   A managed 3D volume is assumed to be vertically (Z-axis) oriented, and centered.
//   A managed 2D area is just assumed to be centered.  The shape to be managed is given
//   as the first child to this module, and the second child should be given as `children()`.
//   For example, to manage a conical shape:
//   ```openscad
//   attachable(anchor, spin, orient, r1=r1, r2=r2, l=h) {
//       cyl(r1=r1, r2=r2, l=h);
//       children();
//   }
//   ```
//   .
//   If this is *not* run as a child of `attach()` with the `child` argument
//   given, then the following transformations are performed in order:
//   * Translates so the `anchor` point is at the origin (0,0,0).
//   * Rotates around the Z axis by `spin` degrees counter-clockwise.
//   * Rotates so the top of the part points toward the vector `orient`.
//   .
//   If this is called as a child of `attach(parent,child)`, then the info
//   for the anchor points referred to by `parent` and `child` are fetched,
//   which includes position, direction, and spin.  With that info,
//   the following transformations are performed:
//   * Translates this part so its anchor position matches the parent's anchor position.
//   * Rotates this part so its anchor direction vector exactly opposes the parent's anchor direction vector.
//   * Rotates this part so its anchor spin matches the parent's anchor spin.
//   .
//   In addition to handling positioning of the attachable object, 
//   this module is also responsible for handing coloring of objects with {{recolor()}} and {{color_this()}}, and
//   it is responsible for processing tags and determining whether the object should
//   display or not in the current context.  The determination based on the tags of whether to display the attachable object
//   often occurs in this module, meaning that an object that does not display (e.g. a "remove" tagged object
//   inside {{diff()}}) cannot have internal {{tag()}} calls that change its tags and cause submodel
//   portions to display: the entire object simply does not run.  If you want the use the attachable object's internal tags outside
//   of the attachable object you can set `expose_tags=true` to delay the determination to display objects to the children.
//   For this to work correctly, all of the children must be attachables.  An example situation where you should set
//   `expose_tags=true` is when you want to have negative space in an attachable object that gets removed from the parent via
//   a "remove" tagged component of your attachable.  
//   .
//   Application of {{recolor()}} and {{color_this()}} also happens in this module and normally it applies to the
//   entire attachable object, so coloring commands that you give internally in the first child to `attachable()` have no effect.
//   Generally it makes sense that if a user specifies a color for an attachable object, the entire object is displayed
//   in that color, but if you want to retain control of color for sub-parts of an attachable object, you can use
//   the `keep_color=true` option, which delays the assignment of colors to the child level.  For this to work
//   correctly, all of the sub-parts of your attachable object must be attachables.  Also note that this option could
//   be confusing to users who don't understand why color commands are not working on the object.
//   .
//   Note that anchors created by attachable() are generally intended for use by the user-supplied children of the attachable object, but they
//   are available internally and can be used in the object's definition.  
//   .
//   For a step-by-step explanation of making objects attachable, see the [Attachments Tutorial](Tutorial-Attachment-Making).
//
// Arguments:
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
//   ---
//   size = If given as a 3D vector, contains the XY size of the bottom of the cuboidal/prismoidal volume, and the Z height.  If given as a 2D vector, contains the front X width of the rectangular/trapezoidal shape, and the Y length.
//   size2 = If given as a 2D vector, contains the XY size of the top of the prismoidal volume.  If given as a number, contains the back width of the trapezoidal shape.
//   shift = If given as a 2D vector, shifts the top of the prismoidal or conical shape by the given amount.  If given as a number, shifts the back of the trapezoidal shape right by that amount.  Default: No shift.
//   scale = Scalar or 2-vector scaling the top of an extruded path or region relative to the bottom. Default: `[1,1]`
//   r = Radius of the cylindrical/conical volume.  Can be a scalar, or a list of sizes per axis.
//   d = Diameter of the cylindrical/conical volume.  Can be a scalar, or a list of sizes per axis.
//   r1 = Radius of the bottom of the conical volume.  Can be a scalar, or a list of sizes per axis.
//   r2 = Radius of the top of the conical volume.  Can be a scalar, or a list of sizes per axis.
//   d1 = Diameter of the bottom of the conical volume.  Can be a scalar, a list of sizes per axis.
//   d2 = Diameter of the top of the conical volume.  Can be a scalar, a list of sizes per axis.
//   l/h = Length of the cylindrical, conical, or extruded path volume along axis.
//   vnf = The [VNF](vnf.scad) of the volume.
//   path = The path to generate a polygon from.
//   region = The region to generate a shape from.
//   extent = If true, calculate anchors by extents, rather than intersection, for VNFs and paths.  Default: true.
//   cp = If given, specifies the centerpoint of the volume for an object whose anchor center is not at its true center.  All of the directional anchors shift by this vector.  Default: `[0,0,0]`
//   offset = If given, offsets the non-centered anchor components, while leaving centered components (including CENTER itself) unchanged. Ignored for region, extrusion, and VNF geometries.
//   anchors = If given as a list of anchor points, allows named anchor points.
//   two_d = If true, the attachable shape is 2D.  If false, 3D.  Default: false (3D)
//   axis = The vector pointing along the axis of a geometry.  Default: UP
//   override = Function that takes an anchor and for 3d returns a triple `[position, direction, spin]` or for 2d returns a pair `[position,direction]` to use for that anchor to override the normal one.  You can also supply a lookup table that is a list of `[anchor, [position, direction, spin]]` entries.  If the direction/position/spin that is returned is undef then the default is used.  This option applies only to the "trapezoid", "prismoid", "conoid", "ellipse", and "vnf_*"  geometry types.  
//   geom = If given, uses the pre-defined geometry produced by {{attach_geom()}}.
//   parts = List of named attachable parts created with {{define_part()}}. Select a part with {{attach_part()}}. Default: `[]`
//   expose_tags = If true then delay the decision to display or not display this object to the children, which it possible for tags to respond to operations like {{diff()}} used outside the attachble object. This works correctly only if everything in the attachable is also attachable.  Default: false
//   keep_color = If true then delay application of color to the children, which means that externally applied color is overridden by color specified within the attachable. This works properly only if everything in the attachable is also attacahble.  Default: false
//
// Side Effects:
//   `$parent_anchor` is set to the parent object's `anchor` value.
//   `$parent_spin` is set to the parent object's `spin` value.
//   `$parent_orient` is set to the parent object's `orient` value.
//   `$parent_geom` is set to the parent object's `geom` value.
//   `$parent_size` is set to the parent object's cubical `[X,Y,Z]` volume size.
//   `$color` is used to set the color of the object
//   `$save_color` is used to revert color to the parent's color
//
// Example(NORENDER): Cubical Shape
//   attachable(anchor, spin, orient, size=size) {
//       cube(size, center=true);
//       children();
//   }
//
// Example(NORENDER): Prismoidal Shape
//   attachable(
//       anchor, spin, orient,
//       size=point3d(botsize,h),
//       size2=topsize,
//       shift=shift
//   ) {
//       prismoid(botsize, topsize, h=h, shift=shift);
//       children();
//   }
//
// Example(NORENDER): Cylindrical Shape, Z-Axis Aligned
//   attachable(anchor, spin, orient, r=r, l=h) {
//       cyl(r=r, l=h);
//       children();
//   }
//
// Example(NORENDER): Cylindrical Shape, Y-Axis Aligned
//   attachable(anchor, spin, orient, r=r, l=h, axis=BACK) {
//       cyl(r=r, l=h, orient=BACK);
//       children();
//   }
//
// Example(NORENDER): Cylindrical Shape, X-Axis Aligned
//   attachable(anchor, spin, orient, r=r, l=h, axis=RIGHT) {
//       cyl(r=r, l=h, orient=RIGHT);
//       children();
//   }
//
// Example(NORENDER): Conical Shape, Z-Axis Aligned
//   attachable(anchor, spin, orient, r1=r1, r2=r2, l=h) {
//       cyl(r1=r1, r2=r2, l=h);
//       children();
//   }
//
// Example(NORENDER): Conical Shape, Y-Axis Aligned
//   attachable(anchor, spin, orient, r1=r1, r2=r2, l=h, axis=BACK) {
//       cyl(r1=r1, r2=r2, l=h, orient=BACK);
//       children();
//   }
//
// Example(NORENDER): Conical Shape, X-Axis Aligned
//   attachable(anchor, spin, orient, r1=r1, r2=r2, l=h, axis=RIGHT) {
//       cyl(r1=r1, r2=r2, l=h, orient=RIGHT);
//       children();
//   }
//
// Example(NORENDER): Spherical Shape
//   attachable(anchor, spin, orient, r=r) {
//       sphere(r=r);
//       children();
//   }
//
// Example(NORENDER): Extruded Polygon Shape, by Extents
//   attachable(anchor, spin, orient, path=path, l=length, scale=scale) {
//       linear_extrude(height=length, center=true, scale=scale)
//           polygon(path);
//       children();
//   }
//
// Example(NORENDER): Extruded Polygon Shape, by Intersection
//   attachable(anchor, spin, orient, path=path, l=length, extent=false, scale=scale) {
//       linear_extrude(height=length, center=true, scale=scale)
//           polygon(path);
//       children();
//   }
//
// Example(NORENDER): Arbitrary VNF Shape, by Extents
//   attachable(anchor, spin, orient, vnf=vnf) {
//       vnf_polyhedron(vnf);
//       children();
//   }
//
// Example(NORENDER): Arbitrary VNF Shape, by Intersection
//   attachable(anchor, spin, orient, vnf=vnf, extent=false) {
//       vnf_polyhedron(vnf);
//       children();
//   }
//
// Example(NORENDER): 2D Rectangular Shape
//   attachable(anchor, spin, orient, two_d=true, size=size) {
//       square(size, center=true);
//       children();
//   }
//
// Example(NORENDER): 2D Trapezoidal Shape
//   attachable(
//       anchor, spin, orient,
//       two_d=true,
//       size=[x1,y],
//       size2=x2,
//       shift=shift
//   ) {
//       trapezoid(w1=x1, w2=x2, h=y, shift=shift);
//       children();
//   }
//
// Example(NORENDER): 2D Circular Shape
//   attachable(anchor, spin, orient, two_d=true, r=r) {
//       circle(r=r);
//       children();
//   }
//
// Example(NORENDER): Arbitrary 2D Polygon Shape, by Extents
//   attachable(anchor, spin, orient, two_d=true, path=path) {
//       polygon(path);
//       children();
//   }
//
// Example(NORENDER): Arbitrary 2D Polygon Shape, by Intersection
//   attachable(anchor, spin, orient, two_d=true, path=path, extent=false) {
//       polygon(path);
//       children();
//   }
//
// Example(NORENDER): Using Pre-defined Geometry
//   r = max([for(pt=path) norm(pt)]);
//   geom = atype=="perim"? attach_geom(two_d=true, region=[path], extent=false) :
//       atype=="extents"? attach_geom(two_d=true, region=[path], extent=true) :
//       atype=="circle"? attach_geom(two_d=true, r=r) :
//       assert(false, "Bad atype");
//   attachable(anchor, spin, orient, geom=geom) {
//       polygon(path);
//       children();
//   }
//
// Example: An object can be designed to attach as negative space using {{diff()}}, but if you want an object to include both positive and negative space then you run into trouble because tags inside the `attachable()` are ignored.  One solution is to call attachable() twice.  This example shows how two calls to  attachable can create an object with positive and negative space.  Note, however, that children in the negative space are differenced away: the highlighted little cube does not survive into the final model.
//   module thing(anchor,spin,orient) {
//      tag("remove") attachable(size=[15,15,15],anchor=anchor,spin=spin,orient=orient){
//        cuboid([10,10,16]);
//        union(){}   // dummy children
//      }
//      attachable(size=[15,15,15], anchor=anchor, spin=spin, orient=orient){
//        cuboid([15,15,15]);
//        children();
//      }
//   }
//   diff()
//     cube([19,10,19])
//       attach([FRONT],overlap=-4)
//         thing(anchor=TOP)
//           # attach(TOP) cuboid(2,anchor=TOP);
// Example: Here is an example where the "keep" tag allows children to appear in the negative space.  That tag is also needed for this module to produce the desired output.  As above, the tag must be applied outside the attachable() call.
//   module thing(anchor = CENTER, spin = 0, orient = UP) {
//      tag("remove") attachable(anchor, spin, orient, d1=0,d2=95,h=33) {
//          cylinder(h = 33.1, d1 = 0, d2 = 95, anchor=CENTER);
//          union(){}  // dummy children
//      }
//      tag("keep") attachable(anchor, spin, orient,d1=0,d2=95,h=33) {
//            cylinder(h = 33, d = 10,anchor=CENTER);
//            children();
//        }
//    }
//    diff()
//      cube(100)
//        attach([FRONT,TOP],overlap=-4)
//          thing(anchor=TOP)
//            tube(ir=12,h=10);
// Example: A different way to achieve similar effects to the above to examples is to use the `expose_tags` parameter.  This parameter allows you to use just one call to attachable.  The second example above can also be rewritten like this. 
//   module thing(anchor,spin,orient) {
//      attachable(size=[15,15,15],anchor=anchor,spin=spin,orient=orient,expose_tags=true){
//        union(){
//          cuboid([15,15,15]);
//          tag("remove")cuboid([10,10,16]);
//        }
//        children();
//      }
//   }
//   diff()
//     cube([19,10,19])
//       attach([FRONT],overlap=-4)
//         thing(anchor=TOP);
// Example: An advantage of using `expose_tags` is that it can work on nested constructions.  Here the child cylinder is aligned relative to its parent and removed from the calling parent object.
//   $fn=64;
//   module thing(anchor=BOT){
//     attachable(anchor = anchor,d=9,h=6,expose_tags=true){
//       cyl(d = 9, h = 6) 
//         tag("remove") 
//            align(RIGHT+TOP,inside=true) 
//                 left(1)up(1)cyl(l=11, d=3);
//       children();
//     }
//   }
//   back_half()
//     diff()
//       cuboid(10)
//         position(TOP)thing(anchor=BOT);
// Example(3D,NoAxes): Here an attachable module uses {{recolor()}} to change the color of a sub-part, producing the result shown on the left.  But if the caller applies color to the attachable, then both the green and yellow are changed, as shown on the right.  
//   module thing(anchor=CENTER) {
//       attachable(anchor,size=[10,10,10]) {
//           cuboid(10)
//             position(TOP) recolor("green")
//               cuboid(5,anchor=BOT);
//           children();
//       }
//   }
//   move([-15,-15])
//   thing()
//     attach(RIGHT,BOT)
//       recolor("blue") cyl(d=5,h=5);
//   recolor("pink") thing()
//     attach(RIGHT,BOT)
//       recolor("blue") cyl(d=5,h=5);
// Example(3D,NoAxes): Using the `keep_color=true` option enables the green color to persist, even when the user specifies a color.
//   module thing(anchor=CENTER) {
//       attachable(anchor,size=[10,10,10],keep_color=true) {
//           cuboid(10)
//             position(TOP) recolor("green")
//               cuboid(5,anchor=BOT);
//           children();
//       }
//   }
//   recolor("pink") thing()
//     attach(RIGHT,BOT)
//       recolor("blue") cyl(d=5,h=5);
// Example(3D,NoScale): This example defines named anchors and then uses them internally in the object definition to make a cutout in the socket() object and to attach the plug on the plug() object.  These objects can be connected using the "socket" and "plug" named anchors, which fit the plug into the socket.
//   module socket(anchor, spin, orient) {
//       sz = 50;
//       prong_size = 10;
//       anchors = [
//           named_anchor("socket", [sz/2,.15*sz,.2*sz], RIGHT, 0)
//       ];
//       attachable(anchor, spin, orient, size=[sz,sz,sz], anchors=anchors) {
//           diff() {
//               cuboid(sz);
//               tag("remove") attach("socket") zcyl(d=prong_size, h=prong_size*2, $fn=6);
//           }
//           children();
//       }
//   }
//   module plug(anchor, spin, orient) {
//       sz = 30;
//       prong_size = 9.5;
//       anchors=[
//           named_anchor("plug", [0,sz/3,sz/2], UP, 0)
//       ];
//       attachable(anchor, spin, orient, size=[sz,sz,sz], anchors=anchors) {
//          union(){
//            cuboid(sz);
//            attach("plug") cyl(d=prong_size, h=prong_size*2,$fn=6);
//          }
//          children();
//       }
//   }
//   socket();
//   right(75) plug();
module attachable(
    anchor, spin, orient,
    size, size2, shift,
    r,r1,r2, d,d1,d2, l,h,
    vnf, path, region, scale,
    extent=true,
    cp=[0,0,0],
    offset=[0,0,0],
    anchors=[],
    two_d=false,
    axis=UP,override,
    geom,
    parts=[],
    expose_tags=false, keep_color=false
) {
    dummy1 =
        assert($children==2, "\nattachable() expects exactly two children: the shape to manage, and the union of all attachments.")
        assert(is_undef(anchor) || is_vector(anchor) || is_string(anchor), str("Invalid anchor: ",anchor))
        assert(is_undef(spin) || is_finite(spin), str("\nInvalid spin: ",spin))
        assert(is_undef(orient) || is_vector(orient,3), str("\nInvalid orient: ",orient));
        assert(in_list(v_abs(axis),[UP,RIGHT,BACK]), "\n'axis' must be a coordinate direction.");
    anchor = default(anchor,CENTER);
    spin = default(spin,0); 
    orient = is_def($anchor_override)? UP : default(orient, UP);
    region = !is_undef(region)? region :
        !is_undef(path)? [path] :
        undef;
    geom = is_def(geom)? geom :
        attach_geom(
            size=size, size2=size2, shift=shift,
            r=r, r1=r1, r2=r2, h=h,
            d=d, d1=d1, d2=d2, l=l, scale=scale,
            vnf=vnf, region=region, extent=extent,
            cp=cp, offset=offset, anchors=anchors,
            two_d=two_d, axis=axis, override=override
        );
    final_geom=_change_anchors(geom);
    m = _attach_transform(anchor,spin,orient,final_geom);
    multmatrix__1(m) {
        $parent_anchor = anchor;
        $parent_spin   = spin;
        $parent_orient = orient;
        $parent_geom   = final_geom;
        $parent_size   = _attach_geom_size(final_geom);
        $attach_to   = undef;
        $anchor_override=undef;
        $attach_alignment=undef;
        $parent_parts = parts;
        $anchor_inside = false;
        $change_anchors = undef;
        if (!$hide_this && (expose_tags || _is_shown())){
            if (!keep_color)
                _color($color[0],$color[1])
                  _show_ghost() children(0);
            else {
                $save_color=undef; // Force color_this() color in effect to persist for the entire object
                _show_ghost() children(0);
            }
        }
        let(
            $hide_this=false,
            $ghost_this=false,
            $highlight_this=false,
            $tag=default($save_tag,$tag),
            $save_tag=undef,
            $color=default($save_color,$color),
            $save_color=undef
        )
        children(1);
   }
}

module _show_highlight()
{
  if ($highlight || $highlight_this)
    #children();
  else
    children();
}

module _show_ghost()
{  
    if (($ghost || $ghost_this) && !$ghosting)
        %union(){
           $ghosting=true;
           _show_highlight()children();
        }
    else _show_highlight()children();
}

// Function: reorient()
// Synopsis: Calculates the transformation matrix needed to reorient an object.
// SynTags: Trans, Path, VNF
// Topics: Attachments
// See Also: reorient(), attachable()
// Usage: Square/Trapezoid Geometry
//   mat = reorient(anchor, spin, [orient], two_d=true, size=, [size2=], [shift=], ...);
//   pts = reorient(anchor, spin, [orient], two_d=true, size=, [size2=], [shift=], p=, ...);
// Usage: Circle/Oval Geometry
//   mat = reorient(anchor, spin, [orient], two_d=true, r=|d=, ...);
//   pts = reorient(anchor, spin, [orient], two_d=true, r=|d=, p=, ...);
// Usage: 2D Path/Polygon Geometry
//   mat = reorient(anchor, spin, [orient], two_d=true, path=, [extent=], ...);
//   pts = reorient(anchor, spin, [orient], two_d=true, path=, [extent=], p=, ...);
// Usage: 2D Region/Polygon Geometry
//   mat = reorient(anchor, spin, [orient], two_d=true, region=, [extent=], ...);
//   pts = reorient(anchor, spin, [orient], two_d=true, region=, [extent=], p=, ...);
// Usage: Cubical/Prismoidal Geometry
//   mat = reorient(anchor, spin, [orient], size=, [size2=], [shift=], ...);
//   vnf = reorient(anchor, spin, [orient], size=, [size2=], [shift=], p=, ...);
// Usage: Cylindrical Geometry
//   mat = reorient(anchor, spin, [orient], r=|d=, l=, [axis=], ...);
//   vnf = reorient(anchor, spin, [orient], r=|d=, l=, [axis=], p=, ...);
// Usage: Conical Geometry
//   mat = reorient(anchor, spin, [orient], r1=|d1=, r2=|d2=, l=, [axis=], ...);
//   vnf = reorient(anchor, spin, [orient], r1=|d1=, r2=|d2=, l=, [axis=], p=, ...);
// Usage: Spheroid/Ovoid Geometry
//   mat = reorient(anchor, spin, [orient], r|d=, ...);
//   vnf = reorient(anchor, spin, [orient], r|d=, p=, ...);
// Usage: Extruded Path/Polygon Geometry
//   mat = reorient(anchor, spin, [orient], path=, l=|h=, [extent=], ...);
//   vnf = reorient(anchor, spin, [orient], path=, l=|h=, [extent=], p=, ...);
// Usage: Extruded Region Geometry
//   mat = reorient(anchor, spin, [orient], region=, l=|h=, [extent=], ...);
//   vnf = reorient(anchor, spin, [orient], region=, l=|h=, [extent=], p=, ...);
// Usage: VNF Geometry
//   mat = reorient(anchor, spin, [orient], vnf=, [extent=], ...);
//   vnf = reorient(anchor, spin, [orient], vnf=, [extent=], p=, ...);
//
// Description:
//   Given anchor, spin, orient, and general geometry info for a managed volume, this calculates
//   the transformation matrix needed to be applied to the contents of that volume.  A managed 3D
//   volume is assumed to be vertically (Z-axis) oriented, and centered.  A managed 2D area is just
//   assumed to be centered.
//   .
//   If `p` is not given, then the transformation matrix is returned.
//   If `p` contains a VNF, a new VNF is returned with the vertices transformed by the matrix.
//   If `p` contains a path, a new path is returned with the vertices transformed by the matrix.
//   If `p` contains a point, a new point is returned, transformed by the matrix.
//   .
//   The following transformations are performed in order:
//   * Translate so the `anchor` point is at the origin (0,0,0).
//   * Rotate around the Z axis by `spin` degrees counter-clockwise.
//   * In 3D, totate so the top of the part points toward the vector `orient`.
//   .
//   For a step-by-step explanation of attachments, see the [Attachments Tutorial](Tutorial-Attachment-Basic-Positioning).
//
// Arguments:
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
//   ---
//   size = If given as a 3D vector, contains the XY size of the bottom of the cuboidal/prismoidal volume, and the Z height.  If given as a 2D vector, contains the front X width of the rectangular/trapezoidal shape, and the Y length.
//   size2 = If given as a 2D vector, contains the XY size of the top of the prismoidal volume.  If given as a number, contains the back width of the trapezoidal shape.
//   shift = If given as a 2D vector, shifts the top of the prismoidal or conical shape by the given amount.  If given as a number, shifts the back of the trapezoidal shape right by that amount.  Default: No shift.
//   r = Radius of the cylindrical/conical volume.  Can be a scalar, or a list of sizes per axis.
//   d = Diameter of the cylindrical/conical volume.  Can be a scalar, or a list of sizes per axis.
//   r1 = Radius of the bottom of the conical volume.  Can be a scalar, or a list of sizes per axis.
//   r2 = Radius of the top of the conical volume.  Can be a scalar, or a list of sizes per axis.
//   d1 = Diameter of the bottom of the conical volume.  Can be a scalar, a list of sizes per axis.
//   d2 = Diameter of the top of the conical volume.  Can be a scalar, a list of sizes per axis.
//   l/h = Length of the cylindrical, conical, or extruded path volume along axis.
//   vnf = The [VNF](vnf.scad) of the volume.
//   path = The path to generate a polygon from.
//   region = The region to generate a shape from.
//   extent = If true, calculate anchors by extents, rather than intersection.  Default: true.
//   cp = If given, specifies the centerpoint of the volume for an object whose anchor center is not at its true center.  All of the directional anchors shift by this vector.  Default: `[0,0,0]`
//   cp = If given, specifies the centerpoint of the volume.  Default: `[0,0,0]`
//   offset = If given, offsets the non-centered anchor components, while leaving centered components (including CENTER itself) unchanged. Ignored for region, extrusion, and VNF geometries.
//   anchors = If given as a list of anchor points, allows named anchor points.
//   two_d = If true, the attachable shape is 2D.  If false, 3D.  Default: false (3D)
//   axis = The vector pointing along the axis of a geometry.  Default: UP
//   override = Function or lookup table overriding computed anchor positions, directions, and spins. See {{attachable()}} for supported geometry types and return formats.
//   geom = If given, uses pre-defined geometry produced by {{attach_geom()}} instead of the individual geometry arguments.
//   p = The VNF, path, or point to transform.
function reorient(
    anchor, spin, orient,
    size, size2, shift,
    r,r1,r2, d,d1,d2, l,h,
    vnf, path, region,
    extent=true,
    offset=[0,0,0],
    cp=[0,0,0],
    anchors=[],
    two_d=false,
    axis=UP, override, 
    geom,
    p=undef
) = 
    assert(is_undef(anchor) || is_vector(anchor) || is_string(anchor), str("\nInvalid anchor: ",anchor))
    assert(is_undef(spin) || is_finite(spin), str("\nInvalid spin: ",spin))
    assert(is_undef(orient) || is_vector(orient,3), str("\nInvalid orient: ",orient))
    let(
        anchor = default(anchor, CENTER),
        spin =   default(spin,   0),
        orient = default(orient, UP),
        region = !is_undef(region)? region :
            !is_undef(path)? [path] :
            undef,
        geom = is_def(geom)? geom :
            attach_geom(
                size=size, size2=size2, shift=shift,
                r=r, r1=r1, r2=r2, h=h,
                d=d, d1=d1, d2=d2, l=l,
                vnf=vnf, region=region, extent=extent,
                cp=cp, offset=offset, anchors=anchors,
                two_d=two_d, axis=axis, override=override
            ),
        $attach_to = undef,
        $anchor_override= undef,
        $attach_alignment = undef
    ) _attach_transform(anchor,spin,orient,geom,p);

// Function: named_anchor()
// Synopsis: Creates an anchor data structure.
// Topics: Attachments
// See Also: reorient(), attachable()
// Usage:
//   a = named_anchor(name, pos, [orient], [spin]);
//   a = named_anchor(name, [pos], rot=, [flip=]);
// Description:
//   Creates an anchor data structure.  You can specify the position, orient direction and spin directly.
//   Alternatively for the 3D case you can give a 4×4 rotation matrix, which can specify the orient and spin, and optionally
//   the position, using a translation component of the matrix.  If you specify `pos` along with `rot` then the position you
//   give overrides any translation included in `rot`.  For a step-by-step explanation of attachments, 
//   see the [Attachments Tutorial](Tutorial-Attachment-Basic-Positioning).
// Arguments:
//   name = The string name of the anchor.  Lowercase.  Words separated by single dashes.  No spaces.
//   pos = The [X,Y,Z] position of the anchor.
//   orient = A vector pointing in the direction parts should project from the anchor position.  Default: UP
//   spin = If needed, the angle to rotate the part around the direction vector.  Default: 0
//   ---
//   info = structure listing info to be propagated to the attached child, e.g. "edge_anchor"
//   rot = A 4×4 rotations matrix, which may include a translation
//   flip = If true, flip the anchor the opposite direction.  Default: false
function named_anchor(name, pos, orient, spin, rot, flip, info) =
  assert(is_vector(orient) || is_undef(orient), "\norient must be a vector")
  assert(num_defined([orient,spin])==0 || num_defined([rot,flip])==0, "\nCannot mix orient or spin with rot or flip.")
  assert(num_defined([pos,rot])>0, "\nMust give pos or rot")
  let(orient=point3d(default(orient,UP)))
  is_undef(rot) ? [name, pos, orient, default(spin,0), if (info) info]
 : 
  let(
      flip = default(flip,false),
      pos = default(pos,apply(rot,CTR)),
      rotpart = _force_rot(rot),
      dummy = assert(approx(det4(rotpart),1), "\nInput rotation is not a rotation matrix."),
      dir = flip ? apply(rotpart,DOWN)
                 : apply(rotpart,UP),
      rot = flip? affine3d_rot_by_axis(apply(rotpart,BACK),180)*rot
                      : rot,
      decode=rot_decode(rot(to=UP,from=dir)*_force_rot(rot)),
      spin = decode[0]*sign(decode[1].z)
  )
  [name, pos, dir, spin, if (info) info];

// Module: change_anchors()
// Synopsis: Changes the named anchors inherited from the parent
// Topics: Attachments
// See Also: named_anchor(), attachable()
// Usage:
//   change_anchors([named],[alias=],[remove=]) PARENT() CHILDREN;
// Description:
//   Modifies the named anchors propagated an object or adds new named anchors.  The `named` parameter gives a list
//   of new or replacement named anchors, specified in the usual way with {{named_anchor()}}.
//   The `alias` parameter specifies a list of pairs of the form `[newname, anchor]` where
//   `newname` is a new anchor name and `anchor` is an existing anchor for the object, either a named anchor or a regular anchor.  The
//   existing anchor will be propagated to the child under the new name.  The old name is not changed,
//   and will also be propagated to the child.   The `remove` parameter removes named anchors defined by the object
//   so they are not propagated to the child.  You can use it to remove an anchor that you have
//   aliased so that only the new name propagates to the child.
//   .
//   This works by setting a `$change_anchors` which will be interpreted by the first `attachable()` child invocation.                  
// Arguments:
//   named = list of named anchors to add
//   ---
//   alias = list of string pairs of the form [newname,oldname] creating named anchor aliases
//   remove = list of strings giving anchors to remove
// Side Effects:
//   Sets `$change_anchors`.
function _change_anchors(geom) = 
    is_undef($change_anchors) || geom==[] ? geom
  :
    let(
         named=default($change_anchors[0],[]),
         alias=default($change_anchors[1],[]),
         remove=default($change_anchors[2],[]),
         oldanch = last(geom),
         allremove = concat(column(named,0), remove),
         keepanch = [for(anch=oldanch) if (!in_list(anch[0],allremove)) anch],
         aliasanch = [for(name=alias) list_set(_find_anchor(name[1],geom),0,name[0])],
         newanch = concat(keepanch, aliasanch, named),
         new_geom = list_set(geom,-1,newanch)
    )
    new_geom;

// Function: attach_geom()
// Synopsis: Returns the internal geometry description of an attachable object.
// Topics: Attachments
// See Also: reorient(), attachable()
// Usage: Null/Point Geometry
//   geom = attach_geom(...);
// Usage: Square/Trapezoid Geometry
//   geom = attach_geom(two_d=true, size=, [size2=], [shift=], ...);
// Usage: Circle/Oval Geometry
//   geom = attach_geom(two_d=true, r=|d=, ...);
// Usage: 2D Path/Polygon/Region Geometry
//   geom = attach_geom(two_d=true, region=, [extent=], ...);
// Usage: Cubical/Prismoidal Geometry
//   geom = attach_geom(size=, [size2=], [shift=], ...);
// Usage: Cylindrical Geometry
//   geom = attach_geom(r=|d=, l=|h=, [axis=], ...);
// Usage: Conical Geometry
//   geom = attach_geom(r1|d1=, r2=|d2=, l=, [axis=], ...);
// Usage: Spheroid/Ovoid Geometry
//   geom = attach_geom(r=|d=, ...);
// Usage: Extruded 2D Path/Polygon/Region Geometry
//   geom = attach_geom(region=, l=|h=, [extent=], [shift=], [scale=], [twist=], ...);
// Usage: VNF Geometry
//   geom = attach_geom(vnf=, [extent=], ...);
//
// Description:
//   Given arguments that describe the geometry of an attachable object, returns the internal geometry description.
//   This probably doesn't ever need to be called by the end user.
//
// Arguments:
//   ---
//   size = If given as a 3D vector, contains the XY size of the bottom of the cuboidal/prismoidal volume, and the Z height.  If given as a 2D vector, contains the front X width of the rectangular/trapezoidal shape, and the Y length.
//   size2 = If given as a 2D vector, contains the XY size of the top of the prismoidal volume.  If given as a number, contains the back width of the trapezoidal shape.
//   shift = If given as a 2D vector, shifts the top of the prismoidal or conical shape by the given amount.  If given as a number, shifts the back of the trapezoidal shape right by that amount.  Default: No shift.
//   scale = If given as number or a 2D vector, scales the top of the shape, relative to the bottom.  Default: `[1,1]`
//   twist = If given as number, rotates the top of the shape by the given number of degrees clockwise, relative to the bottom.  Default: `0`
//   r = Radius of the cylindrical/conical volume.  Can be a scalar, or a list of sizes per axis.
//   d = Diameter of the cylindrical/conical volume.  Can be a scalar, or a list of sizes per axis.
//   r1 = Radius of the bottom of the conical volume.  Can be a scalar, or a list of sizes per axis.
//   r2 = Radius of the top of the conical volume.  Can be a scalar, or a list of sizes per axis.
//   d1 = Diameter of the bottom of the conical volume.  Can be a scalar, a list of sizes per axis.
//   d2 = Diameter of the top of the conical volume.  Can be a scalar, a list of sizes per axis.
//   l/h = Length of the cylindrical, conical or extruded region volume along axis.
//   vnf = The [VNF](vnf.scad) of the volume.
//   region = The region to generate a shape from.
//   extent = If true, calculate anchors by extents, rather than intersection.  Default: true.
//   cp = If given, specifies the centerpoint of the volume for an object whose anchor center is not at its true center.  All of the directional anchors shift by this vector.  Default: `[0,0,0]`
//   offset = If given, offsets the non-centered anchor components, while leaving centered components (including CENTER itself) unchanged. Ignored for region, extrusion, and VNF geometries.
//   anchors = If given as a list of anchor points, allows named anchor points.
//   two_d = If true, the attachable shape is 2D.  If false, 3D.  Default: false (3D)
//   axis = The vector pointing along the axis of a geometry.  Default: UP
//   override = Function that takes an anchor and returns a pair `[position,direction,spin]` to use for that anchor to override the normal one.  You can also supply a lookup table that is a list of `[anchor, [position, direction,spin]]` entries.  If the direction/position/spin that is returned is undef then the default is used.
//
// Example(NORENDER): Null/Point Shape
//   geom = attach_geom();
//
// Example(NORENDER): Cubical Shape
//   geom = attach_geom(size=size);
//
// Example(NORENDER): Prismoidal Shape
//   geom = attach_geom(
//       size=point3d(botsize,h),
//       size2=topsize, shift=shift
//   );
//
// Example(NORENDER): Cylindrical Shape, Z-Axis Aligned
//   geom = attach_geom(r=r, h=h);
//
// Example(NORENDER): Cylindrical Shape, Y-Axis Aligned
//   geom = attach_geom(r=r, h=h, axis=BACK);
//
// Example(NORENDER): Cylindrical Shape, X-Axis Aligned
//   geom = attach_geom(r=r, h=h, axis=RIGHT);
//
// Example(NORENDER): Conical Shape, Z-Axis Aligned
//   geom = attach_geom(r1=r1, r2=r2, h=h);
//
// Example(NORENDER): Conical Shape, Y-Axis Aligned
//   geom = attach_geom(r1=r1, r2=r2, h=h, axis=BACK);
//
// Example(NORENDER): Conical Shape, X-Axis Aligned
//   geom = attach_geom(r1=r1, r2=r2, h=h, axis=RIGHT);
//
// Example(NORENDER): Spherical Shape
//   geom = attach_geom(r=r);
//
// Example(NORENDER): Ovoid Shape
//   geom = attach_geom(r=[r_x, r_y, r_z]);
//
// Example(NORENDER): Arbitrary VNF Shape, Anchored by Extents
//   geom = attach_geom(vnf=vnf);
//
// Example(NORENDER): Arbitrary VNF Shape, Anchored by Intersection
//   geom = attach_geom(vnf=vnf, extent=false);
//
// Example(NORENDER): 2D Rectangular Shape
//   geom = attach_geom(two_d=true, size=size);
//
// Example(NORENDER): 2D Trapezoidal Shape
//   geom = attach_geom(two_d=true, size=[x1,y], size2=x2, shift=shift, override=override);
//
// Example(NORENDER): 2D Circular Shape
//   geom = attach_geom(two_d=true, r=r);
//
// Example(NORENDER): 2D Oval Shape
//   geom = attach_geom(two_d=true, r=[r_x, r_y]);
//
// Example(NORENDER): Arbitrary 2D Region Shape, Anchored by Extents
//   geom = attach_geom(two_d=true, region=region);
//
// Example(NORENDER): Arbitrary 2D Region Shape, Anchored by Intersection
//   geom = attach_geom(two_d=true, region=region, extent=false);
//
// Example(NORENDER): Extruded Region, Anchored by Extents
//   geom = attach_geom(region=region, l=height);
//
// Example(NORENDER): Extruded Region, Anchored by Intersection
//   geom = attach_geom(region=region, l=length, extent=false);
//
function attach_geom(
    size, size2,
    shift, scale, twist,
    r,r1,r2, d,d1,d2, l,h,
    vnf, region,
    extent=true,
    cp=[0,0,0],
    offset=[0,0,0],
    anchors=[],
    two_d=false,
    axis=UP, override
) =
    assert(is_bool(extent))
    assert(is_vector(cp) || is_string(cp))
    assert(is_vector(offset))
    assert(is_list(anchors))
    assert(is_bool(two_d))
    assert(is_vector(axis))
    let(
        over_f = is_undef(override) ? function(anchor) [undef,undef,undef]
               : is_func(override) ? override
               : function(anchor) _local_struct_val(override,anchor)
    )
    !is_undef(size)? (
        two_d? (
            let(
                size2 = default(size2, size.x),
                shift = default(shift, 0)
            )
            assert(is_vector(size,2))
            assert(is_num(size2))
            assert(is_num(shift))
            ["trapezoid", point2d(size), size2, shift, over_f, cp, offset, anchors]
        ) : (
            let(
                size2 = default(size2, point2d(size)),
                shift = default(shift, [0,0])
            )
            assert(is_vector(size,3))
            assert(is_vector(size2,2))
            assert(is_vector(shift,2))
            ["prismoid", size, size2, shift, axis, over_f, cp, offset, anchors]
        )
    ) : !is_undef(vnf)? (
        assert(is_vnf(vnf))
        assert(two_d == false)
        extent? ["vnf_extent", vnf, over_f, cp, offset, anchors] 
              : ["vnf_isect", vnf, over_f, cp, offset, anchors]
    ) : !is_undef(region)? (
        assert(is_region(region),2)
        assert(is_undef(override), "\nThe override geometry parameter is not supported by region or extrusion geometry")
        let( l = default(l, h) )
        two_d==true
          ? assert(is_undef(l), "\nCannot give l/h with region anchor types (when two_d is set).")
            extent==true
              ? ["rgn_extent", region, cp, offset, anchors]
              : ["rgn_isect",  region, cp, offset, anchors]
          : assert(is_finite(l), "\nMust give l/h with extrusion anchor types (did you forget to set two_d?).")
            let(
                shift = default(shift, [0,0]),
                scale = is_num(scale)? [scale,scale] : default(scale, [1,1]),
                twist = default(twist, 0)
            )
            assert(is_vector(shift,2))
            assert(is_vector(scale,2))
            assert(is_num(twist))
            extent==true
              ? ["extrusion_extent", region, l, twist, scale, shift, cp, offset, anchors]
              : ["extrusion_isect",  region, l, twist, scale, shift, cp, offset, anchors]
    ) :
    let(
        r1 = get_radius(r1=r1,d1=d1,r=r,d=d,dflt=undef)
    )
    !is_undef(r1)? (
        let( l = default(l, h) )
        !is_undef(l)? (
            let(
                shift = default(shift, [0,0]),
                r2 = get_radius(r1=r2,d1=d2,r=r,d=d,dflt=undef)
            )
            assert(is_num(r1) || is_vector(r1,2))
            assert(is_num(r2) || is_vector(r2,2))
            assert(is_num(l))
            assert(is_vector(shift,2))
            ["conoid", r1, r2, l, shift, axis, over_f, cp, offset, anchors]
        ) : (
            two_d? (
                assert(is_num(r1) || is_vector(r1,2))
                ["ellipse", r1, over_f, cp, offset, anchors]
            ) : (
                assert(is_num(r1) || is_vector(r1,3))
                assert(is_undef(override), "\nThe override geometry parameter is not supported by spheroid geometry")
                ["spheroid", r1, cp, offset, anchors]
            )
        )
    ) :
    assert(is_undef(override), "\nThe override geometry parameter is not supported by point geometry")
    two_d?     ["point2d", cp, offset, anchors]
    : ["point", cp, offset, anchors];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Attachment internal functions


/// Internal Function: _attach_geom_2d()
/// Topics: Attachments
/// See Also: reorient(), attachable()
/// Usage:
///   bool = _attach_geom_2d(geom);
/// Description:
///   Returns true if the given attachment geometry description is for a 2D shape.
function _attach_geom_2d(geom) =
    let( type = geom[0] )
    type == "trapezoid" || type == "ellipse" ||
    type == "rgn_isect" || type == "rgn_extent" || type=="point2d";

/// Internal Function: _attach_geom_size()
/// Usage:
///   bounds = _attach_geom_size(geom);
/// Topics: Attachments
/// See Also: reorient(), attachable()
/// Description:
///   Returns the `[X,Y,Z]` bounding size for the given attachment geometry description.
function _attach_geom_size(geom) =
    let(type=geom[0])
    type=="point" ? [0,0,0] :
    type=="point2d" ? [0,0] :
    type=="prismoid" ? (
        let(
            size=[for(v=geom[1]) max(0,v)],
            size2=[for(v=geom[2]) max(0,v)],
            shift=geom[3],
            corners=[for(z=[-1,1], x=[-1,1], y=[-1,1])
                point3d(v_mul(z<0 ? point2d(size)/2 : size2/2,[x,y])
                        + (z<0 ? [0,0] : shift), z*size.z/2)],
            bounds=pointlist_bounds(rot(from=UP,to=geom[4],p=corners))
        ) bounds[1]-bounds[0]
    ) : type=="conoid" ? (
        let(
            r1=force_list(geom[1],2), r2=force_list(geom[2],2),
            m=rot(from=UP,to=geom[5]),
            bot=apply(m,[0,0,-geom[3]/2]),
            top=apply(m,point3d(geom[4],geom[3]/2))
        ) [for(i=[0:2]) let(
                b=norm([r1.x*m[i][0],r1.y*m[i][1]]),
                t=norm([r2.x*m[i][0],r2.y*m[i][1]])
            ) max(bot[i]+b,top[i]+t)-min(bot[i]-b,top[i]-t)]
    ) : type=="spheroid" ? 2*force_list(geom[1],3)
    : in_list(type,["vnf_extent","vnf_isect"]) ? (
        geom[1]==EMPTY_VNF ? [0,0,0] :
        let(bounds=pointlist_bounds(geom[1][0])) bounds[1]-bounds[0]
    ) : in_list(type,["extrusion_isect","extrusion_extent"]) ? (
        let(
            points=flatten(geom[1]),
            twist=geom[3], sc=geom[4], shift=geom[5]
        ) twist==0 ?
            let(bounds=pointlist_bounds(concat(points,[for(p=points) v_mul(sc,p)+shift])))
            [each bounds[1]-bounds[0], abs(geom[2])]
          : let(bounds=[for(p=points) [for(i=[0:1])
                    _attach_sweep_coord_bounds(p,i,sc[i]-1,shift[i],-twist)]])
            [for(i=[0:1]) max([for(b=bounds) b[i][1]])-min([for(b=bounds) b[i][0]]), abs(geom[2])]
    ) : type=="trapezoid" ? (
        let(size=geom[1], size2=geom[2], shift=geom[3])
        [max(size.x/2,shift+size2/2)-min(-size.x/2,shift-size2/2), abs(size.y)]
    ) : type=="ellipse" ? 2*force_list(geom[1],2)
    : in_list(type,["rgn_isect","rgn_extent"]) ? (
        let(bounds=pointlist_bounds(flatten(geom[1]))) bounds[1]-bounds[0]
    ) : assert(false, "\nUnknown attachment geometry type.");

/// Bound one coordinate of a vertex under simultaneous linear scale, twist, and shift.
/// Its second-derivative zeros divide the first derivative into monotonic intervals.
/// Consecutive second-derivative zeros are at least 120 degrees apart in sweep angle,
/// so 90-degree brackets isolate them, even when the scale changes sign.
function _attach_sweep_coord_bounds(p, i, k, shift, angle) =
    let(
        a=p[i], b=i==0 ? -p.y : p.x,
        w=angle*PI/180,
        q=function(u) a*cos(angle*u)+b*sin(angle*u),
        dq=function(u) w*(-a*sin(angle*u)+b*cos(angle*u)),
        f=function(u) (1+k*u)*q(u)+shift*u,
        df=function(u) k*q(u)+(1+k*u)*dq(u)+shift,
        ddf=function(u) 2*k*dq(u)-(1+k*u)*w*w*q(u),
        n=max(1,ceil(abs(angle)/90)),
        inflections=_attach_bracket_roots(ddf,[for(j=[0:n]) j/n]),
        stationary=_attach_bracket_roots(df,concat([0],inflections,[1])),
        values=[f(0),f(1),for(u=stationary) f(u)]
    ) [min(values),max(values)];

function _attach_bracket_roots(f, knots) = [
    for(i=[0:1:len(knots)-2]) let(
        a=knots[i], b=knots[i+1], fa=f(a), fb=f(b)
    ) if (a<b)
        if (fa==0) a
        else if (fa*fb<0) root_find(f,a,b),
    if (f(last(knots))==0) last(knots)
];

/// Internal Function: _attach_transform()
/// Usage: To Get a Transformation Matrix
///   mat = _attach_transform(anchor, spin, orient, geom);
/// Usage: To Transform Points, Paths, Patches, or VNFs
///   new_p = _attach_transform(anchor, spin, orient, geom, p);
/// Topics: Attachments
/// See Also: reorient(), attachable()
/// Description:
///   Returns the affine3d transformation matrix needed to `anchor`, `spin`, and `orient`
///   the given geometry `geom` shape into position.
/// Arguments:
///   anchor = Anchor point to translate to the origin `[0,0,0]`.  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
///   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
///   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
///   geom = The geometry description of the shape.
///   p = If given as a VNF, path, or point, applies the affine3d transformation matrix to it and returns the result.
function _attach_transform(anchor, spin, orient, geom, p) =
    assert(is_undef(anchor) || is_vector(anchor) || is_string(anchor), str("\nInvalid anchor: ",anchor))
    assert(is_undef(spin) || is_finite(spin), str("\nInvalid spin: ",spin))
    assert(is_undef(orient) || is_vector(orient,3), str("\nInvalid orient: ",orient))
    let(
        anchor=default(anchor,CENTER),
        spin=default(spin,0),
        orient=default(orient,UP),
        two_d = _attach_geom_2d(geom),
        m = is_def($attach_to) ?   // $attach_to is the attachment point on this object
              (                       // which will attach to the parent
                   let(
                        anch = _find_anchor($attach_to, geom),
                        // if $anchor_override is set it defines the object position anchor (but note not direction or spin).  
                        // Otherwise we use the provided anchor for the object.  
                        pos = is_undef($anchor_override) ? anch[1]
                            : _find_anchor(_make_anchor_legal($anchor_override,geom),geom)[1]
                   )
                   two_d?
                     affine3d_zrot(spin)  
                        * rot(to=FWD, from=point3d(anch[2])) 
                        * affine3d_translate(point3d(-pos))
                 :
                   affine3d_yrot(180)
                      * affine3d_zrot(-anch[3]-spin)
                      * rot(from=anch[2],to=UP)
                      * affine3d_translate(point3d(-pos))
              )
          :
            let(
                anchor = is_undef($attach_alignment) ? anchor
                       : two_d? _make_anchor_legal(zrot(-spin,$attach_alignment),geom)
                       : _make_anchor_legal(rot(spin, from=UP,to=orient,reverse=true,p=$attach_alignment),geom),
                pos = _find_anchor(anchor, geom)[1]
            )
            two_d? affine3d_zrot(spin) * affine3d_translate(point3d(-pos))
            :
                let(
                    axis = vector_axis(UP,orient),    // Returns BACK if orient is UP
                    ang = vector_angle(UP,orient)
                )
                affine3d_rot_by_axis(axis,ang) 
                    * affine3d_zrot(spin)  
                    * affine3d_translate(point3d(-pos))
    )
    is_undef(p)? m
  : is_vnf(p) && p==[[],[]] ? p 
  : apply(m, p);

function _get_cp(geom) =
    let(cp=select(geom,-3))
    is_vector(cp) ? cp
  : let(
        is_vnf = in_list(geom[0],["vnf_extent","vnf_isect"])
    )
    cp == "centroid" ? (
       assert(is_vnf || in_list(geom[0],["rgn_extent","rgn_isect","extrusion_extent","extrusion_isect"]),
              "\ncp=\"centroid\" is only allowed for VNF, region, and extruded-region attachment geometries.")
       is_vnf && len(geom[1][1])==0
          ? [0,0,0]
          : centroid(geom[1])
    )
  : let(points = is_vnf?geom[1][0]:flatten(force_region(geom[1])))
    cp=="mean" ? mean(points)
  : cp=="box" ? mean(pointlist_bounds(points))
  : assert(false,"\nInvalid cp specification.");

/// Internal Function: _find_anchor()
/// Usage:
///   anchorinfo = _find_anchor(anchor, geom);
/// Topics: Attachments
/// See Also: reorient(), attachable()
/// Description:
///   Calculates the anchor data for the given `anchor` vector or name, in the given attachment
///   geometry.  Returns `[ANCHOR, POS, VEC, ANG]` where `ANCHOR` is the requested anchorname
///   or vector, `POS` is the anchor position, `VEC` is the direction vector of the anchor, and
///   `ANG` is the angle to align with around the rotation axis of th anchor direction vector.
/// Arguments:
///   anchor = Vector or named anchor string.
///   geom = The geometry description of the shape.
function _three_edge_corner_dir(facevecs,edges) =
      let(
           v1 = vector_bisect(facevecs[0],facevecs[2]),
           v2 = vector_bisect(facevecs[1],facevecs[2]),
           p1 = plane_from_normal(rot(v=edges[0],a=90,p=v1)),
           p2 = plane_from_normal(rot(v=edges[1],a=-90,p=v2)),
           line = plane_intersection(p1,p2),
           v3 = unit(line[1]-line[0],UP)
       )
       unit(v3,UP);

function _find_anchor(anchor, geom)=
    is_string(anchor)? (
          anchor=="origin"? [anchor, CENTER, UP, 0]    // Ok that this returns 3d anchor in the 2d case?
        : let(
              anchors = last(geom),
              found = search([anchor], anchors, num_returns_per_match=1)[0]
          )
          assert(found!=[], str("\nUnknown anchor: ",anchor))
          anchors[found]
    ) :
    let(
        cp = _get_cp(geom),
        offset_raw = select(geom,-2),
        offset = [for (i=[0:2]) anchor[i]==0? 0 : offset_raw[i]],  // prevents bad centering.
        type = geom[0]
    )
    assert(is_vector(anchor),str("\nInvalid anchor: ",anchor))
    let(
        anchor = point3d(anchor),
        oang = (
            approx(point2d(anchor), [0,0])? 0 :
            atan2(anchor.y, anchor.x)+90
        )
    )
    type == "prismoid"? ( //size, size2, shift, axis
        let(all_comps_good = [for (c=anchor) if (c!=sign(c)) 1]==[])
        assert(all_comps_good, "\nAll components of an anchor for a cuboid/prismoid must be -1, 0, or 1.")
        let(
            size=geom[1],
            size2=geom[2],
            shift=point2d(geom[3]),
            axis=point3d(geom[4]),
            override = geom[5](anchor)
        )
        let(
            size = [for (c = size) max(0,c)],
            size2 = [for (c = size2) max(0,c)],
            anch = rot(from=axis, to=UP, p=anchor),
            offset = rot(from=axis, to=UP, p=offset),
            h = size.z,
            u = (anch.z + 1) / 2,  // u is one of 0, 0.5, or 1
            axy = point2d(anch),
            bot = point3d(v_mul(point2d(size )/2, axy), -h/2),
            top = point3d(v_mul(point2d(size2)/2, axy) + shift, h/2),
            degenerate = sum(v_abs(point2d(anch)))==1 && (point2d(bot)==[0,0] || v_mul(point2d(size2)/2, axy)==[0,0]),
            edge = top-bot,
            other_edge = degenerate ? move(shift,mirror(axy, move(-shift,top))) - mirror(point3d(point2d(anch)), p=bot):CTR,
            pos = point3d(cp) + lerp(bot,top,u) + offset,
               // Find vectors of the faces involved in the anchor
            facevecs =
                [
                    if (anch.x!=0) unit(rot(from=UP, to=[edge.x,0,max(0.01,h)], p=[axy.x,0,0]), UP),
                    if (anch.y!=0) unit(rot(from=UP, to=[0,edge.y,max(0.01,h)], p=[0,axy.y,0]), UP),
                    if (anch.z!=0 && !degenerate) unit([0,0,anch.z],UP),
                    if (anch.z!=0 && degenerate && anch.y!=0)
                       unit(rot(from=UP, to=[0,other_edge.y,max(0.01,h)], p=[0,-axy.y,0]), UP),
                    if (anch.z!=0 && degenerate && anch.x!=0)
                       unit(rot(from=UP, to=[other_edge.x,0,max(0.01,h)], p=[-axy.x,0,0]), UP),
                ],
            dir = anch==CENTER? UP
                : len(facevecs)==1? unit(facevecs[0],UP)
                : len(facevecs)==2? vector_bisect(facevecs[0],facevecs[1])
                : _three_edge_corner_dir(facevecs,[FWD,LEFT])*anch.z,            
            edgedir = len(facevecs)!=2 ? undef
                    : rot(from=UP,to=axis,p=unit(cross(facevecs[0], facevecs[1]))), 
            edgeang = len(facevecs)==2 ? 180-vector_angle(facevecs[0], facevecs[1]) : undef,
            edgelen = anch.z==0 ? norm(edge)
                    : anch.z>0 ? abs([size2.y,size2.x]*axy)
                    : abs([size.y,size.x]*axy),
            endvecs = len(facevecs)!=2 ? undef
                    : anch.z==0 ? [DOWN, UP]
                    : let(
                          raxy = zrot(-90,axy),
                          bot1 = point3d(v_mul(point2d(size )/2, raxy), -h/2),
                          top1 = point3d(v_mul(point2d(size2)/2, raxy) + shift, h/2),
                          edge1 = top1-bot1,
                          vec1 = (raxy.x!=0) ? unit(rot(from=UP, to=[edge1.x,0,max(0.01,h)], p=[raxy.x,0,0]), UP)
                               :               unit(rot(from=UP, to=[0,edge1.y,max(0.01,h)], p=[0,raxy.y,0]), UP),
                          raxy2 = zrot(90,axy),
                          bot2 = point3d(v_mul(point2d(size )/2, raxy2), -h/2),
                          top2 = point3d(v_mul(point2d(size2)/2, raxy2) + shift, h/2),
                          edge2 = top2-bot2,
                          vec2 = (raxy2.y!=0) ? unit(rot(from=UP, to=[edge.x,0,max(0.01,h)], p=[raxy2.x,0,0]), UP)
                               :               unit(rot(from=UP, to=[0,edge.y,max(0.01,h)], p=[0,raxy2.y,0]), UP)
                      )
                      [vec1,vec2],
            final_dir = default(override[1],anch==CENTER?UP:rot(from=UP, to=axis, p=dir)),
            final_pos = default(override[0],rot(from=UP, to=axis, p=pos)),

            // If the anchor is an edge anchor and not horizontal we point spin UP
            // If the anchor is horizontal edge we point spin clockwise:
            //     cross product of UP with the edge direction will point OUT if we are on top and edge direction
            //     is correct.  We check if it points out by comparing to the final_dir which points out at that edge,
            //     with a correction for top/bottom (anchor.z).  
            // Otherwise use the standard BACK/UP definition
            // The precomputed oang value seems to be wrong, at least when axis!=UP
            spin = is_def(edgedir) && degenerate ? _compute_spin(final_dir, unit(((BACK+RIGHT)*edgedir)*edgedir))
                 : is_def(edgedir) && !approx(edgedir.z,0) ? _compute_spin(final_dir, edgedir * (edgedir*UP>0?1:-1))
                 : is_def(edgedir) ? _compute_spin(final_dir,
                                                   edgedir * (approx(unit(cross(UP,edgedir)),unit([final_dir.x,final_dir.y,0])*anchor.z) ? 1 : -1))
                 : _compute_spin(final_dir, final_dir==DOWN || final_dir==UP ? BACK : UP)
        ) [anchor, final_pos, final_dir, default(override[2],spin),
           if (is_def(edgeang)) [["edge_angle",edgeang],["edge_length",edgelen], ["vec", endvecs]]]
    ) : type == "conoid"? ( //r1, r2, l, shift, axis
        let(
            rr1=geom[1],
            rr2=geom[2],
            length=geom[3],
            shift=point2d(geom[4]),
            axis=point3d(geom[5]),
            override = geom[6](anchor),
            r1 = is_num(rr1)? [rr1,rr1] : point2d(rr1),
            r2 = is_num(rr2)? [rr2,rr2] : point2d(rr2),
            anch = rot(from=axis, to=UP, p=anchor),
            axisname = axis==UP ? "Z"
                     : axis==RIGHT ? "X"
                     : axis==BACK ? "Y"
                     : "",
            dummy = assert(anch.z == sign(anch.z), str("\nThe ",axisname," component of an anchor for the cylinder/cone must be -1, 0, or 1.")),
            offset = rot(from=axis, to=UP, p=offset),
            u = (anch.z+1)/2,
            /// Return the point and its clockwise derivative with respect to ray angle.
            /// Retain tangent magnitudes so interpolation also works with unequal end ellipses.
            solve_ellipse = function (r,dir)
                approx(dir,[0,0]) || r==[0,0] ? [[0,0],[0,0]]
              : let(
                    d = unit(dir),
                    den = d.x*d.x*r.y*r.y + d.y*d.y*r.x*r.x,
                    pt = r.x==0 ? [0, approx(d.x,0) ? sign(d.y)*r.y : 0]
                       : r.y==0 ? [approx(d.y,0) ? sign(d.x)*r.x : 0, 0]
                       : r.x*r.y/sqrt(den)*d,
                    tangent = den==0 ? [0,0] : [pt.y*r.x*r.x, -pt.x*r.y*r.y]/den
                ) [pt,tangent],
            on_center = approx(point2d(anch), [0,0]),
            botdata = solve_ellipse(r1,point2d(anch)),
            topdata = solve_ellipse(r2,point2d(anch)),
            bot = point3d(botdata[0], -length/2),
            top = move(shift,point3d(topdata[0], length/2)),
            tangent = lerp(botdata[1],topdata[1],u), 
            normal = [-tangent.y,tangent.x],
            axy = unit(point2d(anch),[0,0]),
            obot = point3d(v_mul(r1,axy), -length/2),
            otop = point3d(v_mul(r2,axy)+shift, length/2),
            pos = point3d(cp) + lerp(bot,top,u) + offset,
            sidevec = unit(cross(top-bot,point3d(tangent)), point3d(axy)),
            vvec = anch==CENTER? UP : unit([0,0,anch.z],UP),
            apex = (anch.z==-1 && r1==[0,0]) || (anch.z==1 && r2==[0,0]),
            vec = on_center || apex ? unit([0,0,anch.z],UP)
                : approx(anch.z,0)? sidevec
                : unit(sidevec+vvec,UP),
            pos2 = rot(from=UP, to=axis, p=pos),
            vec2 = anch==CENTER? UP : rot(from=UP, to=axis, p=vec),
               // Set spin for top/bottom to be clockwise
            spin = apex ? _compute_spin(vec2, v_abs(vec2)==UP ? BACK : UP)
                 : anch.z!=0 && (!approx(anch.x,0) || !approx(anch.y,0)) ? _compute_spin(vec2,rot(from=UP,to=axis,p=point3d(tangent)*anch.z))
                 : anch.z==0 && norm(anch)>_EPSILON ? _compute_spin(vec2, (approx(vec2,DOWN) || approx(vec2,UP))?BACK:UP)
                 : oang
        ) [anchor, default(override[0],pos2), default(override[1],vec2),default(override[2], spin)]
    ) : type == "point"? (
        let(
            anchor = unit(point3d(anchor),CENTER),
            pos = point3d(cp) + point3d(offset),
            vec = unit(anchor,UP)
        ) [anchor, pos, vec, oang]
    ) : type == "point2d"? (
        let(
            anchor = unit(_force_anchor_2d(anchor), [0,0]),
            pos = point2d(cp) + point2d(offset),
            vec = unit(anchor,BACK)
        ) [anchor, pos, vec, oang]
    ) : type == "spheroid"? ( //r
        let(
            rr = geom[1],
            r = is_num(rr)? [rr,rr,rr] : point3d(rr),
            anchor = unit(point3d(anchor),CENTER),
            /// Intersect the ray with the ellipsoid before applying anchor offsets.
            outside = [for(i=[0:2]) if (r[i]==0 && anchor[i]!=0) i]!=[],
            denom = norm([for(i=[0:2]) r[i]==0 ? 0 : anchor[i]/r[i]]),
            surface = outside || denom==0 ? CENTER : anchor/denom,
            pos = point3d(cp) + surface + point3d(offset),
            vec = unit([for(i=[0:2]) r[i]==0 ? 0 : surface[i]/(r[i]*r[i])], unit(anchor,UP)),
            spin = approx(point2d(vec),[0,0]) ? 0 : atan2(vec.y,vec.x)+90
        ) [anchor, pos, vec, spin]
    ) : type == "vnf_isect"? ( //vnf
        let(
            vnf=geom[1],
            override = geom[2](anchor)
        )                                                   // CENTER anchors anchor on cp, "origin" anchors on [0,0]
        approx(anchor,CTR)? [anchor, default(override[0],cp),default(override[1],UP),default(override[2], 0)] :     
        vnf==EMPTY_VNF? [anchor, [0,0,0], unit(anchor), 0] :
        let(
            eps = 1/2048,
            points = vnf[0],
            faces = vnf[1],
            rpts = apply(rot(from=anchor, to=RIGHT) * move(-cp), points),
            hits = [
                for (face = faces)
                    let(
                        verts = select(rpts, face),
                        ys = column(verts,1),
                        zs = column(verts,2)
                    )
                    if (max(ys) >= -eps && max(zs) >= -eps &&
                        min(ys) <=  eps &&  min(zs) <=  eps)
                        let(
                            poly = select(points, face),
                            isect = polygon_line_intersection(poly, [cp,cp+anchor], eps=eps),
                            ptlist = is_undef(isect) ? [] :
                                     is_vector(isect) ? [isect]
                                                      : flatten(isect),   // parallel to a face
                            n = len(ptlist)>0 ? polygon_normal(poly) : undef
                        )
                        for(pt=ptlist) [anchor * (pt-cp), n, pt]
            ]
        )
        assert(len(hits)>0, "\nAnchor vector does not intersect with the shape. Attachment failed.")
        let(
            furthest = max_index(column(hits,0)),
            dist = hits[furthest][0],
            pos = hits[furthest][2],
            hitnorms = [for (hit = hits) if (approx(hit[0],dist,eps=eps)) hit[1]],
            unorms = [
                      for (i = idx(hitnorms))
                          let(
                              thisnorm = hitnorms[i],
                              isdup = [
                                       for (j = [i+1:1:len(hitnorms)-1])
                                           if (approx(thisnorm, hitnorms[j])) 1
                                      ] != []
                          )
                          if (!isdup) thisnorm
                     ],
            n = unit(sum(unorms)),
            oang = approx(point2d(n), [0,0])? 0 : atan2(n.y, n.x) + 90
        )
        [anchor, default(override[0],pos),default(override[1], n),default(override[2], oang)]
    ) : type == "vnf_extent"? ( //vnf
        let(
            vnf=geom[1],
            override = geom[2](anchor)
        ) // CENTER anchors anchor on cp, "origin" anchors on [0,0]
        approx(anchor,CTR)? [anchor, default(override[0],cp),default(override[1],UP),default(override[2], 0)] :     
        vnf==EMPTY_VNF? [anchor, [0,0,0], unit(anchor,UP), 0] :
        let(
            rpts = apply(rot(from=anchor, to=RIGHT) * move(point3d(-cp)), vnf[0]),
            maxx = max(column(rpts,0)),

            idxmax = [for (i = idx(rpts)) approx(rpts[i].x, maxx)],
            idxs = [for (i = idx(rpts)) if(approx(rpts[i].x, maxx)) i],
            veflist=[
                     for(face=vnf[1])
                       let(
                           facemax = [for(vertind=face) if (idxmax[vertind]) vertind],
                           flip = facemax[0]==face[0] && facemax[1]==last(face)
                       )
                       [
                         if (len(facemax)==1) facemax else [],
                         if (len(facemax)==2) (flip ? reverse(facemax):facemax) else [],
                         if (len(facemax)>2) facemax else []
                       ]],
            vlist = [for(i=idx(veflist)) if (veflist[i][0]!=[]) veflist[i][0]],
            elist = [for(i=idx(veflist)) if (veflist[i][1]!=[] && !approx(rpts[veflist[i][1][0]],rpts[veflist[i][1][1]])) veflist[i][1]],
            flist = [for(i=idx(veflist)) if (veflist[i][2]!=[])  veflist[i][2]],
            faceinfo = [for(face=flist) let(poly=select(vnf[0],face)) [polygon_area(poly), centroid(poly)]],  //[ area, centroid]
            facearea = len(faceinfo)==0 ? 0 : sum(column(faceinfo,0)),
            basic_spin = _compute_spin(anchor, v_abs(anchor)==UP ? BACK: UP),
            res = len(flist)>0 && !approx(facearea,0) ?
                      let(
                          center = column(faceinfo,0)*column(faceinfo,1)/facearea
                      )
                      [center,anchor,basic_spin]
                : len(elist)==2 ?  // One edge (which appears twice, once in each direction)
                      let(
                          edge = select(vnf[0],elist[0]),
                          center = mean(edge),
                          edgefaces = _vnf_find_edge_faces(vnf,elist), //unique([for(e=elist) each _vnf_find_edge_faces(vnf,e)]),
                          facenormals = [for(face=edgefaces) polygon_normal(select(vnf[0],vnf[1][face]))],
                          direction = unit(mean(facenormals)),
                          projnormals = project_plane(point4d(cross(facenormals[0],facenormals[1])), facenormals),
                          ang = 180- posmod(v_theta(projnormals[1])-v_theta(projnormals[0]),360),
                          horiz_face = [for(i=[0:1]) if (approx(v_abs(facenormals[i]),UP)) i],  // index of horizontal face, at most one exists
                          spin = horiz_face==[] ?
                                     let(
                                         edgedir = edge[1]-edge[0],
                                         nz = [for(i=[0:2]) if (!approx(edgedir[i],0)) i],
                                         flip = edgedir[last(nz)] < 0 ? -1 : 1
                                     )
                                     _compute_spin(direction, flip*edgedir)
                                  :
                                     let(  // Determine whether the edge is the right or wrong direction compared to the horizongal face
                                           // which will determine what clockwise means so we can assign spin
                                         face = select(vnf[1],edgefaces[horiz_face[0]]),
                                         endptidx=search(column(elist,0),face),
                                         hedge = elist[endptidx[0]!=[] ? 0:1],
                                         edgedir = deltas(select(vnf[0],hedge))[0],
                                         flip = select(face,flatten(endptidx)[0]+1)== hedge[1] ? 1 : -1
                                     )
                                     _compute_spin(direction, flip*edgedir)
                      )
                      [center,direction,spin,[["edge_angle",ang],["edge_length",norm(edge[1]-edge[0])]]]
                : len(elist)>2 ?   // multiple edges, which must be coplanar, use average of edge endpoints
                      let(
                           plist = select(vnf[0],flatten(elist)),
                           center = mean(plist)
                      )
                      [center,anchor,basic_spin]
                : len(vlist)==0 ? assert(false,"\nCannot find anchor on the VNF.")
                : let(
                      vlist = flatten(vlist),
                      uind = unique_approx_indexed(select(vnf[0],vlist)),
                      ulist = select(vlist,uind)
                  )
                  len(ulist)>1 ?   // Multiple vertices: return average
                      let(
                           center = mean(select(vnf[0],ulist))
                      )
                      [center, anchor, basic_spin]
                : let(    // one vertex case
                      vuniq = unique(vlist),
                      vertices = vnf[0],
                      faces = vnf[1],
                      cornerfaces = _vnf_find_corner_faces(vnf,vuniq),    // faces = [3,9,12] indicating which faces
                      normals = [for(faceind=cornerfaces) polygon_normal(select(vertices, faces[faceind]))],
                      angles = [for(faceind=cornerfaces)
                                  let(
                                       thisface = faces[faceind],
                                       vind = flatten(search(vuniq,thisface))[0]
                                  )
                                  vector_angle(select(vertices, select(thisface,vind-1,vind+1)))
                               ],
                             direc = unit(angles*normals)
                   )
                   [vnf[0][ulist[0]], direc, atan2(direc.y,direc.x)+90]
        ) [anchor,
           default(override[0],res[0]),
           default(override[1],res[1]),
           default(override[2],res[2]),
           if (len(res)==4) res[3]
          ]        
    ) : type == "trapezoid"? ( //size, size2, shift, override
        let(all_comps_good = [for (c=anchor) if (c!=sign(c)) 1]==[])
        assert(all_comps_good, "\nAll components of an anchor for a rectangle/trapezoid must be -1, 0, or 1.")
        let(
            anchor=_force_anchor_2d(anchor),
            size=geom[1], size2=geom[2], shift=geom[3],
            u = (anchor.y+1)/2,  // 0<=u<=1
            frpt = [size.x/2*anchor.x, -size.y/2],
            bkpt = [size2/2*anchor.x+shift, size.y/2],
            override = geom[4](anchor),
            pos = override[0] != undef? override[0] :
                point2d(cp) + lerp(frpt, bkpt, u) + point2d(offset),
            svec = approx(bkpt,frpt)? [anchor.x,0,0] :
                point3d(line_normal(bkpt,frpt)*anchor.x),
            vec = is_def(override[1]) ? override[1]
                : anchor.y == 0? ( anchor.x == 0? BACK : svec )
                : anchor.x == 0? [0,anchor.y,0]
                : unit((svec + [0,anchor.y,0]) / 2, [0,anchor.y,0])
        ) [anchor, pos, vec, 0]
    ) : type == "ellipse"? ( //r
        let(
            anchor = unit(_force_anchor_2d(anchor),[0,0]),
            r = force_list(geom[1],2),
            override = geom[2](anchor), 
            pos = approx(anchor.x,0)
                ? [0,sign(anchor.y)*r.y]
                : let(
                       m = anchor.y/anchor.x,
                       px = approx(min(r),0)? 0 :
                           sign(anchor.x) * sqrt(1/(1/sqr(r.x) + m*m/sqr(r.y)))
                  )
                  [px,m*px],
            vec = approx(min(r),0)? (approx(norm(anchor),0)? BACK : anchor) :
                unit([r.y/r.x*pos.x, r.x/r.y*pos.y],BACK)
        ) [anchor, default(override[0],point2d(cp+offset)+pos),default(override[1], vec),default(override[2], 0)]
    ) : type == "rgn_isect"? ( //region
        let(
            anchor = _force_anchor_2d(anchor),
            rgn = force_region(move(-point2d(cp), p=geom[1]))
        )
        approx(anchor,[0,0])? [anchor, cp, BACK, 0] :     // CENTER anchors anchor on cp, "origin" anchors on [0,0]
        let(
            isects = [
                for (path=rgn, t=triplet(path,true)) let(
                    seg1 = [t[0],t[1]],
                    seg2 = [t[1],t[2]],
                    isect = line_intersection([[0,0],anchor], seg1, RAY, SEGMENT),
                    n = is_undef(isect)? [0,1] :
                        !approx(isect, t[1])? line_normal(seg1) :
                        unit((line_normal(seg1)+line_normal(seg2))/2,[0,1]),
                    n2 = vector_angle(anchor,n)>90? -n : n
                )
                if(!is_undef(isect) && !approx(isect,t[0])) [norm(isect), isect, n2]
            ]
        )
        assert(len(isects)>0, "\nAnchor vector does not intersect with the shape. Attachment failed.")
        let(
            maxidx = max_index(column(isects,0)),
            isect = isects[maxidx],
            pos = point2d(cp) + isect[1],
            vec = unit(isect[2],[0,1])
        ) [anchor, pos, vec, 0]
    ) : type == "rgn_extent"? ( //region
        let( anchor = _force_anchor_2d(anchor) )
        approx(anchor,[0,0])? [anchor, cp, BACK, 0] :   // CENTER anchors anchor on cp, "origin" anchors on [0,0]
        let(
            rgn = force_region(geom[1]),
            indexed_pts = [for(i=idx(rgn), j=idx(rgn[i])) [i,j,rgn[i][j]]],
            rpts = rot(from=anchor, to=RIGHT, p=column(indexed_pts,2)), 
            maxx = max(column(rpts,0)),
            index = [for (i=idx(rpts)) if (approx(rpts[i].x, maxx)) i],
            ys = [for (i=index) rpts[i].y],
            midy = (min(ys)+max(ys))/2,
            pos = rot(from=RIGHT, to=anchor, p=[maxx,midy]),
            dir = len(ys) > 1 ? [unit(anchor)]
                : let(
                       path = rgn[indexed_pts[index[0]][0]],
                       ctr = indexed_pts[index[0]][1],
                       corner = select(path, [ctr-1,ctr,ctr+1]),
                       normal = unit(line_normal(select(corner,0,1))+line_normal(select(corner,1,2)))
                  )
                  [is_polygon_clockwise(path) ? normal : -normal, vector_angle(corner)]
        ) [anchor, pos, dir[0], 0, if(len(dir)>1) [["corner_angle",dir[1]]]]
    ) : type=="extrusion_extent" || type=="extrusion_isect" ? (  // extruded region
        assert(in_list(anchor.z,[-1,0,1]), "\nThe Z component of an anchor for an extruded 2D shape must be -1, 0, or 1.")
        let(
            anchor_xy = point2d(anchor),
            rgn = geom[1],
            L = geom[2],
            twist = geom[3],
            scale = geom[4],
            shift = geom[5],
            u = (anchor.z + 1) / 2,
            shmat = move(lerp([0,0], shift, u)),
            scmat = scale(lerp([1,1], scale, u)),
            twmat = zrot(lerp(0, -twist, u)),
            mat = shmat * scmat * twmat,
            cp=point2d(cp)
        )
        approx(anchor_xy,[0,0]) ? [anchor, apply(mat, point3d(cp,anchor.z*L/2)), unit(anchor, UP), oang] :
        lerp([1,1],scale,u)==[0,0] ? [anchor, point3d(u*shift,anchor.z*L/2), unit([0,0,anchor.z],UP), 0] :
        let(
            newrgn = apply(mat, rgn),
            newgeom = attach_geom(two_d=true, region=newrgn, extent=type=="extrusion_extent", cp=cp),
            result2d = _find_anchor(anchor_xy, newgeom),
            pos = point3d(result2d[1], anchor.z*L/2),
            sc = lerp([1,1],scale,u),
            rp = [for(i=[0:1]) sc[i]==0 ? 0 : (result2d[1][i]-u*shift[i])/sc[i]],
            /// Differentiate shift + scale * rotation with respect to sweep fraction.
            velocity = shift + v_mul(scale-[1,1],rp)
                     - twist*PI/180*v_mul(sc,[-rp.y,rp.x]),

            normal = point2d(result2d[2]),
            tangent = [normal.y, -normal.x],   // 90° cw rotation of the outward normal:
                                               // the boundary's own tangent direction
            sidevec = unit([L*normal.x, L*normal.y, -normal*velocity], point3d(normal)),
            vec = anchor.z==0 ? sidevec : unit(sidevec+[0,0,anchor.z],UP),
            oang = anchor.z==0 ? _compute_spin(vec, UP)
                               : _compute_spin(vec, point3d(tangent), UP)
        ) [anchor, pos, vec, oang]

      ) :
    assert(false, "\nUnknown attachment geometry type.");

/// Internal Function: _is_shown()
/// Usage:
///   bool = _is_shown();
/// Topics: Attachments
/// See Also: reorient(), attachable()
/// Description:
///   Returns true if objects should currently be shown based on the tag settings.
function _is_shown() =
    assert(is_list($tags_shown) || $tags_shown=="ALL")
    assert(is_list($tags_hidden))
    let(
        dummy=is_undef($tags) ? 0 : echo("Use tag() instead of $tags for specifying an object's tag."),
        $tag = default($tag,$tags)
    )
    assert(is_string($tag), str("\nTag value (",$tag,") is not a string"))
    assert(undef==str_find($tag," "),str("\nTag string \"",$tag,"\" contains a space, which is not allowed."))
    let(
        shown  = $tags_shown=="ALL" || in_list($tag,$tags_shown),
        hidden = in_list($tag, $tags_hidden)
    )
    shown && !hidden;

/// Internal Constant: EDGES_NONE
/// Topics: Edges
/// See Also: EDGES_ALL, edges()
/// Description:
///   The set of no edges.
/// Figure(3D):
///   _show_edges(edges="NONE");
EDGES_NONE = [[0,0,0,0], [0,0,0,0], [0,0,0,0]];

/// Internal Constant: EDGES_ALL
/// Topics: Edges
/// See Also: EDGES_NONE, edges()
/// Description:
///   The set of all edges.
/// Figure(3D):
///   _show_edges(edges="ALL");
EDGES_ALL = [[1,1,1,1], [1,1,1,1], [1,1,1,1]];

/// Internal Constant: EDGES_OFFSETS
/// Topics: Edges
/// See Also: EDGES_NONE, EDGES_ALL, edges()
/// Description:
///   The vectors pointing to the center of each edge of a unit sized cube.
///   Each item in an edge array will have a corresponding vector in this array.
EDGE_OFFSETS = [
    [
        [ 0,-1,-1],
        [ 0, 1,-1],
        [ 0,-1, 1],
        [ 0, 1, 1]
    ], [
        [-1, 0,-1],
        [ 1, 0,-1],
        [-1, 0, 1],
        [ 1, 0, 1]
    ], [
        [-1,-1, 0],
        [ 1,-1, 0],
        [-1, 1, 0],
        [ 1, 1, 0]
    ]
];

/// Internal Function: _is_edge_array()
/// Topics: Edges, Type Checking
/// Usage:
///   bool = _is_edge_array(x);
/// Description:
///   Returns true if the given value has the form of an edge array.
/// Arguments:
///   x = The item to check the type of.
/// See Also: edges(), EDGES_NONE, EDGES_ALL
function _is_edge_array(x) = is_list(x) && is_vector(x[0]) && len(x)==3 && len(x[0])==4;

function _edge_set(v,name) =
    _is_edge_array(v)? v : [
    for (ax=[0:2]) [
        for (b=[-1,1], a=[-1,1]) let(
            v2=[[0,a,b],[a,0,b],[a,b,0]][ax]
        ) (
            is_string(v)? (
                v=="X"? (ax==0) :   // Return all X axis aligned edges.
                v=="Y"? (ax==1) :   // Return all Y axis aligned edges.
                v=="Z"? (ax==2) :   // Return all Z axis aligned edges.
                v=="ALL"? true :    // Return all edges.
                v=="NONE"? false :  // Return no edges.
                let(valid_values = ["X", "Y", "Z", "ALL", "NONE"])
                assert(false, str("\nEdge selector in \"",name,"\" parameter is invalid string \"",v,"\". Valid strings are ", valid_values, "."))
            ) :
            assert(is_vector(v,3), str("\nEdge selector in \"",name,"\" parameter is ",v,". Edge selectors must be 3-vectors."))
            assert([for (x=v) x==-1 || x==0 || x==1]==[true,true,true],
                   str("\nEdge selector ",v," in \"",name,"\" parameter has invalid component.  Components must be -1, 0, or 1."))
            let(nonz = sum(v_abs(v)))
            assert(nonz>0,str("\nInvalid edge selector [0,0,0] in \"",name,"\" parameter. \nDid you add two edge selectors instead of passing them as a list?"))
            nonz==2? (v==v2) :  // Edge: return matching edge.
            let(
                matches = num_true([
                    for (i=[0:2]) v[i] && (v[i]==v2[i])
                ])
            )
            nonz==1? (matches==1) :  // Face: return surrounding edges.
            (matches==2)             // Corner: return touching edges.
        )? 1 : 0
    ]
];

/// Internal Function: _normalize_edges()
/// Topics: Edges
/// Usage:
///   edges = _normalize_edges(v);
/// Description:
///   Normalizes all values in an edge array to be `1`, if it was originally greater than `0`,
///   or `0`, if it was originally less than or equal to `0`.
/// See Also:  edges(), EDGES_NONE, EDGES_ALL
function _normalize_edges(v) = [for (ax=v) [for (edge=ax) edge>0? 1 : 0]];

/// Internal Function: _edges()
/// Topics: Edges
/// Usage:
///   edgs = _edges(v);
///   edgs = _edges(v, except);
///
/// Description:
///   Takes a list of edge set descriptors, and returns a normalized edges array
///   that represents all those given edges.
/// Arguments:
///   v = The edge set to include.
///   except = The edge set to specifically exclude, even if they are in `v`.
///
/// See Also:  EDGES_NONE, EDGES_ALL
///
function _edges(v, except=[]) =
    v==[] ? EDGES_NONE
  : is_string(v) || is_vector(v) || _is_edge_array(v) ? _edges([v], except=except)
  : is_string(except) || is_vector(except) || _is_edge_array(except)? _edges(v, except=[except])
  : except==[]? _normalize_edges(sum([for (x=v) _edge_set(x,"edges")]))
  : _normalize_edges( _normalize_edges(sum([for (x=v) _edge_set(x,"edges")])) - sum([for (x=except) _edge_set(x,"except")])
    );

/// Internal Function: _corner_edges()
/// Topics: Corners
/// Description:
///   Returns [XCOUNT,YCOUNT,ZCOUNT] where each is the count of edges aligned with that
///   axis that are in the edge set and touch the given corner.
/// Arguments:
///   edges = Standard edges array.
///   v = Vector pointing to the corner to count edge intersections at.
/// See Also: CORNERS_NONE, CORNERS_ALL, _corners()
function _corner_edges(edges, v) =
    let(u = (v+[1,1,1])/2) [edges[0][u.y+u.z*2], edges[1][u.x+u.z*2], edges[2][u.x+u.y*2]];

/// Internal utility function
function _force_rot(T) =
   [for(i=[0:3])
       [for(j=[0:3]) j<3 ? T[i][j] :
                     i==3 ? 1
                       : 0]];

function _local_struct_val(struct, key)=
    assert(is_def(key),"\nkey is missing.")
    let(ind = search([key],struct)[0])
    ind == [] ? undef : struct[ind][1];

function _force_anchor_2d(anchor) =
  is_undef(anchor) || len(anchor)==2 || is_string(anchor) ? anchor :
  assert(anchor.y==0 || anchor.z==0, "\nAnchor for a 2D shape cannot be fully 3D.  It must have either Y or Z component equal to zero.")
  anchor.y==0 ? [anchor.x,anchor.z] : point2d(anchor);

// Compute spin angle based on a anchor direction and desired spin direction
// anchor_dir assumed to be a unit vector; no assumption on spin_dir
// Takes the component of the spin direction perpendicular to the anchor
// direction and gives the spin angle that achieves it.
// backup_dir will be used instead of spin_dir if anchor_dir is parallel to spin_dir
function _compute_spin(anchor_dir, spin_dir, backup_dir) =
   let(
        native_dir = rot(from=UP, to=anchor_dir, p=BACK),
        spin_dir1 = spin_dir - (spin_dir*anchor_dir)*anchor_dir,     // component of spin_dir perpendicular to anchor_dir
        spin_dir = !approx(spin_dir1,[0,0,0]) || is_undef(backup_dir) ? spin_dir1
                 : backup_dir - (backup_dir*anchor_dir)*anchor_dir,  // component of backup_dir perpendicular to anchor_dir
        dummy = assert(!approx(spin_dir,[0,0,0]),"\nSpin direction is parallel to anchor."),
        angle = vector_angle(native_dir,spin_dir),
        sign = cross(native_dir,spin_dir)*anchor_dir<0 ? -1 : 1
   )
   sign*angle;

// onescad: BOSL2/beziers.scad
//////////////////////////////////////////////////////////////////////
// LibFile: beziers.scad
//   Bezier curves and surfaces are ways to represent smooth curves and smoothly curving
//   surfaces with a set of control points.  The curve or surface is defined by
//   the control points, but usually passes through only the first and last control point (the endpoints).
//   This file provides some
//   aids to constructing the control points, and highly optimized functions for
//   computing the Bezier curves and surfaces given by the control points, 
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Advanced Modeling
// FileSummary: Bezier curves and surfaces.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Terminology:
//   Path = A series of points joined by straight line segements.
//   Bezier Curve = A polynomial curve defined by a list of control points.  The curve starts at the first control point and ends at the last one.  The other control points define the shape of the curve and they are often *NOT* on the curve
//   Control Point = A point that influences the shape of the Bezier curve.
//   Degree = The degree of the polynomial used to make the bezier curve.  A bezier curve of degree N has N+1 control points.  Most beziers are cubic (degree 3).  The higher the degree, the more the curve can wiggle.  
//   Bezier Parameter = A parameter, usually `u` below, that ranges from 0 to 1 to trace out the bezier curve.  When `u=0` you get the first control point and when `u=1` you get the last control point. Intermediate points are traced out *non-uniformly*.  
//   Bezier Path = A list of bezier control points corresponding to a series of Bezier curves that connect together, end to end.  Because they connect, the endpoints are shared between control points and are not repeated, so a degree 3 bezier path representing two bezier curves has seven entries to represent two sets of four control points.    **NOTE:** A "bezier path" is *NOT* a standard path
//   Bezier Patch = A two-dimensional arrangement of Bezier control points that generate a bounded curved Bezier surface.  A Bezier patch is a (N+1) by (M+1) grid of control points, which defines surface with four edges (in the non-degenerate case). 
//   Bezier Surface = A surface defined by a list of one or more bezier patches.
//   Spline Steps = The number of straight-line segments used to approximate a Bezier curve.  The more spline steps, the better the approximation to the curve, but the slower it generates.  This plays a role analogous to `$fn` for circles.  Usually defaults to 16.


// Section: Bezier Curves

// Function: bezier_points()
// Synopsis: Computes one or more specified points along a bezier curve.
// SynTags: Path
// Topics: Bezier Curves
// See Also: bezier_curve(), bezier_curvature(), bezier_tangent(), bezier_derivative(), bezier_points()
// Usage:
//   pt = bezier_points(bezier, u);
//   ptlist = bezier_points(bezier, RANGE);
//   ptlist = bezier_points(bezier, LIST);
// Description:
//   Computes points on a bezier curve with control points specified by `bezier` at parameter values
//   specified by `u`, which can be a scalar or a list.  The value `u=0` gives the first endpoint; `u=1` gives the final endpoint,
//   and intermediate values of `u` fill in the curve in a non-uniform fashion.  This function uses an optimized method that
//   works best when `u` is a long list and the bezier degree is 10 or less.  The degree of the bezier
//   curve is `len(bezier)-1`.
//   .
//   Note that if you have a bezier **path** (see below) then you should use {{bezpath_points()}} to
//   evaluate the points on that bezier path.  This function is for a single bezier.  
// Arguments:
//   bezier = The list of endpoints and control points for this bezier curve.
//   u = Parameter values for evaluating the curve, given as a single value, a list or a range.  
// Example(2D): Quadratic (Degree 2) Bezier.
//   bez = [[0,0], [30,30], [80,0]];
//   debug_bezier(bez, N=len(bez)-1);
//   translate(bezier_points(bez, 0.3)) color("red") sphere(1);
// Example(2D): Cubic (Degree 3) Bezier
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   debug_bezier(bez, N=len(bez)-1);
//   translate(bezier_points(bez, 0.4)) color("red") sphere(1);
// Example(2D): Degree 4 Bezier.
//   bez = [[0,0], [5,15], [40,20], [60,-15], [80,0]];
//   debug_bezier(bez, N=len(bez)-1);
//   translate(bezier_points(bez, 0.8)) color("red") sphere(1);
// Example(2D): Giving a List of `u`
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   debug_bezier(bez, N=len(bez)-1);
//   pts = bezier_points(bez, [0, 0.2, 0.3, 0.7, 0.8, 1]);
//   rainbow(pts) move($item) sphere(1.5, $fn=12);
// Example(2D): Giving a Range of `u`
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   debug_bezier(bez, N=len(bez)-1);
//   pts = bezier_points(bez, [0:0.2:1]);
//   rainbow(pts) move($item) sphere(1.5, $fn=12);

// Ugly but speed optimized code for computing bezier curves using the matrix representation
// See https://pomax.github.io/bezierinfo/#matrix for explanation.
//
// All of the loop unrolling makes and the use of the matrix lookup table make a big difference
// in the speed of execution.  For orders 10 and below this code is 10-20 times faster than
// the recursive code using the de Casteljau method depending on the bezier order and the
// number of points evaluated in one call (more points is faster).  For orders 11 and above without the
// lookup table or hard coded powers list the code is about twice as fast as the recursive method.
// Note that everything I tried to simplify or tidy this code made is slower, sometimes a lot slower.
function bezier_points(curve, u) =
    is_num(u) ? bezier_points(curve,[u])[0] :
    let(
        N = len(curve)-1,
        M = _bezier_matrix(N)*curve
    )
    N==0 ? [for(uval=u)[1]*M] :
    N==1 ? [for(uval=u)[1, uval]*M] :
    N==2 ? [for(uval=u)[1, uval, uval^2]*M] :
    N==3 ? [for(uval=u)[1, uval, uval^2, uval^3]*M] :          
    N==4 ? [for(uval=u)[1, uval, uval^2, uval^3, uval^4]*M] :
    N==5 ? [for(uval=u)[1, uval, uval^2, uval^3, uval^4, uval^5]*M] :
    N==6 ? [for(uval=u)[1, uval, uval^2, uval^3, uval^4, uval^5,uval^6]*M] :
    N==7 ? [for(uval=u)[1, uval, uval^2, uval^3, uval^4, uval^5,uval^6, uval^7]*M] :
    N==8 ? [for(uval=u)[1, uval, uval^2, uval^3, uval^4, uval^5,uval^6, uval^7, uval^8]*M] :
    N==9 ? [for(uval=u)[1, uval, uval^2, uval^3, uval^4, uval^5,uval^6, uval^7, uval^8, uval^9]*M] :
    N==10? [for(uval=u)[1, uval, uval^2, uval^3, uval^4, uval^5,uval^6, uval^7, uval^8, uval^9, uval^10]*M] :
    /* N>=11 */  [for(uval=u)[for (i=[0:1:N]) uval^i]*M];

// Not public.
function _signed_pascals_triangle(N,tri=[[-1]]) =
    len(tri)==N+1 ? tri :
    let(last=tri[len(tri)-1])
    _signed_pascals_triangle(N,concat(tri,[[-1, for(i=[0:1:len(tri)-2]) (i%2==1?-1:1)*(abs(last[i])+abs(last[i+1])),len(last)%2==0? -1:1]]));

// Not public.
function _compute_bezier_matrix(N) =
    let(tri = _signed_pascals_triangle(N))
    [for(i=[0:N]) concat(tri[N][i]*tri[i], repeat(0,N-i))];

// The bezier matrix, which is related to Pascal's triangle, enables nonrecursive computation
// of bezier points.  This method is much faster than the recursive de Casteljau method
// in OpenScad, but we have to precompute the matrices to reap the full benefit.

// Not public.
_bezier_matrix_table = [
    [[1]],
    [[ 1, 0],
     [-1, 1]],
    [[1, 0, 0],
     [-2, 2, 0],
     [1, -2, 1]],
    [[ 1, 0, 0, 0],
     [-3, 3, 0, 0],
     [ 3,-6, 3, 0],
     [-1, 3,-3, 1]],
    [[ 1,  0,  0, 0, 0],
     [-4,  4,  0, 0, 0],
     [ 6,-12,  6, 0, 0],
     [-4, 12,-12, 4, 0],
     [ 1, -4,  6,-4, 1]],
    [[  1,  0, 0,   0, 0, 0],
     [ -5,  5, 0,   0, 0, 0],
     [ 10,-20, 10,  0, 0, 0],
     [-10, 30,-30, 10, 0, 0],
     [  5,-20, 30,-20, 5, 0],
     [ -1,  5,-10, 10,-5, 1]],
    [[  1,  0,  0,  0,  0, 0, 0],
     [ -6,  6,  0,  0,  0, 0, 0],
     [ 15,-30, 15,  0,  0, 0, 0],
     [-20, 60,-60, 20,  0, 0, 0],
     [ 15,-60, 90,-60, 15, 0, 0],
     [ -6, 30,-60, 60,-30, 6, 0],
     [  1, -6, 15,-20, 15,-6, 1]],
    [[  1,   0,   0,   0,  0,   0, 0, 0],
     [ -7,   7,   0,   0,  0,   0, 0, 0],
     [ 21, -42,  21,   0,  0,   0, 0, 0],
     [-35, 105,-105,  35,  0,   0, 0, 0],
     [ 35,-140, 210,-140,  35,  0, 0, 0],
     [-21, 105,-210, 210,-105, 21, 0, 0],
     [  7, -42, 105,-140, 105,-42, 7, 0],
     [ -1,   7, -21,  35, -35, 21,-7, 1]],
    [[  1,   0,   0,   0,   0,   0,  0, 0, 0],
     [ -8,   8,   0,   0,   0,   0,  0, 0, 0],
     [ 28, -56,  28,   0,   0,   0,  0, 0, 0],
     [-56, 168,-168,  56,   0,   0,  0, 0, 0],
     [ 70,-280, 420,-280,  70,   0,  0, 0, 0],
     [-56, 280,-560, 560,-280,  56,  0, 0, 0],
     [ 28,-168, 420,-560, 420,-168, 28, 0, 0],
     [ -8,  56,-168, 280,-280, 168,-56, 8, 0],
     [  1,  -8,  28, -56,  70, -56, 28,-8, 1]],
    [[1, 0, 0, 0, 0, 0, 0,  0, 0, 0], [-9, 9, 0, 0, 0, 0, 0, 0, 0, 0], [36, -72, 36, 0, 0, 0, 0, 0, 0, 0], [-84, 252, -252, 84, 0, 0, 0, 0, 0, 0],
     [126, -504, 756, -504, 126, 0, 0, 0, 0, 0], [-126, 630, -1260, 1260, -630, 126, 0, 0, 0, 0], [84, -504, 1260, -1680, 1260, -504, 84, 0, 0, 0],
     [-36, 252, -756, 1260, -1260, 756, -252, 36, 0, 0], [9, -72, 252, -504, 630, -504, 252, -72, 9, 0], [-1, 9, -36, 84, -126, 126, -84, 36, -9, 1]],
    [[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [-10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0], [45, -90, 45, 0, 0, 0, 0, 0, 0, 0, 0], [-120, 360, -360, 120, 0, 0, 0, 0, 0, 0, 0],
     [210, -840, 1260, -840, 210, 0, 0, 0, 0, 0, 0], [-252, 1260, -2520, 2520, -1260, 252, 0, 0, 0, 0, 0],
     [210, -1260, 3150, -4200, 3150, -1260, 210, 0, 0, 0, 0], [-120, 840, -2520, 4200, -4200, 2520, -840, 120, 0, 0, 0],
     [45, -360, 1260, -2520, 3150, -2520, 1260, -360, 45, 0, 0], [-10, 90, -360, 840, -1260, 1260, -840, 360, -90, 10, 0],
     [1, -10, 45, -120, 210, -252, 210, -120, 45, -10, 1]]
];

// Not public.
function _bezier_matrix(N) =
    N>10 ? _compute_bezier_matrix(N) :
    _bezier_matrix_table[N];

// Function: bezier_curve()
// Synopsis: Computes a specified number of points on a bezier curve.
// SynTags: Path
// Topics: Bezier Curves
// See Also: bezier_curve(), bezier_curvature(), bezier_tangent(), bezier_derivative(), bezier_points()
// Usage:
//   path = bezier_curve(bezier, [splinesteps], [endpoint]);
// Description:
//   Takes a list of bezier control points and generates splinesteps segments (splinesteps+1 points)
//   along the bezier curve they define.
//   Points start at the first control point and are sampled uniformly along the bezier parameter.
//   The endpoints of the output are *exactly* equal to the first and last bezier control points
//   when endpoint is true.  If endpoint is false the sampling stops one step before the final point
//   of the bezier curve, but you still get the same number of (more tightly spaced) points.  
//   The distance between the points are *not* equidistant.  
//   The degree of the bezier curve is one less than the number of points in `curve`.
//   .
//   Note that if you have a bezier **path** (see below) then you should use {{bezpath_curve()}} to
//   evaluate the that bezier path.  This function is for a single bezier.  
// Arguments:
//   bezier = The list of control points that define the Bezier curve. 
//   splinesteps = The number of segments to create on the bezier curve.  Default: 16
//   endpoint = if false then exclude the endpoint.  Default: True
// Example(2D): Quadratic (Degree 2) Bezier.
//   bez = [[0,0], [30,30], [80,0]];
//   move_copies(bezier_curve(bez, 8)) sphere(r=1.5, $fn=12);
//   debug_bezier(bez, N=len(bez)-1);
// Example(2D): Cubic (Degree 3) Bezier
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   move_copies(bezier_curve(bez, 8)) sphere(r=1.5, $fn=12);
//   debug_bezier(bez, N=len(bez)-1);
// Example(2D): Degree 4 Bezier.
//   bez = [[0,0], [5,15], [40,20], [60,-15], [80,0]];
//   move_copies(bezier_curve(bez, 8)) sphere(r=1.5, $fn=12);
//   debug_bezier(bez, N=len(bez)-1);
function bezier_curve(bezier,splinesteps=16,endpoint=true) =
    bezier_points(bezier, lerpn(0,1,splinesteps+1,endpoint));

// Function: bezier_length()
// Synopsis: Approximate the length of part of a bezier curve.
// Topics: Bezier Curves
// See Also: bezier_points()
// Usage:
//   pathlen = bezier_length(bezier, [start_u], [end_u], [max_deflect]);
// Description:
//   Approximates the length of the portion of the bezier curve between start_u and end_u.
// Arguments:
//   bezier = The list of control points that define the Bezier curve. 
//   start_u = The Bezier parameter to start measuring measuring from.  Between 0 and 1.
//   end_u = The Bezier parameter to end measuring at.  Between 0 and 1.  Greater than start_u.
//   max_deflect = The largest amount of deflection from the true curve to allow for approximation.
// Example:
//   bez = [[0,0], [5,35], [60,-25], [80,0]];
//   echo(bezier_length(bez));
function bezier_length(bezier, start_u=0, end_u=1, max_deflect=0.01) =
    let(
        segs = len(bezier) * 2,
        uvals = lerpn(start_u, end_u, segs+1),
        path = bezier_points(bezier,uvals),
        defl = max([
            for (i=idx(path,e=-3)) let(
                mp = (path[i] + path[i+2]) / 2
            ) norm(path[i+1] - mp)
        ]),
        mid_u = lerp(start_u, end_u, 0.5)
    )
    defl <= max_deflect? path_length(path) :
    sum([
        for (i=[0:1:segs-1]) let(
            su = lerp(start_u, end_u, i/segs),
            eu = lerp(start_u, end_u, (i+1)/segs)
        ) bezier_length(bezier, su, eu, max_deflect)
    ]);

// onescad: BOSL2/shapes3d.scad
//////////////////////////////////////////////////////////////////////
// LibFile: shapes3d.scad
//   Some standard modules for making 3d shapes with attachment support, and function forms
//   that produce a VNF.  Also included are shortcuts cylinders in each orientation and extended versions of
//   the standard modules that provide roundovers and chamfers.  The spheroid() module provides
//   several different ways to make a sphere, and the text modules let you write text on a path
//   so you can place it on a curved object.  A ruler lets you measure objects.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Attachable cubes, cylinders, spheres, ruler, and text.  Many can produce a VNF.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Cuboids, Prismoids and Pyramids

// Function&Module: cube()
// Synopsis: Creates a cube with anchors for attaching children.
// SynTags: Geom, VNF, Ext
// Topics: Shapes (3D), Attachable, VNF Generators, Textures
// See Also: cuboid(), prismoid()
// Usage: As Module (as in native OpenSCAD)
//   cube(size, [center]);
// Usage: With BOSL2 Attachment extensions
//   cube(size, [center|anchor=], [spin=], [orient=]) [ATTACHMENTS];
// Usage: As Function (BOSL2 extension)
//   vnf = cube(size, ...);
// Description:
//   Creates a 3D cubic object.
//   This module extends the built-in cube()` module by providing support for attachments and a function form.  
//   When called as a function, returns a [VNF](vnf.scad) for a cube.
// Arguments:
//   size = The size of the cube.  Default: 1
//   center = A true value sets `anchor=CENTER`, false sets `anchor=FRONT+LEFT+BOTTOM`.  Default: `anchor=CENTER`
//   ---
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// Example: Simple cube.
//   cube(40);
// Example: Rectangular cube.
//   cube([20,40,50]);
// Example: Anchoring.
//   cube([20,40,50], anchor=BOTTOM+FRONT);
// Example: Spin.
//   cube([20,40,50], anchor=BOTTOM+FRONT, spin=30);
// Example: Orientation.
//   cube([20,40,50], anchor=BOTTOM+FRONT, spin=30, orient=FWD);
// Example: Standard Connectors.
//   cube(40, center=true) show_anchors();
// Example: Called as Function
//   vnf = cube([20,40,50]);
//   vnf_polyhedron(vnf);
module cube__1(size=1, center, anchor, spin=0, orient=UP)
{
    dummy = assert(num_defined([center,anchor])<2, "\nCannot give both center and anchor");
    anchor = get_anchor(anchor, center, -[1,1,1], -[1,1,1]);
    size = force_list(size,3);
    dummy2 = assert(is_vector(size,3) && all_nonnegative(size), "\nsize must be a positive scalar or 3-vector.");
    attachable(anchor,spin,orient, size=is_vector(size,3)?size:[1,1,1]) {
        _cube(size, center=true);
        children();
    }
}

// Module: cuboid()
// Synopsis: Creates a cube with chamfering and roundovers.
// SynTags: Geom
// Topics: Shapes (3D), Attachable
// See Also: prismoid(), rounded_prism()
// Usage: Standard Cubes
//   cuboid(size, [anchor=], [spin=], [orient=]);
//   cuboid(size, p1=, ...);
//   cuboid(p1=, p2=, ...);
// Usage: Chamfered Cubes
//   cuboid(size, [chamfer=], [edges=], [except=], [trimcorners=], ...);
// Usage: Rounded Cubes
//   cuboid(size, [rounding=], [teardrop=], [edges=], [except=], [trimcorners=], ...);
// Usage: Attaching children
//   cuboid(...) ATTACHMENTS;
//
// Description:
//   Creates a cube or cuboid object, with optional chamfering or rounding of edges and corners.
//   You cannot mix chamfering and rounding: just one edge treatment with the same size applies to all selected edges.
//   Negative chamfers and roundings can be applied to create external fillets, but they
//   apply only to edges around the top or bottom faces.  If you specify an edge set other than "ALL"
//   with negative roundings or chamfers then you will get an error.  See [Specifying Edges](attachments.scad#section-specifying-edges)
//   for information on how to specify edge sets.
// Arguments:
//   size = The size of the cube, a number or length 3 vector.
//   ---
//   chamfer = Size of chamfer, inset from sides.  Default: No chamfering.
//   rounding = Radius of the edge rounding.  Default: No rounding.
//   edges = Edges to mask.  See [Specifying Edges](attachments.scad#section-specifying-edges).  Default: all edges.
//   except = Edges to explicitly NOT mask.  See [Specifying Edges](attachments.scad#section-specifying-edges).  Default: No edges.
//   trimcorners = If true, rounds or chamfers corners where three chamfered/rounded edges meet.  Default: `true`
//   teardrop = If given as a number, rounding around the bottom edge of the cuboid won't exceed this many degrees from vertical, altering to a chamfer at that angle.  If true, the limit angle is 45 degrees.  Default: `false`
//   clip_angle = If given as a number, rounding around the bottom edge of the cuboid won't exceed this many degrees from vertical, with the rounding stopping at the bottom of the cuboid.  Default: (no clipping)
//   p1 = Align the cuboid's corner at `p1`, if given.  Forces `anchor=FRONT+LEFT+BOTTOM`.
//   p2 = If given with `p1`, defines the top back right corner point of the cuboid, so `p1` and `p2` together specify the cuboid by its bounds.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// Example: Simple regular cube.
//   cuboid(40);
// Example: Cuboid with a corner at the origin
//   cuboid(40, anchor=FRONT+LEFT+BOT);
// Example: Cuboid anchored on its right face
//   cuboid(40, anchor=RIGHT);
// Example: Cube with minimum cornerpoint given.
//   cuboid(20, p1=[10,0,0]);
// Example: Rectangular cube, with given X, Y, and Z sizes.
//   cuboid([20,40,50]);
// Example: Cube by Opposing Corners.
//   cuboid(p1=[0,10,0], p2=[20,30,30]);
// Example: Chamferred Edges and Corners.
//   cuboid([30,40,50], chamfer=5);
// Example: Chamferred Edges, Untrimmed Corners.
//   cuboid([30,40,50], chamfer=5, trimcorners=false);
// Example: Rounded Edges and Corners
//   cuboid([30,40,50], rounding=10);
// Example(VPR=[100,0,25],VPD=180): Rounded Edges and Corners with Teardrop Bottoms
//   cuboid([30,40,50], rounding=10, teardrop=true);
// Example(VPR=[100,0,25],VPD=180): Rounded Edges and Corners with Clipped Bottoms
//   cuboid([30,40,50], rounding=10, clip_angle=40);
// Example: Rounded Edges, Untrimmed Corners
//   cuboid([30,40,50], rounding=10, trimcorners=false);
// Example: Chamferring Selected Edges
//   cuboid(
//       [30,40,50], chamfer=5,
//       edges=[TOP+FRONT,TOP+RIGHT,FRONT+RIGHT],
//       $fn=24
//   );
// Example: Rounding Selected Edges
//   cuboid(
//       [30,40,50], rounding=5,
//       edges=[TOP+FRONT,TOP+RIGHT,FRONT+RIGHT],
//       $fn=24
//   );
// Example: Negative Chamferring
//   cuboid(
//       [30,40,50], chamfer=-5,
//       edges=[TOP,BOT], except=RIGHT,
//       $fn=24
//   );
// Example: Negative Chamferring, Untrimmed Corners
//   cuboid(
//       [30,40,50], chamfer=-5,
//       edges=[TOP,BOT], except=RIGHT,
//       trimcorners=false, $fn=24
//   );
// Example: Negative Rounding
//   cuboid(
//       [30,40,50], rounding=-5,
//       edges=[TOP,BOT], except=RIGHT,
//       $fn=24
//   );
// Example: Negative Rounding, Untrimmed Corners
//   cuboid(
//       [30,40,50], rounding=-5,
//       edges=[TOP,BOT], except=RIGHT,
//       trimcorners=false, $fn=24
//   );
// Example: Roundings and Chamfers can be as large as the full size of the cuboid, so long as the edges would not interfere.
//   cuboid([40,20,10], rounding=20, edges=[FWD+RIGHT,BACK+LEFT]);
// Example: Standard anchors
//   cuboid(40) show_anchors();
module cuboid(
    size,
    p1, p2,
    chamfer,
    rounding,
    edges=EDGES_ALL,
    except=[],
    except_edges,
    trimcorners=true,
    teardrop=false,
    clip_angle,
    anchor=CENTER,
    spin=0,
    orient=UP
) {
    module trunc_cube(s,corner) {
        multmatrix__1(
            (corner.x<0? xflip() : ident(4)) *
            (corner.y<0? yflip() : ident(4)) *
            (corner.z<0? zflip() : ident(4)) *
            scale(s+[1,1,1]*0.001) *
            move(-[1,1,1]/2)
        ) polyhedron(
            [[1,1,1],[1,1,0],[1,0,0],[0,1,1],[0,1,0],[1,0,1],[0,0,1]],
            [[0,1,2],[2,5,0],[0,5,6],[0,6,3],[0,3,4],[0,4,1],[1,4,2],[3,6,4],[5,2,6],[2,4,6]]
        );
    }
    module xtcyl(l,r) {
        if (teardrop) {
            teardrop(r=r, l=l, cap_h=r, ang=teardrop, spin=90, orient=DOWN);
        } else if (is_finite(clip_angle)) {
            cap_h = r * sin(clip_angle);
            hull() {
                teardrop(r=r, l=l, cap_h=cap_h, ang=clip_angle, spin=90, orient=DOWN);
                down(r-cap_h) teardrop(r=r, l=l, cap_h=cap_h, ang=clip_angle, spin=90, orient=DOWN);
            }
        } else {
            yrot(90) cyl(l=l, r=r);
        }
    }
    module ytcyl(l,r) {
        if (teardrop) {
            teardrop(r=r, l=l, cap_h=r, ang=teardrop, spin=0, orient=DOWN);
        } else if (is_finite(clip_angle)) {
            cap_h = r * sin(clip_angle);
            hull() {
                teardrop(r=r, l=l, cap_h=cap_h, ang=clip_angle, spin=0, orient=DOWN);
                down(r-cap_h) teardrop(r=r, l=l, cap_h=cap_h, ang=clip_angle, spin=0, orient=DOWN);
            }
        } else {
            zrot(90) yrot(90) cyl(l=l, r=r);
        }
    }
    module tsphere(r) {
        if (teardrop) {
            onion(r=r, cap_h=r, ang=teardrop, orient=DOWN);
        } else if (is_finite(clip_angle)) {
            cap_h = r * sin(clip_angle);
            hull() {
                onion(r=r, cap_h=cap_h, ang=clip_angle, orient=DOWN);
                down(r-cap_h) onion(r=r, cap_h=cap_h, ang=clip_angle, orient=DOWN);
            }
        } else {
            spheroid(r=r, style="octa", orient=DOWN);
        }
    }
    module corner_shape(corner) {
        e = _corner_edges(edges, corner);
        cnt = sum(e);
        r = first_defined([chamfer, rounding]);
        dummy = assert(is_finite(r) && !approx(r,0));
        c = [r,r,r];
        m = 0.01;
        c2 = v_mul(corner,c/2);
        c3 = v_mul(corner,c-[1,1,1]*m/2);
        $fn = is_finite(chamfer)? 4 : quantup(segs(r),4);
        translate__1(v_mul(corner, size/2-c)) {
            if (cnt == 0 || approx(r,0)) {
                translate__1(c3) cube__1(m, center=true);
            } else if (cnt == 1) {
                if (e.x) {
                    right(c3.x) {
                        intersection() {
                            xtcyl(l=m, r=r);
                            multmatrix__1(
                                (corner.y<0? yflip() : ident(4)) *
                                (corner.z<0? zflip() : ident(4))
                            ) {
                                yrot(-90) linear_extrude(height=m+0.1, center=true) {
                                    polygon([[r,0],[0.999*r,0],[0,0.999*r],[0,r],[r,r]]);
                                }
                            }
                        }
                    }
                } else if (e.y) {
                    back(c3.y) {
                        intersection() {
                            ytcyl(l=m, r=r);
                            multmatrix__1(
                                (corner.x<0? xflip() : ident(4)) *
                                (corner.z<0? zflip() : ident(4))
                            ) {
                                xrot(90) linear_extrude(height=m+0.1, center=true) {
                                    polygon([[r,0],[0.999*r,0],[0,0.999*r],[0,r],[r,r]]);
                                }
                            }
                        }
                    }
                } else if (e.z) {
                    up(c3.z) {
                        intersection() {
                            zcyl(l=m, r=r);
                            multmatrix__1(
                                (corner.x<0? xflip() : ident(4)) *
                                (corner.y<0? yflip() : ident(4))
                            ) {
                                linear_extrude(height=m+0.1, center=true) {
                                    polygon([[r,0],[0.999*r,0],[0,0.999*r],[0,r],[r,r]]);
                                }
                            }
                        }
                    }
                }
            } else if (cnt == 2) {
                intersection() {
                    if (!e.x) {
                        intersection() {
                            ytcyl(l=c.y*2, r=r);
                            zcyl(l=c.z*2, r=r);
                        }
                    } else if (!e.y) {
                        intersection() {
                            xtcyl(l=c.x*2, r=r);
                            zcyl(l=c.z*2, r=r);
                        }
                    } else {
                        intersection() {
                            xtcyl(l=c.x*2, r=r);
                            ytcyl(l=c.y*2, r=r);
                        }
                    }
                    translate__1(c2) trunc_cube(c,corner); // Trim to just the octant.
                }
            } else {
                intersection() {
                    if (trimcorners) {
                        tsphere(r=r);
                    } else {
                        intersection() {
                            xtcyl(l=c.x*2, r=r);
                            ytcyl(l=c.y*2, r=r);
                            zcyl(l=c.z*2, r=r);
                        }
                    }
                    translate__1(c2) trunc_cube(c,corner); // Trim to just the octant.
                }
            }
        }
    }
    sizecheck = assert(num_defined([size,p1,p2])!=3, "\nCannot give size if p2 is given (did you forget brackets on the size argument?)")
                assert(is_def(p1) || is_undef(p2), "\nIf p2 is given you must also give p1.");
    size = force_list(default(size,1),3);
    edges = _edges(edges, except=first_defined([except_edges,except]));
    teardrop = is_bool(teardrop)&&teardrop? 45 : teardrop;
    chamfer = approx(chamfer,0) ? undef : chamfer;
    rounding = approx(rounding,0) ? undef : rounding;
    checks =
        assert(is_vector(size,3),"\n'size' must be a scalar or 3-vector.")
        assert(all_nonnegative(size), "\nAll components of size= must be >=0.")
        assert(is_undef(chamfer) || is_finite(chamfer),"\n'chamfer' must be a finite value.")
        assert(is_undef(rounding) || is_finite(rounding),"\n'rounding' must be a finite value.")
        assert(is_undef(rounding) || is_undef(chamfer), "\nCannot specify nonzero value for both chamfer and rounding.")
        assert(teardrop==false || (is_finite(teardrop) && teardrop>0 && teardrop<=90), "\n'teardrop' must be either false or an angle number between 0 and 90.")
        assert(clip_angle==undef || (is_finite(clip_angle) && clip_angle>0 && clip_angle<=90), "\nclip_angle must be either false or an angle number between 0 and 90.")
        assert(!teardrop || clip_angle==undef, "\nteardrop= and clip_angle= are mutually exclusive features.")
        assert(is_undef(p1) || is_vector(p1,3), "\np1 must be a 3-vector.")
        assert(is_undef(p2) || is_vector(p2,3), "\np2 must be a 3-vector.")
        assert(is_bool(trimcorners));
    if (!is_undef(p1)) {
        if (!is_undef(p2)) {
            translate__1(pointlist_bounds([p1,p2])[0]) {
                cuboid(size=v_abs(p2-p1), chamfer=chamfer, rounding=rounding, edges=edges, trimcorners=trimcorners, anchor=-[1,1,1]) children();
            }
        } else {
            translate__1(p1) {
                cuboid(size=size, chamfer=chamfer, rounding=rounding, edges=edges, trimcorners=trimcorners, anchor=-[1,1,1]) children();
            }
        }
    } else {
        rr = max(default(chamfer,0), default(rounding,0));
        if (rr>0) {
            minx = max(
                edges.y[0] + edges.y[1], edges.y[2] + edges.y[3],
                edges.z[0] + edges.z[1], edges.z[2] + edges.z[3],
                edges.y[0] + edges.z[1], edges.y[0] + edges.z[3],
                edges.y[1] + edges.z[0], edges.y[1] + edges.z[2],
                edges.y[2] + edges.z[1], edges.y[2] + edges.z[3],
                edges.y[3] + edges.z[0], edges.y[3] + edges.z[2]
            ) * rr;
            miny = max(
                edges.x[0] + edges.x[1], edges.x[2] + edges.x[3],
                edges.z[0] + edges.z[2], edges.z[1] + edges.z[3],
                edges.x[0] + edges.z[2], edges.x[0] + edges.z[3],
                edges.x[1] + edges.z[0], edges.x[1] + edges.z[1],
                edges.x[2] + edges.z[2], edges.x[2] + edges.z[3],
                edges.x[3] + edges.z[0], edges.x[3] + edges.z[1]
            ) * rr;
            minz = max(
                edges.x[0] + edges.x[2], edges.x[1] + edges.x[3],
                edges.y[0] + edges.y[2], edges.y[1] + edges.y[3],
                edges.x[0] + edges.y[2], edges.x[0] + edges.y[3],
                edges.x[1] + edges.y[2], edges.x[1] + edges.y[3],
                edges.x[2] + edges.y[0], edges.x[2] + edges.y[1],
                edges.x[3] + edges.y[0], edges.x[3] + edges.y[1]
            ) * rr;
            check =
                assert(minx <= size.x, "\nRounding or chamfering too large for cuboid size in the X axis.")
                assert(miny <= size.y, "\nRounding or chamfering too large for cuboid size in the Y axis.")
                assert(minz <= size.z, "\nRounding or chamfering too large for cuboid size in the Z axis.")
            ;
        }
        majrots = [[0,90,0], [90,0,0], [0,0,0]];
        attachable(anchor,spin,orient, size=size) {
            if (is_finite(chamfer) && !approx(chamfer,0)) {
                if (edges == EDGES_ALL && trimcorners) {
                    if (chamfer<0) {
                        cube__1(size, center=true) {
                            attach(TOP,overlap=0) prismoid([size.x,size.y], [size.x-2*chamfer,size.y-2*chamfer], h=-chamfer, anchor=TOP);
                            attach(BOT,overlap=0) prismoid([size.x,size.y], [size.x-2*chamfer,size.y-2*chamfer], h=-chamfer, anchor=TOP);
                        }
                    } else {
                        isize = [for (v = size) max(0.001, v-2*chamfer)];
                        hull() {
                            cube__1([ size.x, isize.y, isize.z], center=true);
                            cube__1([isize.x,  size.y, isize.z], center=true);
                            cube__1([isize.x, isize.y,  size.z], center=true);
                        }
                    }
                } else if (chamfer<0) {
                    checks = assert(edges == EDGES_ALL || edges[2] == [0,0,0,0], "\nCannot use negative chamfer with Z aligned edges.");
                    ach = abs(chamfer);
                    cube__1(size, center=true);

                    // External-Chamfer mask edges
                    difference() {
                        union() {
                            for (i = [0:3], axis=[0:1]) {
                                if (edges[axis][i]>0) {
                                    vec = EDGE_OFFSETS[axis][i];
                                    translate__1(v_mul(vec/2, size+[ach,ach,-ach])) {
                                        rotate__1(majrots[axis]) {
                                            cube__1([ach, ach, size[axis]], center=true);
                                        }
                                    }
                                }
                            }

                            // Add multi-edge corners.
                            if (trimcorners) {
                                for (za=[-1,1], ya=[-1,1], xa=[-1,1]) {
                                    ce = _corner_edges(edges, [xa,ya,za]);
                                    if (ce.x + ce.y > 1) {
                                        translate__1(v_mul([xa,ya,za]/2, size+[ach-0.01,ach-0.01,-ach])) {
                                            cube__1([ach+0.01,ach+0.01,ach], center=true);
                                        }
                                    }
                                }
                            }
                        }

                        // Remove bevels from overhangs.
                        for (i = [0:3], axis=[0:1]) {
                            if (edges[axis][i]>0) {
                                vec = EDGE_OFFSETS[axis][i];
                                translate__1(v_mul(vec/2, size+[2*ach,2*ach,-2*ach])) {
                                    rotate__1(majrots[axis]) {
                                        zrot(45) cube__1([ach*sqrt(2), ach*sqrt(2), size[axis]+2.1*ach], center=true);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    hull() {
                        corner_shape([-1,-1,-1]);
                        corner_shape([ 1,-1,-1]);
                        corner_shape([-1, 1,-1]);
                        corner_shape([ 1, 1,-1]);
                        corner_shape([-1,-1, 1]);
                        corner_shape([ 1,-1, 1]);
                        corner_shape([-1, 1, 1]);
                        corner_shape([ 1, 1, 1]);
                    }
                }
            } else if (is_finite(rounding) && !approx(rounding,0)) {
                sides = quantup(segs(rounding),4);
                if (edges == EDGES_ALL) {
                    if(rounding<0) {
                        cube__1(size, center=true);
                        zflip_copy() {
                            up(size.z/2) {
                                difference() {
                                    down(-rounding/2) cube__1([size.x-2*rounding, size.y-2*rounding, -rounding], center=true);
                                    down(-rounding) {
                                        ycopies(size.y-2*rounding) xcyl(l=size.x-3*rounding, r=-rounding);
                                        xcopies(size.x-2*rounding) ycyl(l=size.y-3*rounding, r=-rounding);
                                    }
                                }
                            }
                        }
                    } else {
                        isize = [for (v = size) max(0.001, v-2*rounding)];
                        minkowski() {
                            cube__1(isize, center=true);
                            if (trimcorners) {
                                tsphere(r=rounding, $fn=sides);
                            } else {
                                intersection() {
                                    xtcyl(r=rounding, l=rounding*2, $fn=sides);
                                    ytcyl(r=rounding, l=rounding*2, $fn=sides);
                                    cyl(r=rounding, h=rounding*2, $fn=sides);
                                }
                            }
                        }
                    }
                } else if (rounding<0) {
                    checks = assert(edges == EDGES_ALL || edges[2] == [0,0,0,0], "\nCannot use negative rounding with Z aligned edges.");
                    ard = abs(rounding);
                    cube__1(size, center=true);
                    $fn = quantup(segs(rounding),4);
                    // External-Rounding mask edges
                    difference() {
                        union() {
                            for (i = [0:3], axis=[0:1]) {
                                if (edges[axis][i]>0) {
                                    vec = EDGE_OFFSETS[axis][i];
                                    translate__1(v_mul(vec/2, size+[ard,ard,-ard]-[0.01,0.01,0])) {
                                        rotate__1(majrots[axis]) {
                                            cube__1([ard, ard, size[axis]], center=true);
                                        }
                                    }
                                }
                            }

                            // Add multi-edge corners.
                            if (trimcorners) {
                                for (za=[-1,1], ya=[-1,1], xa=[-1,1]) {
                                    ce = _corner_edges(edges, [xa,ya,za]);
                                    if (ce.x + ce.y > 1) {
                                        translate__1(v_mul([xa,ya,za]/2, size+[ard-0.01,ard-0.01,-ard])) {
                                            cube__1([ard+0.01,ard+0.01,ard], center=true);
                                        }
                                    }
                                }
                            }
                        }

                        // Remove roundings from overhangs.
                        for (i = [0:3], axis=[0:1]) {
                            if (edges[axis][i]>0) {
                                vec = EDGE_OFFSETS[axis][i];
                                translate__1(v_mul(vec/2, size+[2*ard,2*ard,-2*ard])) {
                                    rotate__1(majrots[axis]) {
                                        cyl(l=size[axis]+2.1*ard, r=ard);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    hull() {
                        corner_shape([-1,-1,-1]);
                        corner_shape([ 1,-1,-1]);
                        corner_shape([-1, 1,-1]);
                        corner_shape([ 1, 1,-1]);
                        corner_shape([-1,-1, 1]);
                        corner_shape([ 1,-1, 1]);
                        corner_shape([-1, 1, 1]);
                        corner_shape([ 1, 1, 1]);
                    }
                }
            } else {
                cube__1(size=size, center=true);
            }
            children();
        }
    }
}

// Function&Module: prismoid()
// Synopsis: Creates a rectangular prismoid shape with optional roundovers and chamfering.
// SynTags: Geom, VNF
// Topics: Shapes (3D), Attachable, VNF Generators
// See Also: cuboid(), rounded_prism(), trapezoid(), edge_profile()
// Usage: 
//   prismoid(size1, size2, [h|l|height|length], [shift], [xang=], [yang=], ...) [ATTACHMENTS];
// Usage: Chamfered and/or Rounded Prismoids
//   prismoid(size1, size2, h|l|height|length, [chamfer=], [rounding=]...) [ATTACHMENTS];
//   prismoid(size1, size2, h|l|height|length, [chamfer1=], [chamfer2=], [rounding1=], [rounding2=], ...) [ATTACHMENTS];
// Usage: As Function
//   vnf = prismoid(...);
// Description:
//   Creates a rectangular prismoid shape with optional roundovers and chamfering.
//   You can only round or chamfer the vertical(ish) edges.  For those edges, you can
//   specify rounding and/or chamferring per-edge, and for top and bottom separately.
//   If you want to round the bottom or top edges see {{rounded_prism()}} or {{edge_profile()}}
//   .
//   Specification of the prismoid is similar to specification for {{trapezoid()}}.  You can specify the dimensions of the
//   bottom and top and its height to get a symmetric prismoid.  You can use the shift argument to shift the top face around.
//   You can also specify base angles either in the X direction, Y direction or both.  In order to avoid overspecification,
//   you may need to specify a parameter such as size2 as a list of two values, one of which is undef.  For example,
//   specifying `size2=[100,undef]` sets the size in the X direction but allows the size in the Y direction to be computed based on yang.
//   .
//   The anchors on the top and bottom faces have spin pointing back.  The anchors on the side faces have spin point UP.
//   The anchors on the top and bottom edges also have anchors that point clockwise as viewed from outside the shapep.
//   The anchors on the side edges and the corners have spin with positive Z component, pointing along the edge where the anchor is located.
//   A degenerate prismoid with a line segment for the top or bottom has its top or bottom edge anchors set to provide an anchor for that top
//   or bottom edge.  So for example, if the top is `[0,10]` then the top edge is parallel to the Y axis and you can anchor to that
//   edge using the `TOP+RIGHT` or `TOP+LEFT` anchors; these anchors point in the direction that divides the edge in half and provide
//   the `$edge_angle` and `$edge_length` values generally provided by edge anchors.  The UP or DOWN anchor is in the same location but always points
//   in the Z direction and provides no edge data. 
// Arguments:
//   size1 = [width, length] of the bottom end of the prism.
//   size2 = [width, length] of the top end of the prism.
//   h/l/height/length = Height of the prism.
//   shift = [X,Y] amount to shift the center of the top end with respect to the center of the bottom end.
//   ---
//   xang = base angle in the X direction.  Can be a scalar or list of two values, one of which may be undef
//   yang = base angle in the Y direction.  Can be a scalar or list of two values, one of which may be undef
//   rounding = The roundover radius for the vertical-ish edges of the prismoid.  If given as a list of four numbers, gives individual radii for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-]. Default: 0 (no rounding)
//   rounding1 = The roundover radius for the bottom of the vertical-ish edges of the prismoid.  If given as a list of four numbers, gives individual radii for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-].
//   rounding2 = The roundover radius for the top of the vertical-ish edges of the prismoid.  If given as a list of four numbers, gives individual radii for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-].
//   chamfer = The chamfer size for the vertical-ish edges of the prismoid.  If given as a list of four numbers, gives individual chamfers for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-].  Default: 0 (no chamfer)
//   chamfer1 = The chamfer size for the bottom of the vertical-ish edges of the prismoid.  If given as a list of four numbers, gives individual chamfers for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-].
//   chamfer2 = The chamfer size for the top of the vertical-ish edges of the prismoid.  If given as a list of four numbers, gives individual chamfers for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-].
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `BOTTOM`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
//
// Example: Truncated Pyramid
//   prismoid(size1=[35,50], size2=[20,30], h=20);
// Example: Rectangular Pyramid
//   prismoid([40,40], [0,0], h=20);
// Example: Prism
//   prismoid(size1=[40,40], size2=[0,40], h=20);
// Example: Wedge
//   prismoid(size1=[60,35], size2=[30,0], h=30);
// Example: Truncated Tetrahedron
//   prismoid(size1=[10,40], size2=[40,10], h=40);
// Example: Inverted Truncated Pyramid
//   prismoid(size1=[15,5], size2=[30,20], h=20);
// Example: Right Prism
//   prismoid(size1=[30,60], size2=[0,60], shift=[-15,0], h=30);
// Example(FlatSpin,VPD=160,VPT=[0,0,10]): Shifting/Skewing
//   prismoid(size1=[50,30], size2=[20,20], h=20, shift=[15,5]);
// Example: Specifying bottom, height and angle
//   prismoid(size1=[100,75], h=30, xang=50, yang=70);
// Example: Specifying top, height and angle, with asymmetric angles
//   prismoid(size2=[100,75], h=30, xang=[50,60], yang=[70,40]);
// Example: Specifying top, bottom and angle for X and using that to define height. Giving yang here would likely give a conflicting height calculation, which is not allowed.  
//   prismoid(size1=[100,75], size2=[75,35], xang=50);
// Example: The same as the previous example but we give a shift in Y.  Note that shift.x must be undef because you cannot give combine an angle with a shift, so a shift.x value would conflict with xang being defined.  
//   prismoid(size1=[100,75], size2=[75,35], xang=50, shift=[undef,20]);
// Example:  The X dimensions defined by the base length, angle and height; the Y dimensions defined by the top length, angle, and height. 
//   prismoid(size1=[100,undef], size2=[undef,75], h=30, xang=[20,90], yang=30);
// Example: Rounding
//   prismoid(100, 80, rounding=10, h=30);
// Example: Chamfers
//   prismoid(100, 80, chamfer=5, h=30);
// Example: Gradiant Rounding
//   prismoid(100, 80, rounding1=10, rounding2=0, h=30);
// Example: Per Corner Rounding
//   prismoid(100, 80, rounding=[0,5,10,15], h=30);
// Example: Per Corner Chamfer
//   prismoid(100, 80, chamfer=[0,5,10,15], h=30);
// Example: Mixing Chamfer and Rounding
//   prismoid(
//       100, 80, h=30,
//       chamfer=[0,5,0,10],
//       rounding=[5,0,10,0]
//   );
// Example: Really Mixing It Up
//   prismoid(
//       size1=[100,80], size2=[80,60], h=20,
//       chamfer1=[0,5,0,10], chamfer2=[5,0,10,0],
//       rounding1=[5,0,10,0], rounding2=[0,5,0,10]
//   );
// Example: How to Round a Top or Bottom Edge
//   diff()
//   prismoid([50,30], [30,20], shift=[3,6], h=15, rounding=[5,0,5,0]) {
//       edge_profile([TOP+RIGHT, BOT+FRONT], excess=10, convexity=20) {
//           mask2d_roundover(h=5,mask_angle=$edge_angle);
//       }
//   }
// Example(Spin,VPD=160,VPT=[0,0,10]): Standard anchors
//   prismoid(size1=[50,30], size2=[20,20], h=20, shift=[15,5])
//       show_anchors();
// Example(3D): When the top or bottom is degenerate, you can anchor to and round the degenerate edge by using either one of the edge anchors that correspond to that edge.  But note that {{edge_profile()}} does not work for this degenerate case.  We used `TOP+RIGHT` below as the anchor point, but `TOP+LEFT` produces an identical result.   
//   diff()
//   prismoid([10,14],[0,8], shift=[4,3], h=7)
//     attach(TOP+RIGHT, FWD+LEFT, inside=true)
//       rounding_edge_mask(r=2,l=$edge_length+6);
module prismoid(
    size1=undef, size2=undef, h, shift=[undef,undef],
    xang, yang,
    rounding=0, rounding1, rounding2,
    chamfer=0, chamfer1, chamfer2,
    l, height, length, center,
    anchor, spin=0, orient=UP
)
{
    vnf_s1_s2_shift = prismoid(
        size1=size1, size2=size2, h=h, shift=shift,
        xang=xang, yang=yang, 
        rounding=rounding, chamfer=chamfer, 
        rounding1=rounding1, rounding2=rounding2,
        chamfer1=chamfer1, chamfer2=chamfer2,
        l=l, height=height, length=length, anchor=BOT, _return_dim=true
    );
    anchor = get_anchor(anchor, center, BOT, BOT);
    attachable(anchor,spin,orient, size=vnf_s1_s2_shift[1], size2=vnf_s1_s2_shift[2], shift=vnf_s1_s2_shift[3]) {
        down(vnf_s1_s2_shift[1].z/2)
            vnf_polyhedron(vnf_s1_s2_shift[0], convexity=4);
        children();
    }
}

function prismoid(
    size1, size2, h, shift=[0,0],
    rounding=0, rounding1, rounding2,
    chamfer=0, chamfer1, chamfer2,
    l, height, length, center,
    anchor=DOWN, spin=0, orient=UP, xang, yang,
    _return_dim=false
    
) =
    assert(is_undef(shift) || is_num(shift) || len(shift)==2, "\nshift must be a number or list of length 2.")
    assert(is_undef(size1) || is_num(size1) || len(size1)==2, "\nsize1 must be a number or list of length 2.")
    assert(is_undef(size2) || is_num(size2) || len(size2)==2, "\nsize2 must be a number or list of length 2.")  
    let(
        xang = force_list(xang,2),
        yang = force_list(yang,2),
        yangOK = len(yang)==2 && (yang==[undef,undef] || (all_positive(yang) && yang[0]<180 && yang[1]<180)),
        xangOK = len(xang)==2 && (xang==[undef,undef] || (all_positive(xang) && xang[0]<180 && xang[1]<180)),
        size1=force_list(size1,2),
        size2=force_list(size2,2),
        h=first_defined([l,h,length,height]),
        shift = force_list(shift,2)
    )
    assert(xangOK, "\nPrismoid angles must be scalar or 2-vector, strictly between 0 and 180.")
    assert(yangOK, "\nPrismoid angles must be scalar or 2-vector, strictly between 0 and 180.")
    assert(xang==[undef,undef] || shift.x==undef, "\nCannot specify xang and a shift.x value together.")
    assert(yang==[undef,undef] || shift.y==undef, "\nCannot specify yang and a shift.y value together.")
    assert(all_positive([h]) || is_undef(h), "\nh must be a positive value.")
    let(
        hx = _trapezoid_dims(h,size1.x,size2.x,shift.x,xang)[0],
        hy = _trapezoid_dims(h,size1.y,size2.y,shift.y,yang)[0]
    )
    assert(num_defined([hx,hy])>0, "\nHeight not given and specification does not determine prismoid height.")
    assert(hx==undef || hy==undef || approx(hx,hy),
           str("\nX and Y angle specifications cause conflicting height values ",hx," and ",hy,"."))
    let(
        h = first_defined([hx,hy]),
        x_h_w1_w2_shift = _trapezoid_dims(h,size1.x,size2.x,shift.x,xang),
        y_h_w1_w2_shift = _trapezoid_dims(h,size1.y,size2.y,shift.y,yang)
    )
    let(
        s1 = [x_h_w1_w2_shift[1], y_h_w1_w2_shift[1]],
        s2 = [x_h_w1_w2_shift[2], y_h_w1_w2_shift[2]],
        shift = [x_h_w1_w2_shift[3], y_h_w1_w2_shift[3]]
    )
    assert(is_vector(s1,2), "\nInsufficient information to define prismoid.")
    assert(is_vector(s2,2), "\nInsufficient information to define prismoid.")
    assert(all_nonnegative(concat(s1,s2)),"\nDegenerate prismoid geometry.")
    assert(s1.x+s2.x>0 && s1.y+s2.y>0, "\nDegenerate prismoid geometry.")
    assert(is_num(rounding) || is_vector(rounding,4), "\nrounding must be a number or 4-vector.")
    assert(is_undef(rounding1) || is_num(rounding1) || is_vector(rounding1,4), "\nrounding1 must be a number or 4-vector.")
    assert(is_undef(rounding2) || is_num(rounding2) || is_vector(rounding2,4), "\nrounding2 must be a number or 4-vector.")
    assert(is_num(chamfer) || is_vector(chamfer,4), "\nchamfer must be a number or 4-vector.")
    assert(is_undef(chamfer1) || is_num(chamfer1) || is_vector(chamfer1,4), "\nchamfer1 must be a number or 4-vector.")
    assert(is_undef(chamfer2) || is_num(chamfer2) || is_vector(chamfer2,4), "\nchamfer2 must be a number or 4-vector.")
    let(
        chamfer1=force_list(default(chamfer1,chamfer),4),
        chamfer2=force_list(default(chamfer2,chamfer),4),
        rounding1=force_list(default(rounding1,rounding),4),
        rounding2=force_list(default(rounding2,rounding),4)
    )
    assert(all_nonnegative(chamfer1), "\nchamfer/chamfer1 must be non-negative.")
    assert(all_nonnegative(chamfer2), "\nchamfer/chamfer2 must be non-negative.")
    assert(all_nonnegative(rounding1), "\nrounding/rounding1 must be non-negative.")
    assert(all_nonnegative(rounding2), "\nrounding/rounding2 must be non-negative.")        
    assert(all_zero(v_mul(rounding1,chamfer1),0),
           "\nrounding1 and chamfer1 (possibly inherited from rounding and chamfer) cannot both be nonzero at the same corner.")
    assert(all_zero(v_mul(rounding2,chamfer2),0),
           "\nrounding2 and chamfer2 (possibly inherited from rounding and chamfer) cannot both be nonzero at the same corner.")
    let(
        rounding1 = default(rounding1, rounding),
        rounding2 = default(rounding2, rounding),
        chamfer1 = default(chamfer1, chamfer),
        chamfer2 = default(chamfer2, chamfer),
        anchor = get_anchor(anchor, center, BOT, BOT),
        path1 = rect(s1, rounding=rounding1, chamfer=chamfer1, anchor=CTR),
        path2 = rect(s2, rounding=rounding2, chamfer=chamfer2, anchor=CTR),
        points = [
                    each path3d(path1, -h/2),
                    each path3d(move(shift, path2), +h/2),
                 ],
        faces = hull(points),
        vnf = [points, faces]
    )
    _return_dim ? [reorient(anchor,spin,orient, size=[s1.x,s1.y,h], size2=s2, shift=shift, p=vnf),point3d(s1,h),s2,shift]
                : reorient(anchor,spin,orient, size=[s1.x,s1.y,h], size2=s2, shift=shift, p=vnf);

// Section: Cylinders


// Function&Module: cylinder()
// Synopsis: Creates an attachable cylinder.
// SynTags: Geom, VNF, Ext
// Topics: Shapes (3D), Attachable, VNF Generators
// See Also: cyl()
// Usage: As Module (as in native OpenSCAD)
//   cylinder(h, r=/d=, [center=]);
//   cylinder(h, r1/d1=, r2/d2=, [center=]);
// Usage: With BOSL2 anchoring and attachment extensions
//   cylinder(h, r=/d=, [center=|anchor=], [spin=], [orient=]) [ATTACHMENTS];
//   cylinder(h, r1/d1=, r2/d2=, [center=|anchor=], [spin=], [orient=]) [ATTACHMENTS];
// Usage: As Function (BOSL2 extension)
//   vnf = cylinder(h, r=/d=, ...);
//   vnf = cylinder(h, r1/d1=, r2/d2=, ...);
// Description:
//   Creates a 3D cylinder or conic object.
//   This modules extends the built-in `cylinder()` module by adding support for attachment and by adding a function version.   
//   When called as a function, returns a [VNF](vnf.scad) for a cylinder.  The defaults 
// Arguments:
//   h = The height of the cylinder. Default: 1
//   r1 = The bottom radius of the cylinder. Default: 1
//   r2 = The top radius of the cylinder.  Default: 1
//   center = A true value sets `anchor=CENTER`, false sets `anchor=BOTTOM`.  Default: false (`anchor=BOTTOM`)
//   ---
//   d1 = The bottom diameter of the cylinder. 
//   d2 = The top diameter of the cylinder. 
//   r = The radius of the cylinder.
//   d = The diameter of the cylinder.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `BOTTOM`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// Example: By Radius
//   xdistribute(30) {
//       cylinder(h=40, r=10);
//       cylinder(h=40, r1=10, r2=5);
//   }
// Example: By Diameter
//   xdistribute(30) {
//       cylinder(h=40, d=25);
//       cylinder(h=40, d1=25, d2=10);
//   }
// Example(Med): Anchoring
//   cylinder(h=40, r1=10, r2=5, anchor=BOTTOM+FRONT);
// Example(Med): Spin
//   cylinder(h=40, r1=10, r2=5, anchor=BOTTOM+FRONT, spin=45);
// Example(Med): Orient
//   cylinder(h=40, r1=10, r2=5, anchor=BOTTOM+FRONT, spin=45, orient=FWD);
// Example(Big): Standard Connectors
//   xdistribute(40) {
//       cylinder(h=30, d=25) show_anchors();
//       cylinder(h=30, d1=25, d2=10) show_anchors();
//   }
module cylinder__1(h, r1, r2, center, r, d, d1, d2, anchor, spin=0, orient=UP)
{
    dummy = assert(num_defined([anchor,center])<2, "\nCannot give both center and anchor.");
    anchor = get_anchor(anchor, center, BOTTOM, BOTTOM);
    r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1);
    r2 = get_radius(r1=r2, r=r, d1=d2, d=d, dflt=1);
    h = default(h,1);
    dummy2 = assert(is_finite(h) && h>0, "\nh must be a positive number.")
             assert(is_finite(r1) && r1>=0, "\nr1 must be a non-negative number.")
             assert(is_finite(r2) && r2>=0, "\nr2 must be a non-negative number.");
    attachable(anchor,spin,orient, r1=r1, r2=r2, l=h) {
        _cylinder(h=h, r1=r1, r2=r2, center=true);
        children();
    }
}

function cylinder(h, r1, r2, center, r, d, d1, d2, anchor, spin=0, orient=UP) =
    assert(is_undef(center) || is_bool(center), "\ncenter must be boolean.")
    assert(num_defined([anchor,center])<2, "\nCannot give both center and anchor.")
    let(
        anchor = get_anchor(anchor, center, BOTTOM, BOTTOM),
        r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1),
        r2 = get_radius(r1=r2, r=r, d1=d2, d=d, dflt=1),
        l = default(h,1),
        sides = segs(max(r1,r2)),
        verts = [
            for (i=[0:1:sides-1]) let(a=360*(1-i/sides)) [r1*cos(a),r1*sin(a),-l/2],
            for (i=[0:1:sides-1]) let(a=360*(1-i/sides)) [r2*cos(a),r2*sin(a), l/2],
        ],
        faces = [
            [for (i=[0:1:sides-1]) sides-1-i],
            for (i=[0:1:sides-1]) [i, ((i+1)%sides)+sides, i+sides],
            for (i=[0:1:sides-1]) [i, (i+1)%sides, ((i+1)%sides)+sides],
            [for (i=[0:1:sides-1]) sides+i]
        ]
    ) [reorient(anchor,spin,orient, l=l, r1=r1, r2=r2, p=verts), faces];

// Function&Module: cyl()
// Synopsis: Creates an attachable cylinder with roundovers, chamfering or texturing.
// SynTags: Geom, VNF
// Topics: Cylinders, Textures, Rounding, Chamfers
// See Also: regular_prism(), texture(), rotate_sweep(), cylinder()
// Usage: Normal Cylinders
//   cyl(l|h|length|height, r, [r2], [center|anchor=], [circum=], [realign=]) [ATTACHMENTS];
//   cyl(l|h|length|height, d=, ...) [ATTACHMENTS];
//   cyl(l|h|length|height, r1=|d1=, r2=|d2=, ...) [ATTACHMENTS];
//
// Usage: Chamferred Cylinders
//   cyl(..., chamfer=, [chamfang=], [from_end=], ...);
//   cyl(..., [chamfer1=], [chamfer2=], [chamfang1=], [chamfang2=], [from_end=], ...);
//
// Usage: Rounded End Cylinders
//   cyl(..., rounding=, [teardrop=], [clip_angle=], ...);
//   cyl(..., [rounding1=], [rounding2=], [teardrop=], [clip_angle=], ...);
//
// Usage: Textured Cylinders
//   cyl(..., texture=, [tex_size=]|[tex_reps=], [tex_depth=], [tex_rot=], [tex_samples=], [style=], [tex_taper=], [tex_inset=], ...);
//
// Usage: Called as a function to get a VNF
//   vnf = cyl(...);
//
// Description:
//   Creates cylinders in various anchorings and orientations, with optional rounding, chamfers, or textures.
//   You can use `h` and `l` interchangably, and all variants allow specifying size by either `r`|`d`,
//   or `r1`|`d1` and `r2`|`d2`.  The chamfers and rounding cannot be cumulatively longer than
//   the cylinder or cone's sloped side.  The more specific parameters like chamfer1 or rounding2 override the more
//   general ones like chamfer or rounding, so if you specify `rounding=3, chamfer2=3` you get a chamfer at the top and
//   rounding at the bottom.  You can specify extra height at either end (e.g. with `extra=`) for use with difference(); the extra
//   height is ignored by anchoring.
//   .
//   You can apply a texture to the cylinder using the usual texture parameters.   
//   See [Texturing](skin.scad#section-texturing) for more details on how textures work.  
//   When creating a textured cylinder, the number of facets is determined by the sampling of the texture.  Any `$fn`, `$fa` or `$fs` values in
//   effect are ignored.  To create a textured prism with a specified number of flat facets use {{regular_prism()}}.  Anchors for cylinders
//   appear on the ideal cylinder, not on actual discretized shape the module produces. For anchors on the shape surface, use {{regular_prism()}}.  
//   .
//   When chamfering or rounding, the angle of chamfers is done at the face of the facets of the shape.
//   If `circum=false` (the default) then the radius or chamfer length is measured at the corner of the shape.  If `circum=true`
//   then the radius or chamfer length applies in the more usual way in the center of a facet.  For cylinders with a large `$fn`
//   the difference between these two things is negligible, but it can be quite sigificant when `$fn` is small.
//   This means that when `circum=false` the size of chamfers and roundings (and whether they fit) can depend on current `$fn`.
//   .
//   When the `realign` parameter is false the shape's has an edge aligned with the X+ axis. 
//   If `realign` is true then a face is aligned with the X+ axis.  By default
//   `realign` is false when `circum` is false and true if `circum` is true.  This means that when `$fn` is a multiple of four the approximate cylinder always
//   has exactly correct dimensions on the X and Y axes regardless of the setting for circum, and it also means that cylinders match "octa"
//   style spheroids on any of the coordinate planes. 
//   .
//   If you use the positional parameters, this module has an inconsistency with the native {{cylinder()}} module.  The `cylinder()` module
//   has a default of `r2=1` so `cylinder(10,5)` produces a cone with radius 1 at the top, but `cyl()` defaults to a right angle cylinder in this case.  
// Figure(2D,Big,NoAxes,VPR = [0, 0, 0], VPT = [0,0,0], VPD = 82): Chamfers on cones can be tricky.  This figure shows chamfers of the same size and same angle, A=30 degrees.  Note that the angle is measured on the inside, and produces a quite different looking chamfer at the top and bottom of the cone.  Straight black arrows mark the size of the chamfers, which may not even appear the same size visually.  When you do not give an angle, the triangle that is cut off will be isoceles, like the triangle at the top, with two equal angles.
//  color("lightgray")
//  projection()
//      cyl(r2=10, r1=20, l=20,chamfang=30, chamfer=0,orient=BACK);
//  projection()
//      cyl(r2=10, r1=20, l=20,chamfang=30, chamfer=8,orient=BACK);
//  color("black"){
//      fwd(9.6)right(20-4.8)text("A",size=1.3);
//      fwd(-8.4)right(10-4.9)text("A",size=1.3);
//      right(20-8)fwd(10.5)stroke([[0,0],[8,0]], endcaps="arrow2",width=.15);
//      right(10-8)fwd(-10.5)stroke([[0,0],[8,0]], endcaps="arrow2",width=.15);
//      stroke(arc(cp=[2,10], angle=[0,-30], n=20, r=5), width=.18, endcaps="arrow2");
//      stroke(arc(cp=[12,-10], angle=[0,30], n=20, r=5), width=.18, endcaps="arrow2");
//  }
// Figure(2D,Big,NoAxes,VPR = [0, 0, 0], VPT = [0,0,0], VPD = 82): The cone in this example is narrow but has the same slope.  With negative chamfers, the angle A=30 degrees is on the outside.  The chamfers are again quite different looking.  As before, the default features two congruent angles, and in this case it happens at the bottom of the cone but not the top.  The straight arrows again show the size of the chamfer.
//  r1=10-7.5;r2=20-7.5;
//  color("lightgray")
//  projection()
//      cyl(r2=r1, r1=r2, l=20,chamfang=30, chamfer=-8,orient=BACK);
//  projection()
//      cyl(r2=r1, r1=r2, l=20,chamfang=30, chamfer=0,orient=BACK);
//  color("black"){
//      fwd(9.7)right(r2+3.8)text("A",size=1.3);
//      fwd(-8.5)right(r1+3.7)text("A",size=1.3);
//      right(r2)fwd(10.5)stroke([[0,0],[8,0]], endcaps="arrow2",width=.15);
//      right(r1)fwd(-10.5)stroke([[0,0],[8,0]], endcaps="arrow2",width=.15);
//      stroke(arc(cp=[r1+8,10], angle=[180,180+30], n=20, r=5), width=.18, endcaps="arrow2");
//      stroke(arc(cp=[r2+8,-10], angle=[180-30,180], n=20, r=5), width=.18, endcaps="arrow2");
//  }
// Arguments:
//   l / h / length / height = Length of cylinder along oriented axis.  Default: 1
//   r = Radius of cylinder.  Default: 1
//   center = A true value sets `anchor=CENTER`, false sets `anchor=DOWN`.
//   ---
//   r1 = Radius of the negative (X-, Y-, Z-) end of cylinder.
//   r2 = Radius of the positive (X+, Y+, Z+) end of cylinder.
//   d = Diameter of cylinder.
//   d1 = Diameter of the negative (X-, Y-, Z-) end of cylinder.
//   d2 = Diameter of the positive (X+, Y+, Z+) end of cylinder.
//   circum = If true, cylinder should circumscribe the circle of the given size.  Otherwise inscribes.  Default: `false`
//   shift = [X,Y] amount to shift the center of the top end with respect to the center of the bottom end.
//   chamfer = The size of the chamfers on the ends of the cylinder.  (Also see: `from_end=`)  Default: none.
//   chamfer1 = The size of the chamfer on the bottom end of the cylinder.  (Also see: `from_end1=`)  Default: none.
//   chamfer2 = The size of the chamfer on the top end of the cylinder.  (Also see: `from_end2=`)  Default: none.
//   chamfang = The angle in degrees of the chamfers away from the ends of the cylinder.  Default: Chamfer angle is halfway between the endcap and cone face.
//   chamfang1 = The angle in degrees of the bottom chamfer away from the bottom end of the cylinder.  Default: Chamfer angle is halfway between the endcap and cone face.
//   chamfang2 = The angle in degrees of the top chamfer away from the top end of the cylinder.  Default: Chamfer angle is halfway between the endcap and cone face.
//   from_end = If true, chamfer is measured along the conic face from the ends of the cylinder, instead of inset from the edge.  Default: `false`.
//   from_end1 = If true, chamfer on the bottom end of the cylinder is measured along the conic face from the end of the cylinder, instead of inset from the edge.  Default: `false`.
//   from_end2 = If true, chamfer on the top end of the cylinder is measured along the conic face from the end of the cylinder, instead of inset from the edge.  Default: `false`.
//   rounding = The radius of the rounding on the ends of the cylinder.  Default: none.
//   rounding1 = The radius of the rounding on the bottom end of the cylinder.
//   rounding2 = The radius of the rounding on the top end of the cylinder.
//   extra = Add extra height at both ends that is invisible to anchoring for use with differencing.  Default: 0
//   extra1 = Add extra height to the bottom end
//   extra2 = Add extra height to the top end.
//   realign = If false a vertical edge is aligned to the X+ axis.  If true a vertical face is aligned to the X+ axis.  Default: false if `circum=false` and true if `circum=true`
//   teardrop = If given as a number, rounding around the bottom edge of the cylinder won't exceed this many degrees from horizontal.  If true, the limit angle is 45 degrees.  Default: `false`
//   clip_angle = Clip the rounding arc at the bottom of the cylinder at this angle away from vertical, with a corner at the base of the cylinder and a smooth joint at the side.  An angle of 90 gives a complete circle and an angle of zero clips away the entire rounding.  Default: 90 (no clipping)
//   texture = A texture name string, or a rectangular array of scalar height values (0.0 to 1.0), or a VNF tile that defines the texture to apply to vertical surfaces.  See {{texture()}} for what named textures are supported.
//   tex_size = An optional 2D target size (2-vector or scalar) for the textures.  Actual texture sizes are scaled somewhat to fit evenly on the available surface. Default: `[5,5]`
//   tex_reps = If given instead of tex_size, a scalar or 2-vector giving the integer number of texture tile repetitions in the horizontal and vertical directions.
//   tex_inset = If numeric, lowers the texture into the surface by the specified proportion, e.g. 0.5 would lower it halfway into the surface.  If `true`, insets by exactly its full depth.  Default: `false`
//   tex_rot = Rotate texture by specified angle, which must be a multiple of 90 degrees.  Default: 0
//   tex_depth = Specify texture depth; if negative, invert the texture.  Default: 1.  
//   tex_samples = Minimum number of "bend points" to have in VNF texture tiles.  Default: 8
//   tex_taper = The `tex_taper` parameter to {{rotate_sweep()}}.  If given as a number, tapers the texture depth to zero at the ends over the specified fraction of the height.  You can also give a lookup table or function to create custom depth taperings across the height of the cylinder.  The lookup table or function should be defined on the interval [0,1] where 0 gives the depth multiplier at the bottom and 1 the depth multiplier at the top.  Default: no taper
//   style = {{vnf_vertex_array()}} style used to triangulate heightfield textures.  Default: "min_edge"
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// Example: By radius
//   xdistribute(30) {
//       cyl(l=40, r=10);
//       cyl(l=40, r1=10, r2=5);
//   }
// Example: By diameter
//   xdistribute(30) {
//       cyl(l=40, d=25);
//       cyl(l=40, d1=25, d2=10);
//   }
// Example: Chamferring
//   xdistribute(60) {
//       // Shown Left to right.
//       cyl(l=40, d=40, chamfer=7);  // Default chamfang=45
//       cyl(l=40, d=40, chamfer=7, chamfang=30, from_end=false);
//       cyl(l=40, d=40, chamfer=7, chamfang=30, from_end=true);
//   }
// Example: Rounding
//   cyl(l=40, d=40, rounding=10);
// Example(VPD=175;VPR=[90,0,0]): Teardrop Bottom Rounding
//   cyl(l=40, d=40, rounding=10, teardrop=true);
// Example(VPD=175;VPR=[90,0,0]): Clipped Bottom Rounding
//   cyl(l=40, d=40, rounding=10, clip_angle=40);
// Example: Heterogenous Chamfers and Rounding
//   ydistribute(80) {
//       // Shown Front to Back.
//       cyl(l=40, d=40, rounding1=15, orient=UP);
//       cyl(l=40, d=40, chamfer2=5, orient=UP);
//       cyl(l=40, d=40, chamfer1=12, rounding2=10, orient=UP);
//   }
// Example: Putting it all together
//   cyl(
//       l=20, d1=25, d2=15,
//       chamfer1=5, chamfang1=60,
//       from_end=true, rounding2=5
//   );
// Example: External chamfers
//   cyl(l=50, r=30, chamfer=-5, chamfang=30, $fa=1, $fs=1);
// Example: External Roundings
//   cyl(l=50, r=30, rounding1=-5, rounding2=5, $fa=1, $fs=1);
// Example(Med): Standard Connectors
//   xdistribute(40) {
//       cyl(l=30, d=25) show_anchors();
//       cyl(l=30, d1=25, d2=10) show_anchors();
//   }
// Example: Texturing with heightfield diamonds
//   cyl(h=40, r=20, texture="diamonds", tex_size=[5,5]);
// Example: Texturing with heightfield pyramids
//   cyl(h=40, r1=20, r2=15,
//       texture="pyramids", tex_size=[5,5],
//       style="convex");
// Example: Texturing with heightfield truncated pyramids
//   cyl(h=40, r1=20, r2=15, chamfer=5,
//       texture="trunc_pyramids",
//       tex_size=[5,5], style="convex");
// Example: Texturing with VNF tile "dots"
//   cyl(h=40, r1=20, r2=15, rounding=9,
//       texture="dots", tex_size=[5,5],
//       tex_samples=6);
// Example: Texturing with VNF tile "bricks_vnf"
//   cyl(h=50, r1=25, r2=20, shift=[0,10], rounding1=-10,
//       texture="bricks_vnf", tex_size=[10,10],
//       tex_depth=0.5, style="concave");
// Example: No Texture Taper
//   cyl(d1=25, d2=20, h=30, rounding=5,
//       texture="trunc_ribs", tex_size=[5,1]);
// Example: Taper Texure at Extreme Ends
//   cyl(d1=25, d2=20, h=30, rounding=5,
//       texture="trunc_ribs", tex_taper=0,
//       tex_size=[5,1]);
// Example: Taper Texture over First and Last 10%
//   cyl(d1=25, d2=20, h=30, rounding=5,
//       texture="trunc_ribs", tex_taper=0.1,
//       tex_size=[5,1]);
// Example(3D,Med,NoAxes): Making a Clay Pattern Roller
//   tex = [
//       [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
//       [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
//       [1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,],
//       [1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,],
//       [0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,],
//       [0,1,1,0,0,1,1,0,0,0,0,0,0,0,0,0,],
//       [0,1,1,0,0,1,1,0,0,1,1,1,1,1,1,0,],
//       [0,1,1,0,0,1,1,0,0,1,1,1,1,1,1,0,],
//       [0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,],
//       [0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,],
//       [0,1,1,0,0,1,1,1,1,1,1,0,0,1,1,0,],
//       [0,1,1,0,0,1,1,1,1,1,1,0,0,1,1,0,],
//       [0,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,],
//       [0,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,],
//       [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,],
//       [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,],
//       [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,],
//   ];
//   diff()
//   cyl(d=20*10/PI, h=10, chamfer=0,
//       texture=tex, tex_reps=[20,1], tex_depth=-1,
//       style="concave") {
//           attach([TOP,BOT]) {
//               cyl(d1=20*10/PI, d2=30, h=5, anchor=BOT)
//                   attach(TOP) {
//                       tag("remove") zscale(0.5) up(3) sphere(d=15);
//                   }
//           }
//   }


// This function produces a path to rotate_extrude to make a "cylinder".  The extrusion
// produces the extreme points, and so the path is the path of a "corner" of the resulting
// object.  But things like chamfer angle and roundings should be relative to FACES.  So
// the code corrects the path to account for this, which is why it needs n, the number of
// sides.  If n is omitted, no correction occurs.  If you give n and set noscale=true then
// it corrects for the angle but still makes the chamfer lengths or rounding lengths along
// the corner edge.  This makes cylinders stack as expected (e.g. if you make a cyl with
// radius 5 and chamfer 1 then a radius 4 cyl fits on top.)
function _cyl_path(
    r1, r2, l, 
    chamfer, chamfer1, chamfer2,
    chamfang, chamfang1, chamfang2,
    rounding, rounding1, rounding2,
    from_end, from_end1, from_end2,
    teardrop=false, clip_angle=90, n, noscale=false
) =
    let(
        scale= is_def(n) ? cos(180/n) : 1, 
        vang = atan2(scale*(r1-r2),l),
        _chamf1 = first_defined([chamfer1, if (is_undef(rounding1)) chamfer, 0]),
        _chamf2 = first_defined([chamfer2, if (is_undef(rounding2)) chamfer, 0]),
        _fromend1 = first_defined([from_end1, from_end, false]),
        _fromend2 = first_defined([from_end2, from_end, false]),
        chang1 = first_defined([chamfang1, chamfang, 45+sign(_chamf1)*vang/2]),
        chang2 = first_defined([chamfang2, chamfang, 45-sign(_chamf2)*vang/2]),
        round1 = first_defined([rounding1, if (is_undef(chamfer1)) rounding, 0]),
        round2 = first_defined([rounding2, if (is_undef(chamfer2)) rounding, 0]),
        checks1 =
            assert(is_finite(_chamf1), "\nchamfer1 must be a finite number if given.")
            assert(is_finite(_chamf2), "\nchamfer2 must be a finite number if given.")
            assert(is_finite(chang1) && chang1>0, "\nchamfang1 must be a positive number if given.")
            assert(is_finite(chang2) && chang2>0, "\nchamfang2 must be a positive number if given.")
            assert(chang1<90+sign(_chamf1)*vang, "\nchamfang1 must be smaller than the cone face angle.")
            assert(chang2<90-sign(_chamf2)*vang, "\nchamfang2 must be smaller than the cone face angle.")
            assert(num_defined([chamfer1,rounding1])<2, "\nCannot define both chamfer1 and rounding1.")
            assert(num_defined([chamfer2,rounding2])<2, "\nCannot define both chamfer2 and rounding2.")
            assert(num_defined([chamfer,rounding])<2, "\nCannot define both chamfer and rounding.")
            assert(is_finite(clip_angle) && clip_angle>=-vang && clip_angle<=90,
                   str("\nclip_angle must less than 90 and more than the base angle from vertical (",-vang,")"))
            undef,
        unscale = noscale ? scale : 1, 
        chamf1r = !_chamf1? 0
                : !_fromend1? unscale * _chamf1
                : unscale * law_of_sines(a=_chamf1, A=chang1, B=180-chang1-(90-sign(_chamf2)*vang)),
        chamf2r = !_chamf2? 0
                : !_fromend2? unscale * _chamf2
                : unscale * law_of_sines(a=_chamf2, A=chang2, B=180-chang2-(90+sign(_chamf2)*vang)),
        chamf1l = !_chamf1? 0
                : _fromend1? abs(_chamf1)
                : abs(law_of_sines(a=_chamf1, A=180-chang1-(90-sign(_chamf1)*vang), B=chang1)),
        chamf2l = !_chamf2? 0
                : _fromend2? abs(_chamf2)
                : abs(law_of_sines(a=_chamf2, A=180-chang2-(90+sign(_chamf2)*vang), B=chang2)),
        td_ang = teardrop == true? 45
               : teardrop == false? 90
               : assert(is_finite(teardrop))
                 assert(teardrop>=0 && teardrop<=90)
                 teardrop,
        roundlen1 = round1 >= 0 ? round1/tan(45-vang/2)
                                : round1/tan(45+vang/2),
        roundlen2 = round2 >=0 ? round2/tan(45+vang/2)
                               : round2/tan(45-vang/2),
        dy1 = abs(_chamf1 ? chamf1l : round1 ? roundlen1*sin(clip_angle) : 0), 
        dy2 = abs(_chamf2 ? chamf2l : round2 ? roundlen2 : 0)
    ) 
    assert(is_finite(round1), "\nrounding1 must be a number if given.")
    assert(is_finite(round2), "\nrounding2 must be a number if given.")
    assert(chamf1r/scale <= r1, "\nchamfer1 is larger than the r1 radius of the cylinder.")
    assert(chamf2r/scale <= r2, "\nchamfer2 is larger than the r2 radius of the cylinder.")
    assert(td_ang==90 || clip_angle==90, "\nteardrop= and clip_angle= are mutually exclusive options.")
    let(
        bottom = !approx(chamf1r,0) ?
                     [
                      [r1-chamf1r/scale, -l/2], // + [-chamf1r/scale,0],//polar_to_xy(chamf1r,180)),
                      [r1, -l/2] + xscale(1/scale,polar_to_xy(chamf1l,90+vang)),
                     ]
               : !approx(round1,0) && td_ang < 90 ?
                     xscale(1/scale,_teardrop_corner(r=round1*unscale, corner=[[r1*scale-2*roundlen1,-l/2],[r1*scale,-l/2],[r2*scale,l/2]], ang=td_ang))
               : !approx(round1,0) && clip_angle < 90 ?
                     xscale(1/scale,_clipped_corner(r=round1*unscale, corner=[[r1*scale-2*roundlen1,-l/2],[r1*scale,-l/2],[r2*scale,l/2]], ang=clip_angle))
               : !approx(round1,0) && clip_angle > -vang ? 
                     xscale(1/scale,arc(r=abs(round1*unscale), corner=[[r1*scale-2*roundlen1,-l/2],[r1*scale,-l/2],[r2*scale,l/2]]))
               : [[r1,-l/2]],
        top = !approx(chamf2r,0) ?
                     [
                      [r2, l/2] + xscale(1/scale,polar_to_xy(chamf2l,270+vang)),
                      [r2-chamf2r/scale, l/2]
                     ]
            : !approx(round2,0) ?
                     xscale(1/scale,arc(r=abs(round2*unscale), corner=[[r1*scale,-l/2],[r2*scale,l/2],[r2*scale-2*roundlen2,l/2]]))
            : [[r2,l/2]]
    )
    assert(bottom[0].x>=0, str("\nHorizontal size of rounding1 is larger (by ",-bottom[0].x,") than the r1 radius of the cylinder."))
    assert(last(bottom).y<=top[0].y, str("Chamfers/roundings don't fit on the cylinder. Together they exceed the cylinder height by ",last(bottom).y-top[0].y))
    assert(last(top).x>=0, str("\nSize of rounding2 is larger (by ",-last(top).x,") than the r2 radius of the cylinder."))
    deduplicate(concat(bottom,top));

function cyl(
    h, r, r2, center,
    l, r1, 
    d, d1, d2,
    length, height,
    chamfer, chamfer1, chamfer2,
    chamfang, chamfang1, chamfang2,
    rounding, rounding1, rounding2,
    circum=false, realign, shift=[0,0],
    teardrop=false, clip_angle=90,
    from_end, from_end1, from_end2,
    texture, tex_size=[5,5], tex_reps, tex_counts,
    tex_inset=false, tex_rot=0,
    tex_scale, tex_depth, tex_samples, 
    tex_taper, style, tex_style,
    extra, extra1, extra2, 
    anchor, spin=0, orient=UP
) =
    let(
        legacy = is_bool(r2) && is_undef(center),
        edummy = !legacy?0:
          echo("You gave a boolean value for r2.  Assuming you gave this value as the 3rd positional parameter.")
          echo("cyl() has changed and has parameters (height, r, r2, center) for improved consistency with")
          echo("cylinder().  Support for the legacy calling style cyl(height, r, center) will be eliminated")
          echo("and this will become an error."),
        center = legacy ? r2 : center
    )
    assert(is_bool(circum))
    assert(is_undef(center) || is_bool(center), "\ncenter must be boolean.")
    assert(num_defined([center,anchor])<2, "\nCannot give both center and anchor")
    assert(num_defined([style,tex_style])<2, "\nIn cyl() the 'tex_style' parameter has been replaced by 'style'. You cannot give both.")
    assert(num_defined([tex_reps,tex_counts])<2, "\nIn cyl() the 'tex_counts' parameter has been replaced by 'tex_reps'. You cannot give both.")    
    assert(num_defined([tex_scale,tex_depth])<2, "\nIn cyl() the 'tex_scale' parameter has been replaced by 'tex_depth'. You cannot give both.")
    let(
        realign = default(realign,circum),
        style = is_def(tex_style)? echo("In cyl() the 'tex_style' parameter is deprecated and has been replaced by 'style'")tex_style
              : default(style,"min_edge"),
        tex_reps = is_def(tex_counts)? echo("In cyl() the 'tex_counts' parameter is deprecated and has been replaced by 'tex_reps'")tex_counts
                 : tex_reps,
        tex_depth = is_def(tex_scale)? echo("In cyl() the 'tex_scale' parameter is deprecated and has been replaced by 'tex_depth'")tex_scale
                  : default(tex_depth,1),
        l = one_defined([l, h, length, height],"l,h,length,height",dflt=1),
        _r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1),
        _r2 = get_radius(r1=legacy ? undef : r2, r=r, d1=d2, d=d, dflt=1),
        sides = segs(max(_r1,_r2)),
        sc = circum? 1/cos(180/sides) : 1,
        r1 = _r1 * sc,
        r2 = _r2 * sc,
        anchor = get_anchor(anchor,center,BOT,CENTER),
        extra1 = first_defined([extra1,extra,0]),
        extra2 = first_defined([extra2,extra,0])
    )
    assert(is_bool(realign))
    assert(all_nonnegative([extra1,extra2]), "\nextra/extra1/extra2 must be positive.")
    assert(is_finite(l), "\nl/h/length/height must be a finite number.")
    assert(is_finite(r1) && r1>=0, "\nr/r1/d/d1 must be a non-negative number.")
    assert(is_finite(r2) && r2>=0, "\nr2 or d2 must be a non-negative number.")
    assert(is_vector(shift,2), "\nshift must be a 2D vector.")
    let(
        vnf = !any_defined([chamfer, chamfer1, chamfer2, rounding, rounding1, rounding2, texture, extra1, extra2])
          ? zrot(circum?180/sides/2:0,cylinder(h=l+extra1+extra2, r1=r1, r2=r2, center=true, $fn=sides))
          : let(
                 cpath = _cyl_path(r1, r2, l, 
                                   chamfer, chamfer1, chamfer2,
                                   chamfang, chamfang1, chamfang2,
                                   rounding, rounding1, rounding2,
                                   from_end, from_end1, from_end2,
                                   teardrop, clip_angle, sides, !circum),
                 path = [
                          if (texture==undef) [0,-l/2-extra1],
                          if (extra1>0) cpath[0]-[0,extra1],
                          each cpath,
                          if (extra2>0) last(cpath)+[0,extra2],
                          if (texture==undef) [0,l/2+extra2]
                        ]
            ) rotate_sweep(path,
                texture=texture, tex_reps=tex_reps, tex_size=tex_size,
                tex_inset=tex_inset, tex_rot=tex_rot,
                tex_depth=tex_depth, tex_samples=tex_samples,
                tex_taper=tex_taper, style=style, caps=true, 
                _tex_inhibit_y_slicing=true
            ),
        skmat = down(l/2) *
            skew(sxz=shift.x/l, syz=shift.y/l) *
            up(l/2) *
            zrot(realign? 180/sides : 0),
        ovnf = apply(skmat, vnf)
    )
    reorient(anchor,spin,orient, r1=r1, r2=r2, l=l, shift=shift, p=ovnf);

function _teardrop_corner(r, corner, ang=45) =
    let(
        check = assert(len(corner)==3)
            assert(is_finite(r))
            assert(is_finite(ang)),
        cp = circle_2tangents(abs(r), corner)[0],
        pvec = rot(sign(r)*90,p=corner[0]-corner[1]),
        path1 = arc(r=abs(r), corner=corner),
        path2 = [
            for (p = select(path1,0,-2))
                if (vector_angle(p-cp, pvec) > ang) p,
            last(path1)
        ],
        path = [
            line_intersection([corner[0],corner[1]],[path2[0],path2[0]+polar_to_xy(1,270-(90-ang)*sign(r))]),
            each path2
        ]
    ) path;

function _clipped_corner(r, corner, ang=45) =
    let(
        check = assert(len(corner)==3)
            assert(is_finite(r))
            assert(is_finite(ang)),
        vec1 = unit(corner[0] - corner[1]),
        vec2 = unit(corner[2] - corner[1]),
        off = r * (1-cos(90-ang)) * rot(90, p=vec1),
        line1 = [corner[0], corner[1]] + [off, off],
        line2 = [corner[1], corner[2]],
        corn_pt = line_intersection(line1,line2),
        cp = circle_2tangents(abs(r), [line1[0],corn_pt,line2[1]])[0],
        vec3 = rot(sign(r)*(180-ang), p=vec1),
        vec4 = rot(-sign(r)*90, p=vec2),
        dang = vector_angle(vec3,vec4),
        path = arc(r=abs(r), cp=cp, start=v_theta(vec3), angle=sign(r)*dang)
    ) path;

module cyl(
    h, r, r2, center,
    l, r1, 
    d, d1, d2,
    length, height,
    chamfer, chamfer1, chamfer2,
    chamfang, chamfang1, chamfang2,
    rounding, rounding1, rounding2,
    circum=false, realign, shift=[0,0],
    teardrop=false, clip_angle=90,
    from_end, from_end1, from_end2,
    texture, tex_size=[5,5], tex_reps, tex_counts,
    tex_inset=false, tex_rot=0,
    tex_scale, tex_depth, tex_samples, 
    tex_taper, style, tex_style,
    extra, extra1, extra2, 
    anchor, spin=0, orient=UP
) {
    legacy = is_bool(r2) && is_undef(center);
    edummy = !legacy?0:
      echo("You gave a boolean value for r2.  Assuming you gave this value as the 3rd positional parameter.")
      echo("cyl() has changed and has parameters (height, r, r2, center) for improved consistency with")
      echo("cylinder().  Support for the legacy calling style cyl(height, r, center) will be eliminated")
      echo("and this will become an error.");
    center = legacy ? r2 : center;
    realign = assert(is_bool(circum))
              default(realign,circum);
    dummy=
      assert(is_bool(realign))
      assert(num_defined([anchor,center])<2, "\nCannot give both `anchor` and `center` to cyl()")
      assert(is_undef(center) || is_bool(center), "\ncenter must be boolean")
      assert(num_defined([style,tex_style])<2, "\nIn cyl() the 'tex_style' parameters has been replaced by 'style'. You cannot give both.")
      assert(num_defined([tex_reps,tex_counts])<2, "\nIn cyl() the 'tex_counts' parameters has been replaced by 'tex_reps'. You cannot give both.")
      assert(num_defined([tex_scale,tex_depth])<2, "\nIn cyl() the 'tex_scale' parameter has been replaced by 'tex_depth'. You cannot give both.");
    style = is_def(tex_style)? echo("In cyl() the 'tex_style' parameter is deprecated and has been replaced by 'style'.") tex_style
          : default(style,"min_edge");
    tex_reps = is_def(tex_counts)? echo("In cyl() the 'tex_counts' parameter is deprecated and has been replaced by 'tex_reps'.")tex_counts
             : tex_reps;
    tex_depth = is_def(tex_scale)? echo("In rotate_sweep() the 'tex_scale' parameter is deprecated and has been replaced by 'tex_depth'.")tex_scale
              : default(tex_depth,1);
    l = one_defined([l, h, length, height],"l,h,length,height",dflt=1);
    _r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1);
    _r2 = get_radius(r1=legacy ? undef : r2, r=r, d1=d2, d=d, dflt=1);
    sides = segs(max(_r1,_r2));
    sc = circum? 1/cos(180/sides) : 1;
    r1 = _r1 * sc;
    r2 = _r2 * sc;
    anchor = get_anchor(anchor,center,BOT,CENTER);
    skmat = down(l/2) * skew(sxz=shift.x/l, syz=shift.y/l) * up(l/2);
    attachable(anchor,spin,orient, r1=r1, r2=r2, l=l, shift=shift) {
        multmatrix__1(skmat) {
            if (!any_defined([chamfer, chamfer1, chamfer2, rounding, rounding1, rounding2, texture, extra1, extra2, extra])) {
                zrot(realign? 180/sides : 0) {
                    cylinder__1(h=l, r1=r1, r2=r2, center=true, $fn=sides);
                }
            } else {
                vnf = cyl(
                    l=l, r1=_r1, r2=_r2, center=true,  circum=circum, realign=realign,
                    chamfer=chamfer, chamfer1=chamfer1, chamfer2=chamfer2,
                    chamfang=chamfang, chamfang1=chamfang1, chamfang2=chamfang2,
                    rounding=rounding, rounding1=rounding1, rounding2=rounding2,
                    from_end=from_end, from_end1=from_end1, from_end2=from_end2,
                    teardrop=teardrop, clip_angle=clip_angle,
                    texture=texture, tex_size=tex_size,
                    tex_reps=tex_reps, tex_depth=tex_depth,
                    tex_inset=tex_inset, tex_rot=tex_rot,
                    style=style, tex_taper=tex_taper,
                    tex_samples=tex_samples,
                    extra1=extra1,extra2=extra2,extra=extra 
                );
                vnf_polyhedron(vnf, convexity=texture!=undef? 2 : 10);
            }
        }
        children();
    }
}

module xcyl(
    h, r, center,
    l, r1, r2,
    d, d1, d2,
    length, height,
    chamfer, chamfer1, chamfer2,
    chamfang, chamfang1, chamfang2,
    rounding, rounding1, rounding2,
    circum=false, realign, shift=[0,0],
    teardrop=false, clip_angle=90,
    from_end, from_end1, from_end2,
    texture, tex_size=[5,5], tex_reps, tex_counts,
    tex_inset=false, tex_rot=0,
    tex_scale, tex_depth, tex_samples,
    tex_taper, style, tex_style,
    extra, extra1, extra2, 
    anchor=CENTER, spin=0
) {
    r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1);
    r2 = get_radius(r1=r2, r=r, d1=d2, d=d, dflt=1);
    l = one_defined([l,h,length,height],"l,h,length,height",1);
    attachable(anchor,spin,orient=UP, r1=r1, r2=r2, l=l, axis=RIGHT) {
        cyl(
            center=center,
            l=l, r1=r1, r2=r2,
            chamfer=chamfer, chamfer1=chamfer1, chamfer2=chamfer2,
            chamfang=chamfang, chamfang1=chamfang1, chamfang2=chamfang2,
            rounding=rounding, rounding1=rounding1, rounding2=rounding2,
            circum=circum, realign=realign, shift=shift,
            teardrop=teardrop, clip_angle=clip_angle,
            from_end=from_end, from_end1=from_end1, from_end2=from_end2,
            texture=texture, tex_size=tex_size, tex_reps=tex_reps, tex_counts=tex_counts,
            tex_inset=tex_inset, tex_rot=tex_rot,
            tex_scale=tex_scale, tex_depth=tex_depth, tex_samples=tex_samples,
            tex_taper=tex_taper, style=style, tex_style=tex_style,
            extra=extra, extra1=extra1, extra2=extra2, 
            anchor=CENTER, spin=0, orient=RIGHT
        );
        children();
    }
}

module ycyl(
    h, r, center,
    l, r1, r2,
    d, d1, d2,
    length, height,
    chamfer, chamfer1, chamfer2,
    chamfang, chamfang1, chamfang2,
    rounding, rounding1, rounding2,
    circum=false, realign, shift=[0,0],
    teardrop=false, clip_angle=90,
    from_end, from_end1, from_end2,
    texture, tex_size=[5,5], tex_reps, tex_counts,
    tex_inset=false, tex_rot=0,
    tex_scale, tex_depth, tex_samples,
    tex_taper, style, tex_style,
    extra, extra1, extra2, 
    anchor, spin=0
) {
    r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1);
    r2 = get_radius(r1=r2, r=r, d1=d2, d=d, dflt=1);
    l = one_defined([l,h,length,height],"l,h,length,height",1);
    attachable(anchor,spin,orient=UP, r1=r1, r2=r2, l=l, axis=BACK) {
        cyl(
            center=center,
            l=l, r1=r1, r2=r2,
            chamfer=chamfer, chamfer1=chamfer1, chamfer2=chamfer2,
            chamfang=chamfang, chamfang1=chamfang1, chamfang2=chamfang2,
            rounding=rounding, rounding1=rounding1, rounding2=rounding2,
            circum=circum, realign=realign, shift=shift,
            teardrop=teardrop, clip_angle=clip_angle,
            from_end=from_end, from_end1=from_end1, from_end2=from_end2,
            texture=texture, tex_size=tex_size, tex_reps=tex_reps, tex_counts=tex_counts,
            tex_inset=tex_inset, tex_rot=tex_rot,
            tex_scale=tex_scale, tex_depth=tex_depth, tex_samples=tex_samples,
            tex_taper=tex_taper, style=style, tex_style=tex_style,
            extra=extra, extra1=extra1, extra2=extra2, 
            anchor=CENTER, spin=0, orient=BACK
        );
        children();
    }
}

module zcyl(
    h, r, center,
    l, r1, r2,
    d, d1, d2,
    chamfer, chamfer1, chamfer2,
    chamfang, chamfang1, chamfang2,
    rounding, rounding1, rounding2,
    circum=false, realign, shift=[0,0],
    teardrop=false, clip_angle=90,
    from_end, from_end1, from_end2,
    texture, tex_size=[5,5], tex_reps, tex_counts,
    tex_inset=false, tex_rot=0,
    tex_scale, tex_depth, tex_samples, length, height, 
    tex_taper, style, tex_style,
    extra, extra1, extra2, 
    anchor, spin=0
) {
    r1 = get_radius(r1=r1, r=r, d1=d1, d=d, dflt=1);
    r2 = get_radius(r1=r2, r=r, d1=d2, d=d, dflt=1);
    l = one_defined([l,h,length,height],"l,h,length,height",1);
    attachable(anchor,spin,orient=UP, r1=r1, r2=r2, l=l) {
        cyl(
            center=center,
            l=l, r1=r1, r2=r2,
            chamfer=chamfer, chamfer1=chamfer1, chamfer2=chamfer2,
            chamfang=chamfang, chamfang1=chamfang1, chamfang2=chamfang2,
            rounding=rounding, rounding1=rounding1, rounding2=rounding2,
            circum=circum, realign=realign, shift=shift,
            teardrop=teardrop, clip_angle=clip_angle,
            from_end=from_end, from_end1=from_end1, from_end2=from_end2,
            texture=texture, tex_size=tex_size, tex_reps=tex_reps, tex_counts=tex_counts,
            tex_inset=tex_inset, tex_rot=tex_rot,
            tex_scale=tex_scale, tex_depth=tex_depth, tex_samples=tex_samples,
            tex_taper=tex_taper, style=style, tex_style=tex_style,
            extra=extra, extra1=extra1, extra2=extra2, 
            anchor=CENTER, spin=0, orient=UP
        );
        children();
    }
}

// Function&Module: spheroid()
// Synopsis: Creates an attachable spherical object with controllable triangulation.
// SynTags: Geom, VNF
// Topics: Shapes (3D), Attachable, VNF Generators
// See Also: sphere()
// Usage: Typical
//   spheroid(r|d, [circum], [style]) [ATTACHMENTS];
// Usage: As Function
//   vnf = spheroid(r|d, [circum], [style]);
// Description:
//   Creates a spheroid object, with support for anchoring and attachments.
//   This is a drop-in replacement for the built-in `sphere()` module.  The `r` or `d` value can
//   be a 3-vector to produce an ellipsoid.  This differs from scaling the ellipsoid manually because
//   it doesn't rescale children that you attach to the ellipsoid.
//   . 
//   When called as a function, returns a [VNF](vnf.scad) for a spheroid.
//   The exact triangulation of this spheroid can be controlled via the `style=`
//   argument, where the value can be one of `"orig"`, `"aligned"`, `"stagger"`,
//   `"octa"`, or `"icosa"`.
//   - `style="orig"` constructs a sphere the same way that the OpenSCAD `sphere()` built-in does.
//   - `style="aligned"` constructs a sphere where, if `$fn` is a multiple of 4, it has vertices at all axis maxima and minima.  ie: its bounding box is exactly the sphere diameter in length on all three axes.  This is the default.
//   - `style="stagger"` forms a sphere where all faces are triangular, but the top and bottom poles have thinner triangles.
//   - `style="octa"` forms a sphere by subdividing an octahedron.  This makes more uniform faces over the entirety of the sphere, and guarantees the bounding box is the sphere diameter in size on all axes.  The effective `$fn` value is quantized to a multiple of 4.  This is used in constructing rounded corners for various other shapes.
//   - `style="icosa"` forms a sphere by subdividing an icosahedron.  This makes even more uniform faces over the whole sphere.  The effective `$fn` value is quantized to a multiple of 5.  This sphere has a guaranteed bounding box when `$fn` is a multiple of 10.
//   .
//   By default the object spheroid() produces is a polyhedron whose vertices all lie on the requested sphere.  This means
//   the approximating polyhedron is inscribed in the sphere.
//   The `circum` argument requests a circumscribing sphere, where the true sphere is
//   inside and tangent to all the faces of the approximating polyhedron.  To produce
//   a circumscribing polyhedron, we use the dual polyhedron of the basic form.  The dual of a polyhedron is
//   a new polyhedron whose vertices are obtained from the faces of the parent polyhedron.
//   The "orig" and "align" forms are duals of each other.  If you request a circumscribing polyhedron in
//   these styles then the polyhedron looks the same as the default inscribing form.  But for the other
//   styles, the duals are completely different from their parents, and from each other.  Generation of the circumscribed versions (duals)
//   for "octa" and "icosa" is fast if you use the module form but can be slow (several minutes) if you use the functional
//   form and choose a large $fn value.
//   .
//   With style="align", the circumscribed sphere has its maximum radius on the X and Y axes
//   but is undersized on the Z axis.  With style="octa" the circumscribed sphere has faces at each axis, so
//   the radius on the axes is equal to the specified radius, which is the *minimum* radius of the circumscribed sphere.
//   The same thing is true for style="icosa" when $fn is a multiple of 10. This enables you to create spherical
//   holes with guaranteed on-axis dimensions.
//   .
//   The "octa" style has the property that it blends neatly with a cylinder of the same $fn along any of the coordinate axes.
//   This is true for both the regular and circumscribed "octa" spheroid.  
// Arguments:
//   r = Radius of the spheroid or 3-vector giving the 3 semiaxes.
//   style = The style of the spheroid's construction. One of "orig", "aligned", "stagger", "octa", or "icosa".  Default: "aligned"
//   ---
//   d = Diameter of the spheroid or 3-vector giving three axes lengths.
//   circum = If true, the approximate sphere circumscribes the true sphere of the requested size.  Otherwise inscribes.  Note that for some styles, the circumscribed sphere looks different than the inscribed sphere.  Default: false (inscribes)
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
// Example: By Radius
//   spheroid(r=50);
// Example: By Diameter
//   spheroid(d=100);
// Example: style="orig"
//   spheroid(d=100, style="orig", $fn=10);
// Example: style="aligned"
//   spheroid(d=100, style="aligned", $fn=10);
// Example: style="stagger"
//   spheroid(d=100, style="stagger", $fn=10);
// Example: style="stagger" with circum=true
//   spheroid(d=100, style="stagger", circum=true, $fn=10);
// Example: style="octa", octahedral based tesselation.  In this style, $fn is quantized to a multiple of 4.
//   spheroid(d=100, style="octa", $fn=10);
// Example: style="octa", with circum=true, produces mostly irregular hexagonal faces
//   spheroid(d=100, style="octa", circum=true, $fn=16);
// Example: style="icosa", icosahedral based tesselation.  In this style, $fn is quantized to a multiple of 5.
//   spheroid(d=100, style="icosa", $fn=10);
// Example: style="icosa", circum=true.  This style has hexagons and 12 pentagons, similar to (but not the same as) a soccer ball.
//   spheroid(d=100, style="icosa", circum=true, $fn=10);
// Example: Joining "octa" style spheroid to a x-aligned cylinder
//   $fn=16;
//   spheroid(r=10, style="octa");
//   xcyl(r=10, h=15, anchor=RIGHT);
// Example: Joining "octa" style spheroid to a x-aligned cylinder with `circum=true`.  Here the sphere is green and the cylinder a tiny bit oversized to prevent z-fighting where the faces of the cylinder and sphere overlap.  
//   $fn=16;
//   color("lightblue")spheroid(r=10, style="octa", circum=true);
//   xcyl(r=10.01, h=15, anchor=RIGHT, circum=true);
// Example: Ellipsoid
//   spheroid(r=[100,50,35]);
// Example: Anchoring
//   spheroid(d=100, anchor=FRONT);
// Example: Spin
//   spheroid(d=100, anchor=FRONT, spin=45);
// Example: Orientation
//   spheroid(d=100, anchor=FRONT, spin=45, orient=FWD);
// Example: Standard Connectors
//   spheroid(d=50) show_anchors();
// Example: Called as Function
//   vnf = spheroid(d=100, style="icosa");
//   vnf_polyhedron(vnf);
// Example: With "orig" the circumscribing sphere has the same form.  The green sphere has a very high `$fn` so it is very close to spherical, and it is a tiny bit oversized so it pokes through the low points in the circumscribed sphere with low `$fn`.  An equal sized green dot in the middle of every face demonstrates that these spheres are in fact circumscribing.
//   color("green")spheroid(r=10.01, $fn=256);
//   spheroid(r=10, style="orig", circum=true, $fn=16);
// Example: With "aligned" the same is true: the circumscribing sphere is also aligned, if $fn is divisible by 4.
//   color("green")spheroid(r=10.01, $fn=256);
//   spheroid(r=10, style="aligned", circum=true, $fn=16);
// Example: For the other styles, the circumscribing sphere is different, as shown here with "stagger"
//   color("green")spheroid(r=10.01, $fn=256);
//   spheroid(r=10, style="stagger", circum=true, $fn=16);
// Example: The dual of "octa" that provides the circumscribing sphere has weird asymmetric hexagonal faces:
//   color("green")spheroid(r=10.01, $fn=256);
//   spheroid(r=10, style="octa", circum=true, $fn=16);
// Example: The dual of "icosa" features hexagons and always 12 pentagons:
//   color("green")spheroid(r=10.01, $fn=256);
//   spheroid(r=10, style="icosa", circum=true, $fn=16);
module spheroid(r, style="aligned", d, circum=false, dual=false, anchor=CENTER, spin=0, orient=UP)
{
    r = get_radius(r=r, d=d, dflt=1);
    assert((is_finite(r) && r>=0) || (is_vector(r,3) && all_positive(r)),"\nr/d must be a nonnegative value or a positive 3-vector");
    attachable(anchor,spin,orient, r=r) {
        if (style=="orig" && !circum) {
            sides = segs(min(r));
            vsides = ceil(sides/2);
            merids = [ for (i=[0:1:vsides-1]) 90-(i+0.5)*180/vsides ];
            path = [
                let(a = merids[0]) [0, sin(a)],
                for (a=merids) [cos(a), sin(a)],
                let(a = last(merids)) [0, sin(a)]
            ];
            scale__1(r) rotate__1(180) rotate_extrude(convexity=2,$fn=sides) polygon(path);
        }
        // Don't now how to construct faces for these efficiently, so use hull_points, which
        // is much faster than using hull() as happens in the spheroid() function
        else if (circum && (style=="octa" || style=="icosa")) {
            minr = min(r);
            scale = r/minr;
            orig_sphere = spheroid(minr,style,circum=false);
            dualvert = _dual_vertices(orig_sphere);
            hull_points(scale(scale,dualvert),fast=true);
        } else {
            vnf = spheroid(r=r, circum=circum, style=style);
            vnf_polyhedron(vnf, convexity=2);
        }
        children();
    }
}

// p is a list of 3 points defining a triangle in any dimension.  N is the number of extra points
// to add, so output triangle has N+2 points on each side.
function _subsample_triangle(p,N) =
    [for(i=[0:N+1]) [for (j=[0:N+1-i]) unit(lerp(p[0],p[1],i/(N+1)) + (p[2]-p[0])*j/(N+1))]];

// Input should have only triangular faces
function _dual_vertices(vnf) =
  let(vert=vnf[0])
  [for(face=vnf[1])
      let(planes = select(vert,face))
      //linear_solve3(planes, [for(p=planes) p*p])
      linear_solve3(select(planes,0,2), [for(i=[0:2]) planes[i]*planes[i]]) // Handle larger faces, maybe?
  ];

function _vector_planes_intersection(A, B, C, D) =
    let(
        // Normal vectors to the planes containing each great circle
        n1 = cross(A, B),
        n2 = cross(C, D),

        // The intersection line direction
        line_dir = cross(n1, n2),
        line_len = norm(line_dir),

        // Normalize to get point on unit sphere
        isect = line_dir / line_len
    )
    isect;

function _make_octa_sphere(r) =
let(
    // Get number of triangles on each side of each octants.
    subdivs = quantup(segs(r),4)/4,

    pts = [
        for (row = [subdivs:-1:0]) [
            for (col = [0:1:subdivs-row])
            let(
                // row corresponds to x index, col to y index
                z_idx = row,
                y_idx = col,
                x_idx = subdivs - row - col,

                yu = 90 * y_idx / subdivs,
                zu = 90 * z_idx / subdivs,

                ycos = cos(yu),
                ysin = sin(yu),
                zcos = cos(zu),
                zsin = sin(zu),

                // Special cases: edges
                pt = (x_idx == 0) ? [0, zcos, zsin] :  // Y-Z edge
                     (y_idx == 0) ? [zcos, 0, zsin] :  // X-Z edge
                     (z_idx == 0) ? [ycos, ysin, 0] :  // X-Y edge

                     // Interior points
                     let(
                         yu2 = 90 - yu,
                         xu2 = 90 * (subdivs - x_idx) / subdivs,

                         ysin2 = sin(yu2),
                         ycos2 = cos(yu2),
                         xsin2 = sin(xu2),
                         xcos2 = cos(xu2),

                         // For the arc with constant z-ratio (in the "z-plane")
                         // This arc goes from the X-Z edge to the Y-Z edge
                         // At the X-Z edge (y=0), we have the point at z_idx
                         xz_edge_pt = [zcos, 0, zsin],
                         // At the Y-Z edge (x=0), we have the point at z_idx
                         yz_edge_pt = [0, zcos, zsin],

                         // For the arc with constant y-ratio (in the "y-plane")
                         // This arc goes from the X-Y edge to the Y-Z edge
                         // At the X-Y edge (z=0), we have the point at y_idx
                         xy_edge_pt = [ycos, ysin, 0],
                         // At the Y-Z edge (x=0), we have the point at y_idx
                         yz_edge_pt2 = [0, ycos2, ysin2],

                         // For the arc with constant x-ratio (in the "x-plane")
                         // This arc goes from the X-Y edge to the X-Z edge
                         // At the X-Y edge (z=0), we have the point at x_idx
                         xy_edge_pt2 = [xcos2, xsin2, 0],
                         // At the X-Z edge (y=0), we have the point at x_idx
                         xz_edge_pt2 = [xcos2, 0, xsin2],

                         // Find all three intersections
                         int_z_y = _vector_planes_intersection(xz_edge_pt, yz_edge_pt, xy_edge_pt, yz_edge_pt2),
                         int_z_x = _vector_planes_intersection(xz_edge_pt, yz_edge_pt, xy_edge_pt2, xz_edge_pt2),
                         int_y_x = _vector_planes_intersection(xy_edge_pt, yz_edge_pt2, xy_edge_pt2, xz_edge_pt2),

                         // Average and normalize
                         isect = unit(int_z_y + int_z_x + int_y_x)
                     )
                     isect
            )
            pt
        ]
    ] * r,
    rows = [
        [ pts[0][0] ],

        for (row = [1:1:subdivs]) [
            for (a = [0:90:359])
            each zrot(a, p=select(pts[row], [0:1:row-1]))
        ],

        for (row = [subdivs-1:-1:1]) [
            for (a = [0:90:359])
            each zrot(a, p=zflip(p=select(pts[row], [0:1:row-1])))
        ],

        [ zflip(p=pts[0][0]) ]
    ],
    verts = flatten(rows),
    offsets = cumsum([0, for (row = rows) len(row)]),
    faces = [
        for (i = [0:1:len(rows[1])-1])
            let(
                l1 = len(rows[1]),
                o1 = offsets[1]
            )
            [i+o1, 0, (i+1)%l1+o1],

        for (j = [1:1:subdivs-1])
            let(
                l1 = len(rows[j]),
                l2 = len(rows[j+1]),
                o1 = offsets[j],
                o2 = offsets[j+1],
                q1 = len(rows[j])/4,
                q2 = len(rows[j+1])/4
            )
            for (n = [0:1:3])
                each [
                    [o2+q2*n, o1+q1*n, o2+(q2*n+1)%l2],
                    for (i = [0:1:q1-1]) each [
                        [o2+(i+q2*n+1)%l2, o1+(i+q1*n+1)%l1, o2+(i+q2*n+2)%l2],
                        [o2+(i+q2*n+1)%l2, o1+(i+q1*n)%l1, o1+(i+q1*n+1)%l1]
                    ]
                ],

        for (j = [subdivs:1:2*subdivs-2])
            let(
                l1 = len(rows[j]),
                l2 = len(rows[j+1]),
                o1 = offsets[j],
                o2 = offsets[j+1],
                q1 = len(rows[j])/4,
                q2 = len(rows[j+1])/4
            )
            for (n = [0:1:3])
                each [
                    [o2+q2*n, o1+q1*n, o1+(q1*n+1)%l1],
                    for (i = [0:1:q1-2]) each [
                        [o2+(i+q2*n)%l2, o1+(i+q1*n+1)%l1, o2+(i+q2*n+1)%l2],
                        [o1+(i+q1*n+2)%l1, o2+(i+q2*n+1)%l2, o1+(i+q1*n+1)%l1]
                    ]
                ],

        for (i = [0:1:3])
            let(
                row = len(rows) -2,
                l1 = len(rows[row]),
                o1 = offsets[row],
                o2 = offsets[row+1]
            )
            [o2, o1+i, o1+(i+1)%l1]
    ]
) [verts, faces];

function spheroid(r, style="aligned", d, circum=false, anchor=CENTER, spin=0, orient=UP) =
    assert(in_list(style, ["orig", "aligned", "stagger", "octa", "icosa"]))
    let(
        r = get_radius(r=r, d=d, dflt=1)
    )
    is_vector(r,3) ? let(
                         minr = min(r),
                         scale = r/minr
                     )
                     scale(scale,spheroid(minr, style=style, circum=circum, anchor=anchor,
                                          spin=spin, orient=orient))
  : let(
        hsides = segs(min(r)),
        vsides = max(2,ceil(hsides/2)),
        icosa_steps = round(max(5,hsides)/5),
        stagger = style=="stagger"
     )
     circum && style=="orig" ?
         let(
              orig_sphere = spheroid(r,"aligned",circum=false),
              dualvert = zrot(360/hsides/2,_dual_vertices(orig_sphere)),
              culledvert = [
                              [for(i=[0:2:2*hsides-1]) dualvert[i]],
                              for(j=[1:vsides-2])
                                 [for(i=[0:2:2*hsides-1]) dualvert[j*2*hsides+i]],
                              [for(i=[1:2:2*hsides-1]) dualvert[i]]
                           ],
              vnf = vnf_vertex_array(culledvert,col_wrap=true,caps=true)
          )
          [reorient(anchor,spin,orient, r=r, p=vnf[0]), vnf[1]]
     :
     circum && (style=="octa" || style=="icosa") ?
         let(
              orig_sphere = spheroid(r,style,circum=false),
              dualvert = _dual_vertices(orig_sphere),
              faces = hull(dualvert)
         )
         [reorient(anchor,spin,orient, r=r, p=dualvert), faces]
     :
     style=="octa" ?
         let( vnf = _make_octa_sphere(r) )
         reorient(anchor,spin,orient, r=r, p=vnf)
     :
     style=="icosa" ?    // subdivide faces of an icosahedron and project them onto a sphere
         let(
             N = icosa_steps-1,
             // construct an icosahedron
             icovert=[ for(i=[-1,1], j=[-1,1]) each [[0,i,j*PHI], [i,j*PHI,0], [j*PHI,0,i]]],
             icoface = hull(icovert),
             // Subsample face 0 of the icosahedron
             face0 = select(icovert,icoface[0]),
             sampled = r * _subsample_triangle(face0,N),
             dir0 = mean(face0),
             point0 = face0[0]-dir0,
             // Make a rotated copy of the subsampled triangle on each icosahedral face
             tri_list = [sampled,
                         for(i=[1:1:len(icoface)-1])
                 let(face = select(icovert,icoface[i]))
                 apply(frame_map(z=mean(face),x=face[0]-mean(face))
                        *frame_map(z=dir0,x=point0,reverse=true),
                       sampled)],
             // faces for the first triangle group
             faces = vnf_tri_array(tri_list[0],reverse=true)[1],
             size = repeat((N+2)*(N+3)/2,3),
             // Expand to full face list
             fullfaces = [for(i=idx(tri_list)) each [for(f=faces) f+i*size]],
             fullvert = flatten(flatten(tri_list))    // eliminate triangle structure
         )
         [reorient(anchor,spin,orient, r=r, p=fullvert), fullfaces]
     :
     let(
        verts = circum && style=="stagger" ? _dual_vertices(spheroid(r,style,circum=false))
              : circum && style=="aligned" ?
                     let(
                         orig_sphere = spheroid(r,"orig",circum=false),
                         dualvert = _dual_vertices(orig_sphere),
                         culledvert = zrot(360/hsides/2,
                                           [dualvert[0],
                                            for(i=[2:2:len(dualvert)-1]) dualvert[i],
                                            dualvert[1]])
                      )
                      culledvert
              : style=="orig"? [
                                 for (i=[0:1:vsides-1])
                                     let(phi = (i+0.5)*180/(vsides))
                                     for (j=[0:1:hsides-1])
                                         let(theta = j*360/hsides)
                                         spherical_to_xyz(r, theta, phi),
                               ]
              : style=="aligned" || style=="stagger"?
                         [ spherical_to_xyz(r, 0, 0),
                           for (i=[1:1:vsides-1])
                               let(phi = i*180/vsides)
                               for (j=[0:1:hsides-1])
                                   let(theta = (j+((stagger && i%2!=0)?0.5:0))*360/hsides)
                                   spherical_to_xyz(r, theta, phi),
                           spherical_to_xyz(r, 0, 180)
                         ]
              : assert(in_list(style,["orig","aligned","stagger","octa","icosa"])),
        lv = len(verts),
        faces = circum && style=="stagger" ?
                     let(ptcount=2*hsides)
                     [
                       [for(i=[ptcount-2:-2:0]) i],
                       for(j=[0:hsides-1])
                           [j*2, (j*2+2)%ptcount,ptcount+(j*2+2)%ptcount,ptcount+(j*2+3)%ptcount,ptcount+j*2],
                       for(i=[1:vsides-3])
                           let(base=ptcount*i)
                           for(j=[0:hsides-1])
                               i%2==0 ? [base+2*j, base+(2*j+1)%ptcount, base+(2*j+2)%ptcount,
                                        base+ptcount+(2*j)%ptcount, base+ptcount+(2*j+1)%ptcount, base+ptcount+(2*j-2+ptcount)%ptcount]
                                      : [base+(1+2*j)%ptcount, base+(2*j)%ptcount, base+(2*j+3)%ptcount,
                                         base+ptcount+(3+2*j)%ptcount, base+ptcount+(2*j+2)%ptcount,base+ptcount+(2*j+1)%ptcount],
                       for(j=[0:hsides-1])
                          vsides%2==0
                            ? [(j*2+3)%ptcount, j*2+1, lv-ptcount+(2+j*2)%ptcount, lv-ptcount+(3+j*2)%ptcount, lv-ptcount+(4+j*2)%ptcount]
                            : [(j*2+3)%ptcount, j*2+1, lv-ptcount+(1+j*2)%ptcount, lv-ptcount+(j*2)%ptcount, lv-ptcount+(3+j*2)%ptcount],
                       [for(i=[1:2:ptcount-1]) i],
                     ]
              : style=="aligned" || style=="stagger" ?  // includes case of aligned with circum == true
                     [
                       for (i=[0:1:hsides-1])
                           let(b2 = lv-2-hsides)
                           each [
                                 [i+1, 0, ((i+1)%hsides)+1],
                                 [lv-1, b2+i+1, b2+((i+1)%hsides)+1],
                                ],
                       for (i=[0:1:vsides-3], j=[0:1:hsides-1])
                           let(base = 1 + hsides*i)
                           each (
                                 (stagger && i%2!=0)? [
                                     [base+j, base+hsides+j%hsides, base+hsides+(j+hsides-1)%hsides],
                                     [base+j, base+(j+1)%hsides, base+hsides+j],
                                 ] : [
                                     [base+j, base+(j+1)%hsides, base+hsides+(j+1)%hsides],
                                     [base+j, base+hsides+(j+1)%hsides, base+hsides+j],
                                 ]
                           )
                     ]
              : style=="orig"?
                  [
                      [for (i=[0:1:hsides-1]) hsides-i-1],
                      [for (i=[0:1:hsides-1]) lv-hsides+i],
                      for (i=[0:1:vsides-2], j=[0:1:hsides-1]) each [
                          [(i+1)*hsides+j, i*hsides+j, i*hsides+(j+1)%hsides],
                          [(i+1)*hsides+j, i*hsides+(j+1)%hsides, (i+1)*hsides+(j+1)%hsides],
                      ]
                  ]
              : assert(in_list(style,["orig","aligned","stagger","octa","icosa"]))
    ) [reorient(anchor,spin,orient, r=r, p=verts), faces];

// Function&Module: teardrop()
// Synopsis: Creates a teardrop shape.
// SynTags: Geom, VNF
// Topics: Shapes (3D), Attachable, VNF Generators, FDM Optimized
// See Also: onion(), teardrop2d()
// Description:
//   Makes a teardrop extrusion along the Y axis, which is useful for 3D printable holes.
//   Optional chamfers can be added with positive or negative distances.  A positive distance
//   specifies the amount to inset the chamfer along the front/back faces of the shape.
//   The chamfer extends the same y distance into the shape.  If the radii are the same
//   then the chamfer will be a 45° chamfer, but in other cases it will not.
//   With caps, the chamfer must not be so big that it makes the cap height illegal.
//   Similarly the chamfer cannot be larger than `bot_corner` if it is set, and if you do
//   set chamfer exactly equal to bottom corner, then `$fn` must be even if `realign` is false
//   and odd otherwise.  
// Usage: Typical
//   teardrop(h|l=|length=|height=, r, [ang], [cap_h], [chamfer=], [bot_corner=], ...) [ATTACHMENTS];
//   teardrop(h|l=|length=|height=, d=, [ang=], [cap_h=], [chamfer=], [bot_corner=], ...) [ATTACHMENTS];
// Usage: Psuedo-Conical
//   teardrop(h|l=|height=|length=, r1=, r2=, [ang=], [cap_h1=], [cap_h2=], [bot_corner1=], [bot_corner2=], ...)  [ATTACHMENTS];
//   teardrop(h|l=|height=|length=, d1=, d2=, [ang=], [cap_h1=], [cap_h2=], [bot_corner1=], [bot_corner2=], ...)  [ATTACHMENTS];
// Usage: As Function
//   vnf = teardrop(h|l=|height=|length=, r|d=, [ang=], [cap_h=], ...);
//   vnf = teardrop(h|l=|height=|length=, r1=|d1=, r2=|d2=, [ang=], [cap_h=], ...);
//   vnf = teardrop(h|l=|height=|length=, r1=|d1=, r2=|d2=, [ang=], [cap_h1=], [cap_h2=], ...);
//
// Arguments:
//   h / l / height / length = Thickness of teardrop. Default: 1
//   r = Radius of circular part of teardrop.  Default: 1
//   ang = Angle of hat walls from the Z axis.  Default: 45 degrees
//   cap_h = If given, height above center where the shape will be truncated. Default: `undef` (no truncation)
//   ---
//   circum = produce a circumscribing teardrop shape.  Default: false
//   bot_corner = create a bottom corner the specified distance below the given radius.  Default: 0
//   r1 = Radius of circular portion of the front end of the teardrop shape.
//   r2 = Radius of circular portion of the back end of the teardrop shape.
//   d = Diameter of circular portion of the teardrop shape.
//   d1 = Diameter of circular portion of the front end of the teardrop shape.
//   d2 = Diameter of circular portion of the back end of the teardrop shape.
//   cap_h1 = If given, height above center where the shape will be truncated, on the front side. Default: `undef` (no truncation)
//   cap_h2 = If given, height above center where the shape will be truncated, on the back side. Default: `undef` (no truncation)
//   chamfer = Specifies size of chamfer as distance along the bottom and top faces.  Default: 0
//   chamfer1 = Specifies size of chamfer on bottom as distance along bottom face.  Default: 0
//   chamfer2 = Specifies size of chamfer on top as distance along top face.  Default: 0
//   realign = if true, bottom of teardrop is flat; if false, bottom of teardrop is a point.  Default: false
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
//
// Named Anchors:
//   "cap" = The center of the top of the cap, oriented with the cap face normal.
//   "cap_fwd" = The front edge of the cap.
//   "cap_back" = The back edge of the cap.
//
// Example: Typical Shape
//   teardrop(r=30, h=10, ang=30);
// Example: Crop Cap
//   teardrop(r=30, h=10, ang=30, cap_h=40);
// Example: Close Crop
//   teardrop(r=30, h=10, ang=30, cap_h=20);
// Example: Psuedo-Conical
//   teardrop(r1=20, r2=30, h=40, cap_h1=25, cap_h2=35);
// Example: Adding chamfers can be useful for a teardrop hole mask
//   teardrop(r=10, l=50, chamfer1=2, chamfer2=-1.5);
// Example: This teardrop has a 1 unit clearance at the top and bottom using the cap and the bottom corner:
//   teardrop(r=10, l=50, cap_h=11, bot_corner=1);
// Example: Getting a VNF
//   vnf = teardrop(r1=25, r2=30, l=20, cap_h1=25, cap_h2=35);
//   vnf_polyhedron(vnf);
// Example: Standard Conical Connectors
//   teardrop(d1=20, d2=30, h=20, cap_h1=11, cap_h2=16)
//       show_anchors(custom=false);
// Example(Spin,VPD=150,Med): Named Conical Connectors
//   teardrop(d1=20, d2=30, h=20, cap_h1=11, cap_h2=16)
//       show_anchors(std=false);
// Example: Creating holes using attachment
//   $fn=32;
//   diff()
//     cuboid(15)
//     attach([FWD,RIGHT],FWD,inside=true, shiftout=.1)
//       tag("remove")teardrop(d=4, l=10);
// Example: You can rotate the point using the `spin` option to {{attach()}}.  Don't use the `spin` parameter to `teardrop()`.  
//   $fn=32;
//   diff()
//     cuboid(15)
//     attach(FWD,FWD,align=[TOP,BOT], inset=2,
//            inside=true, shiftout=.1, spin=90)
//       tag("remove")teardrop(d=4, l=10);
module teardrop(h, r, ang=45, cap_h, r1, r2, d, d1, d2, cap_h1, cap_h2, l, length, height, circum=false, realign=false,
                chamfer, chamfer1, chamfer2,anchor=CENTER, spin=0, orient=UP, bot_corner1, bot_corner2, bot_corner=0)
{
    length = one_defined([l, h, length, height],"l,h,length,height");
    dummy=assert(is_finite(length) && length>0, "\nlength must be positive.");
    r1 = get_radius(r=r, r1=r1, d=d, d1=d1);
    r2 = get_radius(r=r, r1=r2, d=d, d1=d2);
    tip_y1 = r1/cos(90-ang);
    tip_y2 = r2/cos(90-ang);
    _cap_h1 = min(default(cap_h1, tip_y1), tip_y1);
    _cap_h2 = min(default(cap_h2, tip_y2), tip_y2);
    capvec = unit([0, _cap_h1-_cap_h2, length]);
    anchors = [
        named_anchor("cap",      [0,0,(_cap_h1+_cap_h2)/2], capvec),
        named_anchor("cap_fwd",  [0,-length/2,_cap_h1],         unit((capvec+FWD)/2)),
        named_anchor("cap_back", [0,+length/2,_cap_h2],         unit((capvec+BACK)/2), 180),
    ];
    attachable(anchor,spin,orient, r1=r1, r2=r2, l=length, axis=BACK, anchors=anchors)
    {
        vnf_polyhedron(teardrop(ang=ang,cap_h=cap_h,r1=r1,r2=r2,cap_h1=cap_h1,cap_h2=cap_h2,circum=circum,realign=realign,
                                length=length, chamfer1=chamfer1,chamfer2=chamfer2,chamfer=chamfer,bot_corner1=bot_corner1, bot_corner2=bot_corner2,bot_corner=bot_corner));
        children();
    }
}

function teardrop(h, r, ang=45, cap_h, r1, r2, d, d1, d2, cap_h1, cap_h2,  chamfer, chamfer1, chamfer2, circum=false, realign=false, bot_corner1, bot_corner2, bot_corner=0,
                  l, length, height, anchor=CENTER, spin=0, orient=UP) =
    let(
        r1 = get_radius(r=r, r1=r1, d=d, d1=d1, dflt=1),
        r2 = get_radius(r=r, r1=r2, d=d, d1=d2, dflt=1),
        length = one_defined([l, h, length, height],"l,h,length,height"),
        dummy0=assert(is_finite(length) && length>0, "\nlength must be positive."),
        cap_h1 = first_defined([cap_h1, cap_h]),
        cap_h2 = first_defined([cap_h2, cap_h]),
        bot_corner1 = first_defined([bot_corner1, bot_corner]),
        bot_corner2 = first_defined([bot_corner2, bot_corner]),         
        chamfer1 = first_defined([chamfer1,chamfer,0]),
        chamfer2 = first_defined([chamfer2,chamfer,0]),    
        sides = segs(max(r1,r2)),
        profile1 = teardrop2d(r=r1, ang=ang, cap_h=cap_h1, $fn=sides, circum=circum, realign=realign,_extrapt=true, bot_corner=bot_corner1),
        profile2 = teardrop2d(r=r2, ang=ang, cap_h=cap_h2, $fn=sides, circum=circum, realign=realign,_extrapt=true, bot_corner=bot_corner2),
        tip_y1 = r1/cos(90-ang),
        tip_y2 = r2/cos(90-ang),
        _cap_h1 = min(default(cap_h1, tip_y1), tip_y1),
        _cap_h2 = min(default(cap_h2, tip_y2), tip_y2),
        capvec = unit([0, _cap_h1-_cap_h2, length]),
        dummy=
          assert(abs(chamfer1)+abs(chamfer2) <= length,"\nChamfers are too big to fit in the length.")
          assert(chamfer1<=r1 && chamfer2<=r2, "\nChamfers cannot be larger than radius.")
          assert(bot_corner1==0 || bot_corner1>=chamfer1, "\nchamfer1 doesn't work with bottom corner: must have chamfer1 <= bot_corner1")
          assert(bot_corner2==0 || bot_corner2>=chamfer2, "\nchamfer2 doesn't work with bottom corner: must have chamfer2 <= bot_corner2")
          assert(bot_corner1==0 || bot_corner1>chamfer1 || sides%2==(realign?1:0), 
                 str("\nWith chamfer1==bot_corner1 and realign=",realign," must have ",realign?"odd":"even"," number of sides, but sides=",sides))
          assert(is_undef(cap_h1) || cap_h1-chamfer1 > r1*sin(ang)-_EPSILON, "chamfer1 is too big to work with the specified cap_h1")
          assert(is_undef(cap_h2) || cap_h2-chamfer2 > r2*sin(ang)-_EPSILON, "chamfer2 is too big to work with the specified cap_h2"),
        cprof1 = r1==chamfer1 ? repeat([0,0],len(profile1))
                              : teardrop2d(r=r1-chamfer1, ang=ang, cap_h=u_add(cap_h1,-chamfer1), bot_corner=bot_corner1==0?0:bot_corner1-chamfer1,
                                           $fn=sides, circum=circum, realign=realign,_extrapt=true),
        cprof2 = r2==chamfer2 ? repeat([0,0],len(profile2))
                              : teardrop2d(r=r2-chamfer2, ang=ang, cap_h=u_add(cap_h2,-chamfer2), bot_corner=bot_corner2==0?0:bot_corner2-chamfer2,
                                           $fn=sides, circum=circum, realign=realign,_extrapt=true),
        anchors = [
            named_anchor("cap",      [0,0,(_cap_h1+_cap_h2)/2], capvec),
            named_anchor("cap_fwd",  [0,-length/2,_cap_h1],         unit((capvec+FWD)/2)),
            named_anchor("cap_back", [0,+length/2,_cap_h2],         unit((capvec+BACK)/2), 180),
        ],
        vnf = vnf_vertex_array(
            points = [
                if (chamfer1!=0) fwd(length/2, xrot(90, path3d(cprof1))),
                fwd(length/2-abs(chamfer1), xrot(90, path3d(profile1))),
                back(length/2-abs(chamfer2), xrot(90, path3d(profile2))),
                if (chamfer2!=0) back(length/2, xrot(90, path3d(cprof2))),
            ],
            caps=true, col_wrap=true, reverse=true
        )
    ) reorient(anchor,spin,orient, r1=r1, r2=r2, l=l, axis=BACK, anchors=anchors, p=vnf);

// Function&Module: onion()
// Synopsis: Creates an attachable onion-like shape.
// SynTags: Geom, VNF
// Topics: Shapes (3D), Attachable, VNF Generators, FDM Optimized
// See Also: teardrop(), teardrop2d()
// Description:
//   Creates a sphere with a conical hat, to make a 3D teardrop.
//
// Usage: As Module
//   onion(r|d=, [ang=], [cap_h=], [circum=], [realign=], ...) [ATTACHMENTS];
// Usage: As Function
//   vnf = onion(r|d=, [ang=], [cap_h=], [circum=], [realign=], ...);
//
// Arguments:
//   r = radius of spherical portion of the bottom. Default: 1
//   ang = Angle of cone on top from vertical. Default: 45 degrees
//   cap_h = If given, height above sphere center to truncate teardrop shape.  Default: `undef` (no truncation)
//   ---
//   circum = set to true to circumscribe the specified radius/diameter.  Default: False
//   realign = if false then the bottom is a point.  If true then the bottom is a flat face.  Default: False
//   d = diameter of spherical portion of bottom.
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
//
// Named Anchors:
//   "cap" = The center of the top of the cap, oriented with the cap face normal.
//   "tip" = The position where an un-capped onion comes to a point, oriented in the direction the point is from the center.
//
// Example: Typical Shape
//   onion(r=30, ang=30);
// Example: Crop Cap
//   onion(r=30, ang=30, cap_h=40);
// Example: Close Crop
//   onion(r=30, ang=30, cap_h=20);
// Example: Onions are useful for making the tops of large cylindrical voids.
//   difference() {
//       cuboid([100,50,100], anchor=FWD+BOT);
//       down(0.1)
//           cylinder(h=50,d=50,anchor=BOT)
//               attach(TOP)
//                   onion(d=50, cap_h=30);
//   }
// Example: Standard Connectors
//   onion(d=30, ang=30, cap_h=20) show_anchors();
module onion(r, ang=45, cap_h, d, circum=false, realign=false, anchor=CENTER, spin=0, orient=UP)
{
    r = get_radius(r=r, d=d, dflt=1);
    xyprofile = teardrop2d(r=r, ang=ang, cap_h=cap_h, circum=circum, realign=realign);
    tip_h = max(column(xyprofile,1));
    _cap_h = min(default(cap_h,tip_h), tip_h);
    anchors = [
        ["cap", [0,0,_cap_h], UP, 0],
        ["tip", [0,0,tip_h], UP, 0]
    ];
    attachable(anchor,spin,orient, r=r, anchors=anchors) {
        rotate_extrude(convexity=2) {
            difference() {
                polygon(xyprofile);
                square__1([2*r,2*max(_cap_h,r)+1], anchor=RIGHT);
            }
        }
        children();
    }
}

// onescad: BOSL2/shapes2d.scad
//////////////////////////////////////////////////////////////////////
// LibFile: shapes2d.scad
//   This file includes redefinitions of the core modules to
//   work with attachment, and functional forms of those modules
//   that produce paths.  You can create regular polygons
//   with optional rounded corners and alignment features not
//   available with circle().  The file also provides teardrop2d,
//   which is useful for 3D printable holes.  
//   Many of the commands have module forms that produce geometry and
//   function forms that produce a path. 
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Attachable circles, squares, polygons, teardrop.  Can make geometry or paths.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: 2D Primitives

// Function&Module: square()
// Synopsis: Creates a 2D square or rectangle.
// SynTags: Geom, Path, Ext
// Topics: Shapes (2D), Path Generators (2D)
// See Also: rect()
// Usage: As a Module
//   square(size, [center], ...);
// Usage: With Attachments
//   square(size, [center], ...) [ATTACHMENTS];
// Usage: As a Function
//   path = square(size, [center], ...);
// Description:
//   When called as the built-in module, creates a 2D square or rectangle of the given size.
//   When called as a function, returns a 2D path/list of points for a square/rectangle of the given size.
// Arguments:
//   size = The size of the square to create.  If given as a scalar, both X and Y will be the same size.
//   center = If given and true, overrides `anchor` to be `CENTER`.  If given and false, overrides `anchor` to be `FRONT+LEFT`.
//   ---
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
// Example(2D):
//   square(40);
// Example(2D): Centered
//   square([40,30], center=true);
// Example(2D): Called as Function
//   path = square([40,30], anchor=FRONT, spin=30);
//   stroke(path, closed=true);
//   move_copies(path) color("blue") circle(d=2,$fn=8);
function square(size=1, center, anchor, spin=0) =
    let(
        anchor = get_anchor(anchor, center, [-1,-1], [-1,-1]),
        size = is_num(size)? [size,size] : point2d(size)
    )
    assert(all_positive(size), "All components of size must be positive.")
    let(
        path = [
            [ size.x,-size.y],
            [-size.x,-size.y],
            [-size.x, size.y],
            [ size.x, size.y],
        ] / 2
    ) reorient(anchor,spin, two_d=true, size=size, p=path);

module square__1(size=1, center, anchor, spin) {
    anchor = get_anchor(anchor, center, [-1,-1], [-1,-1]);
    rsize = is_num(size)? [size,size] : point2d(size);
    size = [for (c = rsize) max(0,c)];
    attachable(anchor,spin, two_d=true, size=size) {
        if (all_positive(size))
            _square(size, center=true);
        children();
    }
}

function rect(size=1, rounding=0, chamfer=0, atype="box", anchor=CENTER, spin=0, _return_override, corner_flip = false) =
    assert(is_num(size)     || is_vector(size,2))
    assert(is_num(chamfer)  || is_vector(chamfer,4))
    assert(is_num(rounding) || is_vector(rounding,4))
    assert(in_list(atype, ["box", "perim"]))
    let(
        anchor=_force_anchor_2d(anchor),
        size = [for (c = force_list(size,2)) max(0,c)],
        corner_flip = [for (c = force_list(corner_flip,4)) c ? true : false],
        chamfer = force_list(chamfer,4), 
        rounding = force_list(rounding,4)
    )
    assert(all_nonnegative(size), "All components of size must be >=0")
    all_zero(concat(chamfer,rounding),0) ?
        let(
             path = [
                 [ size.x/2, -size.y/2],
                 [-size.x/2, -size.y/2],
                 [-size.x/2,  size.y/2],
                 [ size.x/2,  size.y/2],
             ],
             rotpath = rot(spin, p=move(-v_mul(anchor,size/2), p=path))
        )
        _return_override ? [rotpath,undef] : rotpath
    :
    assert(all_zero(v_mul(chamfer,rounding),0), "Cannot specify chamfer and rounding at the same corner")
    let(
        quadorder = [3,2,1,0],
        quadpos = [[1,1],[-1,1],[-1,-1],[1,-1]],
        eps = 1e-9,
        insets = [for (i=[0:3]) abs(chamfer[i])>=eps? chamfer[i] : abs(rounding[i])>=eps? rounding[i] : 0],
        insets_x = max(insets[0]+insets[1],insets[2]+insets[3]),
        insets_y = max(insets[0]+insets[3],insets[1]+insets[2])
    )
    assert(insets_x <= size.x, "Requested roundings and/or chamfers exceed the rect width.")
    assert(insets_y <= size.y, "Requested roundings and/or chamfers exceed the rect height.")
    let(
        corners = [
            for(i = [0:3])
            let(
                quad = quadorder[i],
                qinset = insets[quad],
                qpos = quadpos[quad],
                qchamf = chamfer[quad],
                qround = rounding[quad],
                cverts = quant(segs(abs(qinset)),4)/4,
                step = 90/cverts,
                cp = v_mul(size/2 + (corner_flip[quad] ? (qinset > 0 ? 0 : 1) : -1)*[qinset,abs(qinset)], qpos),
                qpts = abs(qchamf) >= eps? [[0,abs(qinset)], [qinset,0]] :
                    abs(qround) >= eps? [for (j=[0:1:cverts]) let(a=90-j*step) v_mul(polar_to_xy(abs(qinset),a),[sign(qinset),1])] :
                    [[0,0]],
                qfpts = [for (p=qpts) v_mul(p,corner_flip[quad] ? -qpos : qpos)],
                qrpts =  (corner_flip[quad] && qinset > 0 ? -1 : 1) * qpos.x*qpos.y < 0? reverse(qfpts) : qfpts,
                cornerpt = atype=="box" || (qround==0 && qchamf==0) ? undef
                         : qround<0 || qchamf<0 ? [[0,-qpos.y*min(qround,qchamf)]]
                         : [for(seg=pair(qrpts)) let(isect=line_intersection(seg, [[0,0],qpos],SEGMENT,LINE)) if (is_def(isect) && isect!=seg[0]) isect]
              )
            assert(is_undef(cornerpt) || len(cornerpt)==1,"Cannot find corner point to anchor")
            [move(cp, p=qrpts), is_undef(cornerpt)? undef : move(cp,p=
                         (min(chamfer[quad],rounding[quad])<0 && corner_flip[quad] ? [quadpos[quad].x*quadpos[quad].y*cornerpt[0].y, cornerpt[0].x] : cornerpt[0]))]
        ],
        path = deduplicate(flatten(column(corners,0)),closed=true),
        override = [for(i=[0:3])
                      let(quad=quadorder[i])
                      if (is_def(corners[i][1])) [quadpos[quad], [corners[i][1], min(chamfer[quad],rounding[quad])<0 ? (corner_flip[quad] ? [0, quadpos[quad].y] : [quadpos[quad].x, 0]) : undef]]]
      ) _return_override ? [reorient(anchor,spin, two_d=true, size=size, p=path, override=override), override]
                       : reorient(anchor,spin, two_d=true, size=size, p=path, override=override);

// Function&Module: circle()
// Synopsis: Creates the approximation of a circle.
// SynTags: Geom, Path, Ext
// Topics: Shapes (2D), Path Generators (2D)
// See Also: ellipse(), circle_2tangents(), circle_3points()
// Usage: As a Module
//   circle(r|d=, ...) [ATTACHMENTS];
//   circle(points=) [ATTACHMENTS];
//   circle(r|d=, corner=) [ATTACHMENTS];
// Usage: As a Function
//   path = circle(r|d=, ...);
//   path = circle(points=);
//   path = circle(r|d=, corner=);
// Description:
//   When called as the built-in module, creates a 2D polygon that approximates a circle of the given size.
//   When called as a function, returns a 2D list of points (path) for a polygon that approximates a circle of the given size.
//   If `corner=` is given three 2D points, centers the circle so that it will be tangent to both segments of the path, on the inside corner.
//   If `points=` is given three 2D points, centers and sizes the circle so that it passes through all three points.
// Arguments:
//   r = The radius of the circle to create.
//   d = The diameter of the circle to create.
//   ---
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
// Example(2D): By Radius
//   circle(r=25);
// Example(2D): By Diameter
//   circle(d=50);
// Example(2D): Fit to Three Points
//   pts = [[50,25], [25,-25], [-10,0]];
//   circle(points=pts);
//   color("red") move_copies(pts) circle(r=1.5,$fn=12);
// Example(2D): Fit Tangent to Inside Corner of Two Segments
//   path = [[50,25], [-10,0], [25,-25]];
//   circle(corner=path, r=15);
//   color("red") stroke(path);
// Example(2D): Called as Function
//   path = circle(d=50, anchor=FRONT, spin=45);
//   stroke(path,closed=true);
function circle(r, d, points, corner, anchor=CENTER, spin=0) =
    assert(is_undef(corner) || (is_path(corner,[2]) && len(corner) == 3))
    assert(is_undef(points) || is_undef(corner), "Cannot specify both points and corner.")
    let(
        data = is_def(points)?
                assert(is_path(points,[2]) && len(points) == 3)
                assert(is_undef(corner), "Cannot specify corner= when points= is given.")
                assert(is_undef(r) && is_undef(d), "Cannot specify r= or d= when points= is given.")
                let( c = circle_3points(points) )
                assert(!is_undef(c[0]), "Points cannot be collinear.")
                let( cp = c[0], r = c[1]  )
                [cp, r] :
            is_def(corner)?
                assert(is_path(corner,[2]) && len(corner) == 3)
                assert(is_undef(points), "Cannot specify points= when corner= is given.")
                let(
                    r = get_radius(r=r, d=d, dflt=1),
                    c = circle_2tangents(r=r, pt1=corner[0], pt2=corner[1], pt3=corner[2])
                )
                assert(c!=undef, "Corner path cannot be collinear.")
                let( cp = c[0] )
                [cp, r] :
            let(
                cp = [0, 0],
                r = get_radius(r=r, d=d, dflt=1)
            ) [cp, r],
        cp = data[0],
        r = data[1]
    )
    assert(r>0, "Radius/diameter must be positive")
    let(
        sides = segs(r),
        path = [for (i=[0:1:sides-1]) let(a=360-i*360/sides) r*[cos(a),sin(a)]+cp]
    ) reorient(anchor,spin, two_d=true, r=r, p=path);

// Iterative refinement to produce an inscribed polygon
// in an ellipse whose side lengths are all equal
function _ellipse_refine(a,b,N, _theta=[]) =
   len(_theta)==0? _ellipse_refine(a,b,N,lerpn(0,360,N,endpoint=false))
   :
   let(
       pts = [for(t=_theta) [a*cos(t),b*sin(t)]],
       lenlist= path_segment_lengths(pts,closed=true),
       meanlen = mean(lenlist),
       error = lenlist/meanlen
   )
   all_equal(error,_EPSILON) ? pts
   :
   let(
        dtheta = [each deltas(_theta),
                  360-last(_theta)],
        newdtheta = [for(i=idx(dtheta)) dtheta[i]/error[i]],
        adjusted = [0,each cumsum(list_head(newdtheta / sum(newdtheta) * 360))]
   )
   _ellipse_refine(a,b,N,adjusted);

function _ellipse_refine_realign(a,b,N, _theta=[],i=0) =
   len(_theta)==0?
         _ellipse_refine_realign(a,b,N, count(N-1,180/N,360/N))
   :
   let(
       pts = [for(t=_theta) [a*cos(t),b*sin(t)],
              [a*cos(_theta[0]), -b*sin(_theta[0])]],
       lenlist= path_segment_lengths(pts,closed=true),
       meanlen = mean(lenlist),
       error = lenlist/meanlen
   )
   all_equal(error,_EPSILON) ? pts
   :
   let(
        dtheta = [each deltas(_theta),
                  360-last(_theta)-_theta[0],
                  2*_theta[0]],
        newdtheta = [for(i=idx(dtheta)) dtheta[i]/error[i]],
        normdtheta = newdtheta / sum(newdtheta) * 360,
        adjusted = cumsum([last(normdtheta)/2, each list_head(normdtheta, -3)])
   )
   _ellipse_refine_realign(a,b,N,adjusted, i+1);

function ellipse(r, d, realign, circum=false, uniform=false, anchor=CENTER, spin=0) =
    assert(is_bool(circum))
    let(
        r = force_list(get_radius(r=r, d=d, dflt=1),2),
        sides = segs(max(r)),
        realign = default(realign,circum)
    )
    assert(is_bool(realign))  
    assert(all_positive(r), "All components of the radius must be positive.")
    uniform
      ? assert(!circum, "Circum option not allowed when \"uniform\" is true")
        reorient(anchor,spin,
            two_d=true, r=[r.x,r.y],
            p=realign
              ? reverse(_ellipse_refine_realign(r.x,r.y,sides))
              : reverse_polygon(_ellipse_refine(r.x,r.y,sides))
        )
      : let(
            offset = realign? 180/sides : 0,
            sc = circum? (1 / cos(180/sides)) : 1,
            rx = r.x * sc,
            ry = r.y * sc,
            pts = [
                for (i=[0:1:sides-1])
                let (a = 360-offset-i*360/sides)
                [rx*cos(a), ry*sin(a)]
            ]
        ) reorient(anchor,spin, two_d=true, r=[rx,ry], p=pts);

// Function&Module: trapezoid()
// Synopsis: Creates a trapezoid with parallel top and bottom sides.
// SynTags: Geom, Path
// Topics: Shapes (2D), Paths (2D), Path Generators, Attachable
// See Also: rect(), square()
// Usage: As Module
//   trapezoid(h, w1, w2, [shift=], [rounding=], [chamfer=], [flip=], ...) [ATTACHMENTS];
//   trapezoid(h, w1, ang=, [rounding=], [chamfer=], [flip=], ...) [ATTACHMENTS];
//   trapezoid(h, w2=, ang=, [rounding=], [chamfer=], [flip=], ...) [ATTACHMENTS];
//   trapezoid(w1=, w2=, ang=, [rounding=], [chamfer=], [flip=], ...) [ATTACHMENTS];
// Usage: As Function
//   path = trapezoid(...);
// Description:
//   When called as a function, returns a 2D path for a trapezoid with parallel front and back (top and bottom) sides. 
//   When called as a module, creates a 2D trapezoid.  You can specify the trapezoid by giving its height and the lengths
//   of its two bases.  Alternatively, you can omit one of those parameters and specify the lower angle(s).
//   The shift parameter, which cannot be combined with ang, shifts the back (top) of the trapezoid to the right.  
// Arguments:
//   h = The Y axis height of the trapezoid.
//   w1 = The X axis width of the front end of the trapezoid.
//   w2 = The X axis width of the back end of the trapezoid.
//   ---
//   ang = Specify the bottom angle(s) of the trapezoid.  Can give a scalar for an isosceles trapezoid or a list of two angles, the left angle and right angle.  You must omit one of `h`, `w1`, or `w2` to allow the freedom to control the angles. 
//   shift = Scalar value to shift the back of the trapezoid along the X axis by.  Cannot be combined with ang.  Default: 0
//   rounding = The rounding radius for the corners.  If given as a list of four numbers, gives individual radii for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-]. Default: 0 (no rounding)
//   chamfer = The Length of the chamfer faces at the corners.  If given as a list of four numbers, gives individual chamfers for each corner, in the order [X+Y+,X-Y+,X-Y-,X+Y-].  Default: 0 (no chamfer)
//   flip = If true, negative roundings and chamfers will point forward and back instead of left and right.  Default: `false`.
//   atype = The type of anchoring to use with `anchor=`.  Valid opptions are "box" and "perim".  This lets you choose between putting anchors on the rounded or chamfered perimeter, or on the square bounding box of the shape. Default: "box"
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
// Anchor Types:
//   box = Anchor is with respect to the rectangular bounding box of the shape.
//   perim = Anchors are placed along the rounded or chamfered perimeter of the shape.
// Examples(2D):
//   trapezoid(h=30, w1=40, w2=20);
//   trapezoid(h=25, w1=20, w2=35);
//   trapezoid(h=20, w1=40, w2=0);
//   trapezoid(h=20, w1=30, ang=60);
//   trapezoid(h=20, w1=20, ang=120);
//   trapezoid(h=20, w2=10, ang=60);
//   trapezoid(h=20, w1=50, ang=[40,60]);
//   trapezoid(w1=30, w2=10, ang=[30,90]);
// Example(2D): Chamfered Trapezoid
//   trapezoid(h=30, w1=60, w2=40, chamfer=5);
// Example(2D): Negative Chamfered Trapezoid
//   trapezoid(h=30, w1=60, w2=40, chamfer=-5);
// Example(2D): Flipped Negative Chamfered Trapezoid
//   trapezoid(h=30, w1=60, w2=40, chamfer=-5, flip=true);
// Example(2D): Rounded Trapezoid
//   trapezoid(h=30, w1=60, w2=40, rounding=5);
// Example(2D): Negative Rounded Trapezoid
//   trapezoid(h=30, w1=60, w2=40, rounding=-5);
// Example(2D): Flipped Negative Rounded Trapezoid
//   trapezoid(h=30, w1=60, w2=40, rounding=-5, flip=true);
// Example(2D): Mixed Chamfering and Rounding
//   trapezoid(h=30, w1=60, w2=40, rounding=[5,0,-10,0],chamfer=[0,8,0,-15],$fa=1,$fs=1);
// Example(2D): default anchors for roundings
//   trapezoid(h=30, w1=100, ang=[66,44],rounding=5) show_anchors();
// Example(2D): default anchors for negative roundings are still at the trapezoid corners
//   trapezoid(h=30, w1=100, ang=[66,44],rounding=-5) show_anchors();
// Example(2D): "perim" anchors are at the tips of negative roundings
//   trapezoid(h=30, w1=100, ang=[66,44],rounding=-5, atype="perim") show_anchors();
// Example(2D): They point the other direction if you flip them
//   trapezoid(h=30, w1=100, ang=[66,44],rounding=-5, atype="perim",flip=true) show_anchors();
// Example(2D): Called as Function
//   stroke(closed=true, trapezoid(h=30, w1=40, w2=20));
function _trapezoid_dims(h,w1,w2,shift,ang) = 
    let(  
        h = is_def(h)? h
          : num_defined([w1,w2,each ang])==4 ? (w1-w2) * sin(ang[0]) * sin(ang[1]) / sin(ang[0]+ang[1])
          : undef
    )
    is_undef(h) ? [h]
  :
    let(
        x1 = is_undef(ang[0]) || ang[0]==90 ? 0 : h/tan(ang[0]),
        x2 = is_undef(ang[1]) || ang[1]==90 ? 0 : h/tan(ang[1]),
        w1 = is_def(w1)? w1
           : is_def(w2) && is_def(ang[0]) ? w2 + x1 + x2
           : undef,
        w2 = is_def(w2)? w2
           : is_def(w1) && is_def(ang[0]) ? w1 - x1 - x2
           : undef,
        shift = first_defined([shift,(x1-x2)/2])
    )
    [h,w1,w2,shift];

// _extrapt = true causes the point to be duplicated so a teardrop with no cap
// has the same point count as one with a cap.
function teardrop2d(r, ang=45, cap_h, d, circum=false, realign=false, anchor=CENTER, spin=0, bot_corner=0, _extrapt=false) =
    let(
        r = get_radius(r=r, d=d, dflt=1)
    )  
    bot_corner!=0 ?
       assert(all_nonnegative([bot_corner]),"bot_corner must be nonnegative")
       let(
           path = teardrop2d(r=r,ang=ang, cap_h=cap_h, circum=circum, realign=realign),
           corner = -r-bot_corner,
           alpha = acos(r/corner),
           joint = r*[sin(alpha),cos(alpha)],
           table = [[0,corner],joint],
           halfpath = [for(pt=path) if (pt.x>=0)
                          let(proj=lookup(pt.x,table))
                          pt.x>joint.x || pt.y>0 || pt.y<=proj ? pt : [pt.x,proj]],
           fullpath = deduplicate(
                                   [
                                     each halfpath,
                                     if (last(halfpath).x>0) [0,corner],
                                     each reverse(xflip(halfpath))
                                   ], closed=!_extrapt
                                 )
       )
       reorient(anchor,spin,two_d=true, path=fullpath, p=fullpath, extent=false)
  :
    let(
        minheight = r*sin(ang),
        maxheight = r/sin(ang), //cos(90-ang),
        pointycap = is_undef(cap_h) || cap_h>=maxheight
    )
    assert(is_undef(cap_h) || cap_h>=minheight, str("cap_h cannot be less than ",minheight," but it is ",cap_h))
    let(
        cap = [
                pointycap? [0,maxheight] : [(maxheight-cap_h)*tan(ang), cap_h],
                r*[cos(ang),sin(ang)]
              ],
        fullcircle = ellipse(r=r, realign=realign, circum=circum,spin=90),        
        
        // Chose the point on the circle that is lower than the cap but also creates a segment bigger than
        // seglen/skipfactor so we don't have a teeny tiny segment at the end of the cap, except for the hexagon
        // case which is treated specially
        skipfactor = len(fullcircle)==6 ? 15 : 3,
        path = !circum ?
                  let(seglen = norm(fullcircle[0]-fullcircle[1]))
                  [
                   each cap,
                   for (p=fullcircle)
                          if (
                               p.y<last(cap).y-_EPSILON
                                 && norm([abs(p.x)-last(cap).x,p.y-last(cap.y)])>seglen/skipfactor
                             ) p,
                   xflip(cap[1]),
                   if (_extrapt || !pointycap) xflip(cap[0])
                  ]
             : let(
                   isect = [for(i=[0:1:len(fullcircle)/4])
                               let(p = line_intersection(cap, select(fullcircle,[i,i+1]), bounded1=RAY, bounded2=SEGMENT))
                               if (p) [i,p]
                           ],
                   i = last(isect)[0],
                   p = last(isect)[1]
               )
               [
                 cap[0],
                 p,
                 each select(fullcircle,i+1,-i-1-(realign==true && circum==true?1:0)),
                 xflip(p),
                 if(_extrapt || !pointycap) xflip(cap[0])
               ]
    )
    reorient(anchor,spin, two_d=true, path=path, p=path, extent=false);

// onescad: BOSL2/drawing.scad
//////////////////////////////////////////////////////////////////////
// LibFile: drawing.scad
//   This file includes stroke(), which converts a path into a
//   geometric object, like drawing with a pen.  It even works on
//   three-dimensional paths.  You can make a dashed line or add arrow
//   heads.  The turtle() function provides a turtle graphics style
//   approach for producing paths.  The arc() function produces arc paths,
//   and helix() produces helical paths.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Basic Modeling
// FileSummary: Create and draw 2D and 3D paths: arc, helix, turtle graphics
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Computing paths

// Function&Module: arc()
// Synopsis: Draws a 2D pie-slice or returns 2D or 3D path forming an arc.
// SynTags: Geom, Path 
// Topics: Paths (2D), Paths (3D), Shapes (2D), Path Generators, Rounding
// See Also: pie_slice(), stroke(), ring()
//
// Usage: 2D arc from 0º to `angle` degrees.
//   path=arc(n, r|d=, angle);
// Usage: 2D arc from START to END degrees.
//   path=arc(n, r|d=, angle=[START,END]);
// Usage: 2D arc from `start` to `start+angle` degrees.
//   path=arc(n, r|d=, start=, angle=);
// Usage: 2D circle segment by `width` and `thickness`, starting and ending on the X axis.
//   path=arc(n, width=, thickness=);
// Usage: Shortest 2D or 3D arc around centerpoint `cp`, starting at P0 and ending on the vector pointing from `cp` to `P1`.
//   path=arc(n, cp=, points=[P0,P1], [long=], [cw=], [ccw=]);
// Usage: 2D or 3D arc, starting at `P0`, passing through `P1` and ending at `P2`.
//   path=arc(n, points=[P0,P1,P2]);
// Usage: 2D or 3D arc, fron tangent point on segment `[P0,P1]` to the tangent point on segment `[P1,P2]`.
//   path=arc(n, corner=[P0,P1,P2], r=);
// Usage: Create a wedge using any other arc parameters
//   path=arc(wedge=true,[rounding=],...)
// Usage: as module
//   arc(...) [ATTACHMENTS];
// Description:
//   If called as a function, returns a 2D or 3D path forming an arc.  Numerous methods are available to specify the arc as listed in the Arguments section.
//   If called as a module, the arc must be 2D and the module creates the segment of the circle obtained by adding
//   the closing segment to the arc.  
//   If `wedge` is true, the centerpoint of the arc appears as the first point in the result, which is now a sector of a circle.
//   The module produces the sector of the circle, or pie shape, bounded by the arc.  
//   .
//   If `endpoint=false`, which is only accepted by the functional form, then the arc stops one step before the final point.  
//   The `rounding` parameter, which is permitted only when `wedge=true`, applies specified radius roundings at each of the corners, with `rounding[0]` giving
//   the rounding at the center point, and then the other two the two outer corners in the direction that the arc travels.  
//   .
//   If you give `n` for an arc without roundings then the curve of the arc will use `n` points.  If `endpoint=false` the arc still has `n` points, but
//   they are closer together.  When wedge is true the output has an extra point.  If you use rounding on a wedge then each rounding will have the specified
//   number of points, but note that the points of adjacent rounded areas overlap.  It may be easier to think that each curve in the output has n-1 facets.  With rounding,
//   the total number of points on a wedge will be $n + 1 + (n-1) k$ where $k$ is the number of roundings that are nonzero.  
//   To get enough points on corner roundings you may need an `n` that is very large and produces more points than needed on the main curved portion of the arc.
//   Using `$fs` and `$fa` makes it possible to have differing numbers of points on the various roundings in your arc based on their radius and angle.
//   .
//   The module form with `wedge=false` must have 3 points on the arc to produce non-empty geometry.  If you specify `n=2` in this case it is an error.  If you use `$fn`, `$fa` and/or `$fs` to control the faceting the point count will be rounded up so that the output always has at least 3 points (2 facets).  The functional form does **not** round the point count up to 3, so this means that for small point counts, the module and function will produce different results.  
// Arguments:
//   n = Number of vertices to use in the arc.  If `wedge=true` you will get `n+1` points.  
//   r = Radius of the arc.
//   angle = If a scalar, specifies the end angle in degrees (relative to start parameter).  If a vector of two scalars, specifies start and end angles.
//   ---
//   d = Diameter of the arc.
//   cp = Centerpoint of arc.
//   points = Points on the arc.
//   corner = A path of two segments to fit an arc tangent to.
//   long = if given with cp and points takes the long arc instead of the default short arc.  Default: false
//   cw = if given with cp and 2 points takes the arc in the clockwise direction.  Default: false
//   ccw = if given with cp and 2 points takes the arc in the counter-clockwise direction.  Default: false
//   width = If given with `thickness`, arc starts and ends on X axis, to make a circle segment.
//   thickness = If given with `width`, arc starts and ends on X axis, to make a circle segment.
//   start = Start angle of arc.  Default: 0
//   wedge = If true, include centerpoint `cp` in output to form pie slice shape.  Default: false
//   endpoint = If false exclude the last point (function only).  Default: true
//   rounding = Can set to a scalar or list of three rounding values to round the corners of an arc when wedge=true.  Default: 0
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  (Module only) Default: `CENTER`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  (Module only) Default: `0`
// Examples(2D):
//   arc(n=4, r=30, angle=30, wedge=true);
//   arc(r=30, angle=30, wedge=true);
//   arc(d=60, angle=30, wedge=true);
//   arc(d=60, angle=120);
//   arc(d=60, angle=120, wedge=true);
//   arc(r=30, angle=[75,135], wedge=true);
//   arc(r=30, start=45, angle=75, wedge=true);
//   arc(width=60, thickness=20);
//   arc(cp=[-10,5], points=[[20,10],[0,35]], wedge=true);
//   arc(points=[[30,-5],[20,10],[-10,20]], wedge=true);
// Example(2D): Fit to three points.
//   arc(points=[[5,30],[-10,-10],[30,5]], wedge=true);
// Example(2D):
//   path = arc(points=[[5,30],[-10,-10],[30,5]], wedge=true);
//   stroke(closed=true, path);
// Example(FlatSpin,VPD=175):
//   path = arc(points=[[0,30,0],[0,0,30],[30,0,0]]);
//   stroke(path, dots=true, dots_color="blue");
// Example(2D): Fit to a corner.
//   pts = [[0,40], [-40,-10], [30,0]];
//   path = arc(corner=pts, r=20);
//   stroke(pts, endcaps="arrow2");
//   stroke(path, endcap2="arrow2", color="blue");
// Example(2D, NoScales): Rounding the corners
//   $fs=.5; $fa=1;
//   arc(r=25, angle=[25,107], rounding=[6,5,7], wedge=true);
//   stroke(arc(r=25, angle=[25,107], wedge=true), color="red",closed=true, width=.5);
// Example(2D, NoScales): Negative roundings are permitted on the two outside corners, but not the center corner.  
//   $fs=.5; $fa=1;
//   arc(r=25, angle=[-30,45], rounding=[0,-12, -27], wedge=true);
//   stroke(arc(r=25, angle=[-30,45], wedge=true), color="red",closed=true, width=.5);
function arc(n, r, angle, d, cp, points, corner, width, thickness, start, wedge=false, long=false, cw=false, ccw=false, endpoint=true, rounding, _minpts=2) =
    assert(is_bool(endpoint))
    !endpoint ?
        assert(!wedge, "endpoint cannot be false if wedge is true")
        list_head(arc(u_add(n,1),r,angle,d,cp,points,corner,width,thickness,start,wedge,long,cw,ccw,true,rounding,_minpts))
  :
    assert(is_undef(start) || is_def(angle), "start requires angle")
    assert(is_undef(angle) || !any_defined([thickness,width,points,corner]), "Cannot give angle with points, corner, width or thickness")
    assert(is_undef(n) || (is_integer(n) && n>=2), "Number of points must be an integer 2 or larger")
    assert(is_undef(points) || is_path(points, [2,3]), "Points must be a list of 2d or 3d points")
    assert((is_def(points) && len(points)==2) || !any([cw,ccw,long]), "cw, ccw, and long are only allowed when points is a list of length 2")
    // First try for 2D arc specified by width and thickness
    is_def(width) && is_def(thickness)? 
        assert(!any_defined([r,cp,points,angle,start]),"Conflicting or invalid parameters to arc")
        assert(width>0, "Width must be postive")
        assert(thickness>0, "Thickness must be positive")
        arc(n,points=[[width/2,0], [0,thickness], [-width/2,0]],wedge=wedge,rounding=rounding,_minpts=_minpts)
  : is_def(angle)? 
        let(
            parmok = !any_defined([points,width,thickness]) &&
                ((is_vector(angle,2) && is_undef(start)) || is_finite(angle))
        )
        assert(parmok,"Invalid parameters in arc")
        let(
            cp = first_defined([cp,[0,0]]),
            start = is_def(start)? start : is_vector(angle) ? angle[0] : 0,
            angle = is_vector(angle)? angle[1]-angle[0] : angle,
            r = get_radius(r=r, d=d)
        )
        assert(is_vector(cp,2),"Centerpoint must be a 2d vector")
        assert(angle!=0, "Arc has zero length")
        assert(is_def(r) && r>0, "Arc radius invalid")
        is_def(rounding) ? assert(wedge,"rounding is only supportd with wedge=true") move(cp,zrot(start,_rounded_arc(r, rounding, angle, n)))
     :
        let(
            n = is_def(n) ? assert(n>=_minpts,str("\nThe n parameter must be at least ",_minpts)) n
                          : max(wedge?2:_minpts,1+segs(r,angle)), 
            arcpoints = [for(i=[0:n-1]) let(theta = start + i*angle/(n-1)) r*[cos(theta),sin(theta)]+cp]
        )
        [
          if (wedge) cp,
          each arcpoints
        ]
  : is_def(corner)? 
        assert(is_path(corner,[2,3]) && len(corner)==3,str("Point list is invalid"))
        assert(is_undef(cp) && !any([long,cw,ccw]), "Cannot use cp, long, cw, or ccw with corner")
        // Arc is 3D, so transform corner to 2D and make a recursive call, then remap back to 3D
        len(corner[0]) == 3? (
            let(
                plane = [corner[2], corner[0], corner[1]],
                points2d = project_plane(plane, corner)
            )
            lift_plane(plane,arc(n,corner=points2d,wedge=wedge,r=r, d=d,rounding=rounding,_minpts=_minpts))
        ) :
        assert(is_path(corner) && len(corner) == 3)
        let(col = is_collinear(corner[0],corner[1],corner[2]))
        assert(!col, "Collinear inputs do not define an arc")
        let( r = get_radius(r=r, d=d) )
        assert(is_finite(r) && r>0, "Must specify r= or d= when corner= is given.")
        let(
            ci = circle_2tangents(r, corner[0], corner[1], corner[2], tangents=true),
            cp = ci[0], nrm = ci[1], tp1 = ci[2], tp2 = ci[3],
            dir = det2([corner[1]-corner[0],corner[2]-corner[1]]) > 0,
            corner = dir? [tp1,tp2] : [tp2,tp1],
            theta_start = atan2(corner[0].y-cp.y, corner[0].x-cp.x),
            theta_end = atan2(corner[1].y-cp.y, corner[1].x-cp.x),
            angle = posmod(theta_end-theta_start, 360),
            ang_range = dir ? [theta_start, theta_start+angle]
                            : [theta_start+angle, theta_start]
        )
        arc(n,cp=cp,r=r,angle=ang_range,wedge=wedge,rounding=rounding,_minpts=_minpts)
  : assert(is_def(points), "Arc not specified: must give points, angle, or width and thickness")
    assert(is_path(points,[2,3]),"Point list is invalid")
         // If arc is 3D, transform points to 2D and make a recursive call, then remap back to 3D
    len(points[0]) == 3? 
        assert(!(cw || ccw), "(Counter)clockwise isn't meaningful in 3d, so `cw` and `ccw` must be false")
        assert(is_undef(cp) || is_vector(cp,3),"points are 3d so cp must be 3d")
        let(
            plane = [is_def(cp) ? cp : points[2], points[0], points[1]],
            center2d = is_def(cp) ? project_plane(plane,cp) : undef,
            points2d = project_plane(plane, points)
        )
        lift_plane(plane,arc(n,cp=center2d,points=points2d,wedge=wedge,long=long,rounding=rounding,_minpts=_minpts))
  : len(points)==2?  
        // Arc defined by center plus two points, will have radius defined by center and points[0]
        // and extent defined by direction of point[1] from the center
        assert(is_vector(cp,2), "Centerpoint is required when points has length 2 and it must be a 2d vector")
        assert(len(points)==2, "When pointlist has length 3 centerpoint is not allowed")
        assert(points[0]!=points[1], "Arc endpoints are equal")
        assert(cp!=points[0]&&cp!=points[1], "Centerpoint equals an arc endpoint")
        assert(num_true([long,cw,ccw])<=1, str("Only one of `long`, `cw` and `ccw` can be true",cw,ccw,long))
        let(    
            angle = vector_angle(points[0], cp, points[1]),
            v1 = points[0]-cp,
            v2 = points[1]-cp,
            prelim_dir = sign(det2([v1,v2])),  // z component of cross product
            dir = prelim_dir != 0 ? prelim_dir :
                assert(cw || ccw, "Collinear inputs don't define a unique arc")
                1,
            r = norm(v1),
            final_angle = long || (ccw && dir<0) || (cw && dir>0) ?
                -dir*(360-angle) :
                dir*angle,
            sa = atan2(v1.y,v1.x)
        )
        arc(n,cp=cp,r=r,start=sa,angle=final_angle,wedge=wedge,rounding=rounding,_minpts=_minpts)
  : // Final case is arc passing through three points, starting at point[0] and ending at point[3]
        let(col = is_collinear(points[0],points[1],points[2]))
        assert(!col, "Collinear inputs do not define an arc")
        let(
            cp = line_intersection(_normal_segment(points[0],points[1]),_normal_segment(points[1],points[2])),
            // select order to be counterclockwise
            dir = det2([points[1]-points[0],points[2]-points[1]]) > 0,
            points = dir? select(points,[0,2]) : select(points,[2,0]),
            r = norm(points[0]-cp),
            theta_start = atan2(points[0].y-cp.y, points[0].x-cp.x),
            theta_end = atan2(points[1].y-cp.y, points[1].x-cp.x),
            angle = posmod(theta_end-theta_start, 360),
            // Specify endpoints exactly; skip those endpoints when producing arc points
            // Generating the whole arc and clipping ends is the easiest way to ensure that we
            // generate the proper number of points.
            ang_range = dir ? [theta_start, theta_start+angle]
                            : [theta_start+angle, theta_start],
            arcpts = is_def(rounding)? arc(n,cp=cp,r=r,angle=ang_range,wedge=wedge,rounding=rounding,_minpts=_minpts)
                   : [
                       if (wedge) cp, 
                       points[dir ? 0 : 1],
                       each select(arc(n,cp=cp,r=r,angle=ang_range,_minpts=_minpts),1,-2),
                       points[dir ? 1 : 0]
                     ]
        )
        arcpts;

function _rounded_arc(radius, rounding=0, angle, n) =
    assert(is_finite(angle) && abs(angle)<360, "angle must be strictly between -360 and 360")
    assert(is_finite(rounding) || is_vector(rounding,3), "rounding must be a scalar or 3-vector")
    let(
        rounding = force_list(rounding,3),
        
        dir = sign(angle),

        inner_corner_radius = abs(angle)>180 ? -dir*rounding[0] : dir*rounding[0],        
        arc1_opt_radius = radius - rounding[1],
        arc2_opt_radius = radius - rounding[2],
        check = assert(rounding[0]>=0, "rounding[0] must be nonnegative")
                assert(rounding[1]<arc1_opt_radius, "rounding[1] is too big to fit")
                assert(rounding[2]<arc2_opt_radius, "rounding[2] is too big to fit"),
        arc1_angle = asin(abs(rounding[1])/arc1_opt_radius),
        arc2_angle = asin(abs(rounding[2])/arc2_opt_radius),
        arc1_cut = radius - arc1_opt_radius*cos(arc1_angle),
        arc2_cut = radius - arc2_opt_radius*cos(arc2_angle),
        radius_of_ctrpt = inner_corner_radius/sin(angle/2),
        radius_of_ctrpt_edge = radius_of_ctrpt*cos(angle/2),
        
        pt1 = polar_to_xy(r=arc1_opt_radius, theta=dir*arc1_angle),
        pt2 = polar_to_xy(r=radius_of_ctrpt, theta=0.5*angle),
        pt3 = polar_to_xy(r=arc2_opt_radius, theta=angle - dir*arc2_angle),
        
        edge_gap1=radius-arc1_cut-radius_of_ctrpt_edge,
        edge_gap2=radius-arc2_cut-radius_of_ctrpt_edge,
        angle_span1 = rounding[1]>0 ? [-dir*90, dir*arc1_angle] : -[dir*90, dir*180 - arc1_angle],
        angle_span2 = [angle-dir*arc2_angle + (rounding[2]<0 ? dir*180 : 0), angle+dir*90]
    )
    assert(arc1_angle + arc2_angle<=abs(angle), "Roundings are too large: they interfere with each other on the arc")   
    assert(edge_gap1>=0, "Roundings are too large: center rounding (rounding[0]) interferes with first corner (rounding[1])")
    assert(edge_gap2>=0, "Roundings are too large: center rounding (rounding[0]) interferes with second corner (rounding[2])")   
    [
      each if (rounding[0]>0 && abs(angle)!=180)
                               arc(cp=pt2,
                                   points=[polar_to_xy(r=radius_of_ctrpt_edge, theta=angle),          // origin corner curve
                                   polar_to_xy(r=radius_of_ctrpt_edge, theta=0)],
                                   endpoint=edge_gap1!=0,n=n)
           else repeat([0,0],rounding[0]>0 && abs(angle)==180 && is_def(n) ? n : 1),                        
      each if (rounding[1]!=0) arc(r=abs(rounding[1]),cp=pt1,angle=angle_span1,
                                   endpoint=dir*arc1_angle==angle,n=u_add(n,dir*arc1_angle==angle?0:-1)),            // first corner
      each if (arc1_angle+arc2_angle<abs(angle))
                      arc(r=radius, angle=[dir*arc1_angle,angle - dir*arc2_angle], endpoint=rounding[2]==0,    // main arc section
                          n=u_add(n,rounding[2]==0?0:-1)),   
      each if (rounding[2]!=0) arc(r=abs(rounding[2]),cp=pt3,  angle=angle_span2, endpoint=edge_gap2!=0, n=n)  // second corner
    ];

function _normal_segment(p1,p2) =
    let(center = (p1+p2)/2)
    [center, center + norm(p1-p2)/2 * line_normal(p1,p2)];

// onescad: BOSL2/math.scad
//////////////////////////////////////////////////////////////////////
// LibFile: math.scad
//   Assorted math functions, including linear interpolation, list operations (sums, mean, products),
//   convolution, quantization, log2, hyperbolic trig functions, random numbers, derivatives,
//   polynomials, and root finding. 
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Math
// FileSummary: Math on lists, special functions, quantization, random numbers, calculus, root finding
//  
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Math Constants

// Constant: PHI
// Synopsis: The golden ratio φ (phi).  Approximately 1.6180339887
// Topics: Constants, Math
// See Also: EPSILON, INF, NAN
// Description: The golden ratio φ (phi).  Approximately 1.6180339887
PHI = (1+sqrt(5))/2;

_EPSILON = 1e-9;

// Constant: INF
// Synopsis: The floating point value for Infinite.
// Topics: Constants, Math
// See Also: PHI, EPSILON, NAN
// Description: The value `inf`, useful for comparisons.
INF = 1/0;

// Section: Interpolation and Counting


// Function: count()
// Synopsis: Creates a list of incrementing numbers.
// Topics: Math, Indexing
// See Also: idx()
// Usage:
//   list = count(n, [s], [step], [reverse]);
// Description:
//   Creates a list of `n` numbers, starting at `s`, incrementing by `step` each time.
//   You can also pass a list for n and then the length of the input list is used.  
// Arguments:
//   n = The length of the list of numbers to create, or a list to match the length of.
//   s = The starting value of the list of numbers.
//   step = The amount to increment successive numbers in the list.
//   reverse = Reverse the list.  Default: false.
// Example:
//   nl1 = count(5);  // Returns: [0,1,2,3,4]
//   nl2 = count(5,3);  // Returns: [3,4,5,6,7]
//   nl3 = count(4,3,2);  // Returns: [3,5,7,9]
//   nl4 = count(5,reverse=true);    // Returns: [4,3,2,1,0]
//   nl5 = count(5,3,reverse=true);  // Returns: [7,6,5,4,3]
function count(n,s=0,step=1,reverse=false) = let(n=is_list(n) ? len(n) : n)
                                             reverse? [for (i=[n-1:-1:0]) s+i*step]
                                                    : [for (i=[0:1:n-1]) s+i*step];

// Function: lerp()
// Synopsis: Linearly interpolates between two values.
// Topics: Interpolation, Math
// See Also: v_lookup(), lerpn()
// Usage:
//   x = lerp(a, b, u);
//   l = lerp(a, b, LIST);
// Description:
//   Interpolate between two values or vectors.
//   * If `u` is given as a number, returns the single interpolated value.
//   * If `u` is 0.0, then the value of `a` is returned.
//   * If `u` is 1.0, then the value of `b` is returned.
//   * If `u` is a range, or list of numbers, returns a list of interpolated values.
//   .
//   It is valid to use a `u` value outside the range 0 to 1 to extrapolate
//   along the slope formed by `a` and `b`.
// Arguments:
//   a = First value or vector.
//   b = Second value or vector.
//   u = The proportion from `a` to `b` to calculate.  Standard range is 0.0 to 1.0, inclusive.  If given as a list or range of values, returns a list of results.
// Example:
//   x = lerp(0,20,0.3);  // Returns: 6
//   x = lerp(0,20,0.8);  // Returns: 16
//   x = lerp(0,20,-0.1); // Returns: -2
//   x = lerp(0,20,1.1);  // Returns: 22
//   p = lerp([0,0],[20,10],0.25);  // Returns [5,2.5]
//   l = lerp(0,20,[0.4,0.6]);  // Returns: [8,12]
//   l = lerp(0,20,[0.25:0.25:0.75]);  // Returns: [5,10,15]
// Example(2D):
//   p1 = [-50,-20];  p2 = [50,30];
//   stroke([p1,p2]);
//   pts = lerp(p1, p2, [0:1/8:1]);
//   // Points colored in ROYGBIV order.
//   rainbow(pts) translate($item) circle(d=3,$fn=8);
function lerp(a,b,u) =
    assert(same_shape(a,b), "\nBad or inconsistent inputs to lerp.")
    is_finite(u)? (1-u)*a + u*b :
    assert(is_finite(u) || is_vector(u) || valid_range(u), "\nInput u to lerp must be a number, vector, or valid range.")
    [for (v = u) (1-v)*a + v*b ];

// Function: lerpn()
// Synopsis: Returns exactly `n` values, linearly interpolated between `a` and `b`.
// Topics: Interpolation, Math
// See Also: v_lookup(), lerp()
// Usage:
//   x = lerpn(a, b, n);
//   x = lerpn(a, b, n, [endpoint]);
// Description:
//   Returns exactly `n` values, linearly interpolated between `a` and `b`.
//   If `endpoint` is true, then the last value equals `b`.
//   If `endpoint` is false, then the last value is `a+(b-a)*(1-1/n)`.
// Arguments:
//   a = First value or vector.
//   b = Second value or vector.
//   n = The number of values to return.
//   endpoint = If true, the last value equals `b`.  If false, the last value is one step less. Default: true
// Example:
//   l = lerpn(-4,4,9);        // Returns: [-4,-3,-2,-1,0,1,2,3,4]
//   l = lerpn(-4,4,8,false);  // Returns: [-4,-3,-2,-1,0,1,2,3]
//   l = lerpn(0,1,6);         // Returns: [0, 0.2, 0.4, 0.6, 0.8, 1]
//   l = lerpn(0,1,5,false);   // Returns: [0, 0.2, 0.4, 0.6, 0.8]
function lerpn(a,b,n,endpoint=true) =
    assert(same_shape(a,b), "\nBad or inconsistent inputs to lerpn.")
    assert(is_int(n))
    assert(is_bool(endpoint))
    let( d = n - (endpoint? 1 : 0) )
    [for (i=[0:1:n-1]) let(u=i/d) (1-u)*a + u*b];

// Function: bilerp()
// Synopsis: Bi-linear interpolation between four values
// Topics: Interpolation, Math
// See Also: lerp()
// Usage:
//   x = bilerp(pts, x, y);
// Description:
//   Compute bilinear interpolation between four values using two
//   coordinates that are meant to lie in [0,1].  (If they are outside
//   this range, the function extrapolates values.)  The `pts`
//   argument is a list of the four values at the for corners, `[A,B,C,D]`.
//   These values are arranged on the corners as shown below.  The `x` and
//   `y` parameters give the fraction of the distance from the left and bottom
//   respectively.  
// Figure(Med,2D,NoScales): The layout of the points for the bilinear interpolation.
//  stroke(square(10),closed=true,width=.5);
//  move([-1,-1])
//  hide("thing")
//  tag_this("thing") square(10)
//    color("black")grid_copies(n=[2,2],spacing=14) text("ABCD"[$idx],size=3);
//  pt=[.6,.7]*10;
//  color("red")move(pt) circle(r=1/2,$fn=12);
//  color("blue"){
//    stroke([[-1.5,.3],[-1.5,pt.y]], width=1/2, color="blue",endcap2="arrow2");
//    stroke([[0,-1.5],[pt.x,-1.5]], width=1/2, color="blue",endcap2="arrow2");
//    fwd(4.5)right(3)text("x",size=2);
//    back(2)left(4)text("y",size=2);
//  }  
// Arguments:
//   points = Four point values at the corners
//   x = First proportional distance
//   y = Second proportional distance
function bilerp(points,x,y) =
     [1,y,x,x*y]*[[1, 0, 0, 0],[-1, 0, 1, 0],[-1,1,0,0],[1,-1,-1,1]]*points;

// Section: Miscellaneous Functions 

// Function: sqr()
// Synopsis: Returns the square of the given value.
// Topics: Math
// See Also: hypot(), log2()
// Usage:
//   x2 = sqr(x);
// Description:
//   If given a number, returns the square of that number,
//   If given a vector, returns the sum-of-squares/dot product of the vector elements.
//   If given a matrix, returns the matrix multiplication of the matrix with itself.
// Example:
//   sqr(3);     // Returns: 9
//   sqr(-4);    // Returns: 16
//   sqr([2,3,4]); // Returns: 29
//   sqr([[1,2],[3,4]]);  // Returns [[7,10],[15,22]]
function sqr(x) = 
    assert(is_finite(x) || is_vector(x) || is_matrix(x), "\nInput is not a number nor a list of numbers.")
    x*x;

// Section: Quantization

// Function: quant()
// Synopsis: Returns `x` quantized to the nearest integer multiple of `y`.
// Topics: Math, Quantization
// See Also: quant(), quantdn(), quantup()
// Usage:
//   num = quant(x, y);
// Description:
//   Quantize a value `x` to an integer multiple of `y`, rounding to the nearest multiple.
//   The value of `y` does NOT have to be an integer.  If `x` is a list, then every item
//   in that list is recursively quantized.
// Arguments:
//   x = The value or list to quantize.
//   y = Positive quantum to quantize to
// Example:
//   a = quant(12,4);    // Returns: 12
//   b = quant(13,4);    // Returns: 12
//   c = quant(13.1,4);  // Returns: 12
//   d = quant(14,4);    // Returns: 16
//   e = quant(14.1,4);  // Returns: 16
//   f = quant(15,4);    // Returns: 16
//   g = quant(16,4);    // Returns: 16
//   h = quant(9,3);     // Returns: 9
//   i = quant(10,3);    // Returns: 9
//   j = quant(10.4,3);  // Returns: 9
//   k = quant(10.5,3);  // Returns: 12
//   l = quant(11,3);    // Returns: 12
//   m = quant(12,3);    // Returns: 12
//   n = quant(11,2.5);  // Returns: 10
//   o = quant(12,2.5);  // Returns: 12.5
//   p = quant([12,13,13.1,14,14.1,15,16],4);  // Returns: [12,12,12,16,16,16,16]
//   q = quant([9,10,10.4,10.5,11,12],3);      // Returns: [9,9,9,12,12,12]
//   r = quant([[9,10,10.4],[10.5,11,12]],3);  // Returns: [[9,9,9],[12,12,12]]
function quant(x,y) =
    assert( is_finite(y) && y>0, "\nThe quantum `y` must be a positive value.")
    is_num(x) ? round(x/y)*y 
              : _roundall(x/y)*y;

function _roundall(data) =
    [for(x=data) is_list(x) ? _roundall(x) : round(x)];

// Function: quantup()
// Synopsis: Returns `x` quantized uo to an integer multiple of `y`.
// Topics: Math, Quantization
// See Also: quant(), quantdn(), quantup()
// Usage:
//   num = quantup(x, y);
// Description:
//   Quantize a value `x` to an integer multiple of `y`, rounding up to the next multiple.
//   The value of `y` does NOT have to be an integer.  If `x` is a list, then every item in
//   that list is recursively quantized up.
// Arguments:
//   x = The value or list to quantize.
//   y = Positive quantum to quantize to.
// Example:
//   a = quantup(12,4);    // Returns: 12
//   b = quantup(13,4);    // Returns: 16
//   c = quantup(13.1,4);  // Returns: 16
//   d = quantup(14,4);    // Returns: 16
//   e = quantup(14.1,4);  // Returns: 16
//   f = quantup(15,4);    // Returns: 16
//   g = quantup(16,4);    // Returns: 16
//   h = quantup(9,3);     // Returns: 9
//   i = quantup(10,3);    // Returns: 12
//   j = quantup(10.4,3);  // Returns: 12
//   k = quantup(10.5,3);  // Returns: 12
//   l = quantup(11,3);    // Returns: 12
//   m = quantup(12,3);    // Returns: 12
//   n = quantdn(11,2.5);  // Returns: 12.5
//   o = quantdn(12,2.5);  // Returns: 12.5
//   p = quantup([12,13,13.1,14,14.1,15,16],4);  // Returns: [12,16,16,16,16,16,16]
//   q = quantup([9,10,10.4,10.5,11,12],3);      // Returns: [9,12,12,12,12,12]
//   r = quantup([[9,10,10.4],[10.5,11,12]],3);  // Returns: [[9,12,12],[12,12,12]]
function quantup(x,y) =
    assert( is_finite(y) && y>0, "\nThe quantum `y` must be a positive value.")
    is_num(x) ? ceil(x/y)*y 
              : _ceilall(x/y)*y;

function _ceilall(data) =
    [for(x=data) is_list(x) ? _ceilall(x) : ceil(x)];

// Section: Constraints and Modulos

// Function: constrain()
// Synopsis: Limit (clamp) a number or array of numbers to a specified range of values.
// Topics: Math
// See Also: posmod(), modang()
// Usage:
//   vals = constrain(v, minval, maxval);
// Description:
//   Returns the value(s) in `v` limited to the range defined by `minval` and `maxval`.
//   This operation is also known as "clamping" in other computer languages.
// Arguments:
//   v = Value(s) to constrain. Can be a numerical value, a 1D vector, a 2D rectangular matrix, or a list of different-length vectors.
//   minval = Minimum value to return. Set to `-INF` to unrestrict the minimum.
//   maxval = Maximum value to return. Set to `INF` to unrestrict the maximum.
// Example:
//   a = constrain(-5, -1, 1);   // Returns: -1
//   b = constrain(5, -1, 1);    // Returns: 1
//   c = constrain(0.3, -1, 1);  // Returns: 0.3
//   d = constrain(9.1, 0, 9);   // Returns: 9
//   e = constrain([1,2,3,4,5,6,7,8,9], 3, 7);          // Returns: [3,3,3,4,5,6,7,7,7]
//   f = constrain([[1,2,3], [4,5,6], [7,8,9]], 3, 7);  // Returns: [[3,3,3], [4,5,6], [7,7,7]]
//   g = constrain([[1,2,3,4], [5,6,7], [8,9]], 3, 7);  // Returns: [[3,3,3,4], [5,6,7], [7,7]]
function constrain(v, minval, maxval) =
    is_num(v) ? max(minval, min(v, maxval))
    : is_vector(v) ? [for(f=v) max(minval, min(f, maxval))]
    : is_matrix(v) ? let( // for a matrix, this should be more efficient than indexing
        mflat = flatten(v),
        clamped = [ for(f=mflat) max(minval, min(f, maxval)) ] 
    ) list_to_matrix(clamped, len(v[0]), 0)
    : is_list(v) ? [ for(vec=v) [ for(f=vec) max(minval, min(f, maxval)) ] ]
    : assert(false, "\nIn constrain(), v must be a number, 1D vector, rectangular matrix, or list of vectors.");

// Function: posmod()
// Synopsis: Returns the positive modulo of a value.
// Topics: Math
// See Also: constrain(), posmod(), modang()
// Usage:
//   mod = posmod(x, m)
// Description:
//   Returns the positive modulo `m` of `x`. The value returned satisfies `0 <= mod < m`.  
// Arguments:
//   x = The value to constrain.
//   m = Modulo value.
// Example:
//   a = posmod(-700,360);  // Returns: 340
//   b = posmod(-270,360);  // Returns: 90
//   c = posmod(-120,360);  // Returns: 240
//   d = posmod(120,360);   // Returns: 120
//   e = posmod(270,360);   // Returns: 270
//   f = posmod(700,360);   // Returns: 340
//   g = posmod(3,2.5);     // Returns: 0.5
function posmod(x,m) = 
    assert( is_finite(x) && is_finite(m) && !approx(m,0) , "\nInput must be finite numbers. The divisor cannot be zero.")
    (x%m+m)%m;

// Function: modang()
// Synopsis: Returns an angle normalized to between -180º and 180º.
// Topics: Math
// See Also: constrain(), posmod(), modang()
// Usage:
//   ang = modang(x);
// Description:
//   Takes an angle in degrees and normalizes it to an equivalent angle value between -180 and 180.
// Example:
//   a1 = modang(-700);  // Returns: 20
//   a2 = modang(-270);  // Returns: 90
//   a3 = modang(-120);  // Returns: -120
//   a4 = modang(120);   // Returns: 120
//   a5 = modang(270);   // Returns: -90
//   a6 = modang(700);   // Returns: -20
function modang(x) =
    assert( is_finite(x), "\nInput must be a finite number.")
    let(xx = posmod(x,360)) xx<180? xx : xx-360;

// Section: Operations on Lists (Sums, Mean, Products)

// Function: sum()
// Synopsis: Returns the sum of a list of values.
// Topics: Math
// See Also: mean(), median(), product(), cumsum()
// Usage:
//   x = sum(v, [dflt]);
// Description:
//   Returns the sum of all entries in the given consistent list.
//   If passed an array of vectors, returns the sum the vectors.
//   If passed an array of matrices, returns the sum of the matrices.
//   If passed an empty list, the value of `dflt` is returned.
// Arguments:
//   v = The list to get the sum of.
//   dflt = The default value to return if `v` is an empty list.  Default: 0
// Example:
//   sum([1,2,3]);  // returns 6.
//   sum([[1,2,3], [3,4,5], [5,6,7]]);  // returns [9, 12, 15]
function sum(v, dflt=0) =
    v==[]? dflt :
    assert(is_consistent(v), "\nInput to sum is non-numeric or inconsistent.")
    is_finite(v[0]) || is_vector(v[0]) ? [for(i=v) 1]*v :
    _sum(v,v[0]*0);

function _sum(v,_total,_i=0) = _i>=len(v) ? _total : _sum(v,_total+v[_i], _i+1);

// Function: mean()
// Synopsis: Returns the mean value of a list of values.
// Topics: Math, Statistics
// See Also: sum(), median(), product()
// Usage:
//   x = mean(v);
// Description:
//   Returns the arithmetic mean/average of all entries in the given array.
//   If passed a list of vectors, returns a vector of the mean of each part.
// Arguments:
//   v = The list of values to get the mean of.
// Example:
//   mean([2,3,4]);  // returns 3.
//   mean([[1,2,3], [3,4,5], [5,6,7]]);  // returns [3, 4, 5]
function mean(v) = 
    assert(is_list(v) && len(v)>0, "\nInvalid list.")
    sum(v)/len(v);

// Function: deltas()
// Synopsis: Returns the deltas between a list of values.
// Topics: Math, Statistics
// See Also: sum(), mean(), median(), product()
// Usage:
//   delts = deltas(v,[wrap]);
// Description:
//   Returns a list with the deltas of adjacent entries in the given list, optionally wrapping back to the front.
//   The list should be a consistent list of numeric components (numbers, vectors, matrix, etc).
//   Given [a,b,c,d], returns [b-a,c-b,d-c].
// Arguments:
//   v = The list to get the deltas of.
//   wrap = If true, wrap back to the start from the end.  ie: return the difference between the last and first items as the last delta.  Default: false
// Example:
//   deltas([2,5,9,17]);  // returns [3,4,8].
//   deltas([[1,2,3], [3,6,8], [4,8,11]]);  // returns [[2,4,5], [1,2,3]]
function deltas(v, wrap=false) = 
    assert( is_consistent(v) && len(v)>1 , "\nInconsistent list or with length<=1.")
    [for (p=pair(v,wrap)) p[1]-p[0]] ;

// Function: cumsum()
// Synopsis: Returns the running cumulative sum of a list of values.
// Topics: Math, Statistics
// See Also: sum(), mean(), median(), product()
// Usage:
//   sums = cumsum(v);
// Description:
//   Returns a list where each item is the cumulative sum of all items up to and including the corresponding entry in the input list.
//   If passed an array of vectors, returns a list of cumulative vectors sums.
// Arguments:
//   v = The list to get the sum of.
// Example:
//   cumsum([1,1,1]);  // returns [1,2,3]
//   cumsum([2,2,2]);  // returns [2,4,6]
//   cumsum([1,2,3]);  // returns [1,3,6]
//   cumsum([[1,2,3], [3,4,5], [5,6,7]]);  // returns [[1,2,3], [4,6,8], [9,12,15]]
function cumsum(v) =
    v==[] ? [] :
    assert(is_consistent(v), "\nThe input is not consistent." )
    [for (a = v[0],
          i = 1
            ;
          i <= len(v)
            ;
          a = i<len(v) ? a+v[i] : a,
          i = i+1)
        a];

// Section: Calculus

// Function: deriv()
// Synopsis: Returns the first derivative estimate of a list of data.
// Topics: Math, Calculus
// See Also: deriv(), deriv2(), deriv3()
// Usage:
//   x = deriv(data, [h], [closed])
// Description:
//   Computes a numerical derivative estimate of the data, which may be scalar or vector valued.
//   The `h` parameter gives the step size of your sampling so the derivative can be scaled correctly. 
//   If the `closed` parameter is true the data is assumed to be defined on a loop with data[0] adjacent to
//   data[len(data)-1].  This function uses a symetric derivative approximation
//   for internal points, f'(t) = (f(t+h)-f(t-h))/2h.  For the endpoints (when closed=false) the algorithm
//   uses a two point method if sufficient points are available: f'(t) = (3*(f(t+h)-f(t)) - (f(t+2*h)-f(t+h)))/2h.
//   .
//   If `h` is a vector then it is assumed to be nonuniform, with h[i] giving the sampling distance
//   between data[i+1] and data[i], and the data values are linearly resampled at each corner
//   to produce a uniform spacing for the derivative estimate.  At the endpoints a single point method
//   is used: f'(t) = (f(t+h)-f(t))/h.  
// Arguments:
//   data = the list of the elements to compute the derivative of.
//   h = the parametric sampling of the data.
//   closed = boolean to indicate if the data set should be wrapped around from the end to the start.
function deriv(data, h=1, closed=false) =
    assert( is_consistent(data) , "\nInput list is not consistent or not numerical.") 
    assert( len(data)>=2, "\nInput `data` should have at least 2 elements.") 
    assert( is_finite(h) || is_vector(h), "\nThe sampling `h` must be a number or a list of numbers.")
    assert( is_num(h) || len(h) == len(data)-(closed?0:1),
            str("\nVector valued `h` must have length ",len(data)-(closed?0:1)))
    is_vector(h) ? _deriv_nonuniform(data, h, closed=closed) :
    let( L = len(data) )
    closed
    ? [
        for(i=[0:1:L-1])
        (data[(i+1)%L]-data[(L+i-1)%L])/2/h
      ]
    : let(
        first = L<3 ? data[1]-data[0] : 
                3*(data[1]-data[0]) - (data[2]-data[1]),
        last = L<3 ? data[L-1]-data[L-2]:
               (data[L-3]-data[L-2])-3*(data[L-2]-data[L-1])
         ) 
      [
        first/2/h,
        for(i=[1:1:L-2]) (data[i+1]-data[i-1])/2/h,
        last/2/h
      ];

function _dnu_calc(f1,fc,f2,h1,h2) =
    let(
        f1 = h2<h1 ? lerp(fc,f1,h2/h1) : f1 , 
        f2 = h1<h2 ? lerp(fc,f2,h1/h2) : f2
       )
    (f2-f1) / 2 / min(h1,h2);

function _deriv_nonuniform(data, h, closed) =
    let( L = len(data) )
    closed
    ? [for(i=[0:1:L-1])
          _dnu_calc(data[(L+i-1)%L], data[i], data[(i+1)%L], select(h,i-1), h[i]) ]
    : [
        (data[1]-data[0])/h[0],
        for(i=[1:1:L-2]) _dnu_calc(data[i-1],data[i],data[i+1], h[i-1],h[i]),
        (data[L-1]-data[L-2])/h[L-2]                            
      ];

// Section: Operations on Functions

// Function: root_find()
// Synopsis: Finds a root of the given continuous function.
// Topics: Math
// See Also: quadratic_roots(), polynomial(), poly_mult(), poly_div(), poly_add(), poly_roots()
// Usage:
//    x = root_find(f, x0, x1, [tol])
// Description:
//    Find a root of the continuous function f where the sign of f(x0) is different
//    from the sign of f(x1).  The function f is a function literal accepting one
//    argument.  You must have a version of OpenSCAD that supports function literals
//    (2021.01 or newer).  The tolerance (tol) specifies the accuracy of the solution:
//    abs(f(x)) < tol * yrange, where yrange is the range of observed function values.
//    This function can find only those roots that *cross* the x axis: it cannot find the
//    the root of x^2.
// Arguments:
//    f = function literal for a scalar-valued single variable function
//    x0 = endpoint of interval to search for root
//    x1 = second endpoint of interval to search for root
//    tol = tolerance for solution.  Default: 1e-15
// Example(2D): Solve x*sin(x)=4
//    f = function (x) x*sin(x)-4;
//    root=root_find(f, 0,25); // root = 15.2284
//        // Graphical verification
//    stroke([for(x=[0:25]) [x,f(x)]],width=.2);
//    color("red")move([root,f(root)])
//        circle(r=.25,$fn=16);


//   The algorithm is based on Brent's method and is a combination of
//   bisection and inverse quadratic approximation, where bisection occurs
//   at every step, with refinement using inverse quadratic approximation
//   only when that approximation gives a good result.  The detail
//   of how to decide when to use the quadratic came from an article
//   by Crenshaw on "The World's Best Root Finder".
//   https://www.embedded.com/worlds-best-root-finder/
function root_find(f,x0,x1,tol=1e-15) =
   let(
        y0 = f(x0),
        y1 = f(x1),
        yrange = y0<y1 ? [y0,y1] : [y1,y0]
   )
   // Check endpoints
   y0==0 || _rfcheck(x0, y0,yrange,tol) ? x0 :
   y1==0 || _rfcheck(x1, y1,yrange,tol) ? x1 :
   assert(y0*y1<0, "\nSign of function must be different at the interval endpoints.")
   _rootfind(f,[x0,x1],[y0,y1],yrange,tol);

function _rfcheck(x,y,range,tol) =
   assert(is_finite(y), str("\nFunction not finite at ",x))
   abs(y) < tol*(range[1]-range[0]);

// xpts and ypts are arrays whose first two entries contain the
// interval bracketing the root.  Extra entries are ignored.
// yrange is the total observed range of y values (used for the
// tolerance test).
function _rootfind(f, xpts, ypts, yrange, tol, i=0) =
    assert(i<100, "\nroot_find did not converge to a solution.")
    let(
         xmid = (xpts[0]+xpts[1])/2,
         ymid = f(xmid),
         yrange = [min(ymid, yrange[0]), max(ymid, yrange[1])]
    )
    _rfcheck(xmid, ymid, yrange, tol) ? xmid :
    let(
         // Force root to be between x0 and midpoint
         y = ymid * ypts[0] < 0 ? [ypts[0], ymid, ypts[1]]
                                : [ypts[1], ymid, ypts[0]],
         x = ymid * ypts[0] < 0 ? [xpts[0], xmid, xpts[1]]
                                : [xpts[1], xmid, xpts[0]],
         v = y[2]*(y[2]-y[0]) - 2*y[1]*(y[1]-y[0])
    )
    v <= 0 ? _rootfind(f,x,y,yrange,tol,i+1)  // Root is between first two points, extra 3rd point doesn't hurt
    :
    let(  // Do quadratic approximation
        B = (x[1]-x[0]) / (y[1]-y[0]),
        C = y*[-1,2,-1] / (y[2]-y[1]) / (y[2]-y[0]),
        newx = x[0] - B * y[0] *(1-C*y[1]),
        newy = f(newx),
        new_yrange = [min(yrange[0],newy), max(yrange[1], newy)],
        // select interval that contains the root by checking sign
        yinterval = newy*y[0] < 0 ? [y[0],newy] : [newy,y[1]],
        xinterval = newy*y[0] < 0 ? [x[0],newx] : [newx,x[1]]
     )
     _rfcheck(newx, newy, new_yrange, tol)
        ? newx
        : _rootfind(f, xinterval, yinterval, new_yrange, tol, i+1);

// onescad: BOSL2/paths.scad
//////////////////////////////////////////////////////////////////////
// LibFile: paths.scad
//   A `path` is a list of points of the same dimensions, usually 2D or 3D, that can
//   be connected together to form a sequence of line segments or a polygon.
//   A `region` is a list of paths that represent polygons, and the functions
//   in this file work on paths and also 1-regions, which are regions
//   that include exactly one path.  When you pass a 1-region to a function, the default
//   value for `closed` is always `true` because regions represent polygons.  
//   Capabilities include computing length of paths, computing
//   path tangents and normals, resampling of paths, and cutting paths up into smaller paths.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Advanced Modeling
// FileSummary: Operations on paths: length, resampling, tangents, splitting into subpaths
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Utility Functions
// Definitions:
//   Point|Points = A list of numbers, also called a vector.  Usually has length 2 or 3 to represent points in the place on points in space.  
//   Pointlist|Pointlists|Point List|Point Lists = An unordered list of {{points}}.
//   Path|Paths = An ordered list of two or more {{points}} specifying a path through space.  Usually points are 2D.  
//   Polygon|Polygons = A {{path}}, usually 2D, that describes a polygon by asuming that the first and last point are connected.

// Function: is_path()
// Synopsis: Returns True if 'list' is a {{path}}.
// Topics: Paths
// See Also: is_region(), is_vnf()
// Usage:
//   is_path(list, [dim], [fast])
// Description:
//   Returns true if `list` is a {{path}}.  A path is a list of two or more numeric vectors (AKA {{points}}).
//   All vectors must of the same size, and must contain numbers that are not inf or nan.
//   By default the vectors in a path must be 2D or 3D.  Set the `dim` parameter to specify a list
//   of allowed dimensions, or set it to `undef` to allow any dimension.  (This function
//   returns `false` on 1-regions.)  
// Example:
//   bool1 = is_path([[3,4],[5,6]]);    // Returns true
//   bool2 = is_path([[3,4]]);          // Returns false
//   bool3 = is_path([[3,4],[4,5]],2);  // Returns true
//   bool4 = is_path([[3,4,3],[5,4,5]],2);  // Returns false
//   bool5 = is_path([[3,4,3],[5,4,5]],3);  // Returns true
//   bool6 = is_path([[3,4,5],undef,[4,5,6]]);  // Returns false
//   bool7 = is_path([[3,5],[undef,undef],[4,5]]);  // Returns false
//   bool8 = is_path([[3,4],[5,6],[5,3]]);     // Returns true
//   bool9 = is_path([3,4,5,6,7,8]);           // Returns false
//   bool10 = is_path([[3,4],[5,6]], dim=[2,3]);// Returns true
//   bool11 = is_path([[3,4],[5,6]], dim=[1,3]);// Returns false
//   bool12 = is_path([[3,4],"hello"], fast=true); // Returns true
//   bool13 = is_path([[3,4],[3,4,5]]);            // Returns false
//   bool14 = is_path([[1,2,3,4],[2,3,4,5]]);      // Returns false
//   bool15 = is_path([[1,2,3,4],[2,3,4,5]],undef);// Returns true
// Arguments:
//   list = list to check
//   dim = list of allowed dimensions of the vectors in the path.  Default: [2,3]
//   fast = set to true for fast check that looks at only the first entry.  Default: false
function is_path(list, dim=[2,3], fast=false) =
    fast
    ?   is_list(list) && is_vector(list[0]) 
    :   is_matrix(list) 
        && len(list)>1 
        && len(list[0])>0
        && (is_undef(dim) || in_list(len(list[0]), force_list(dim)));

// Function: is_1region()
// Synopsis: Returns true if {{path}} is a {{region}} with one component.
// Topics: Paths, Regions
// See Also: force_path()
// Usage:
//   bool = is_1region(path, [name])
// Description:
//   If `path` is a {{region}} with one component (a single-{{path}} region, or 1-region) then returns true.  If path is a region with more components
//   then display an error message about the parameter `name` requiring a path or a single component region.  If the input
//   is not a region then return false.  This function helps path functions accept 1-regions.
// Arguments:
//   path = input to process
//   name = name of parameter to use in error message.  Default: "path"
function is_1region(path, name="path") = 
     !is_region(path)? false
    :assert(len(path)==1,str("\nParameter \"",name,"\" must be a path or singleton region, but is a multicomponent region."))
     true;

// Function: force_path()
// Synopsis: Checks that path is a region with one component.
// SynTags: Path
// Topics: Paths, Regions
// See Also: is_1region()
// Usage:
//   outpath = force_path(path, [name])
// Description:
//   If `path` is a {{region}} with one component (a single-{{path}} region, or 1-region) then returns that component as a path.
//   If `path` is a region with more components then displays an error message about the parameter
//   `name` requiring a path or a single component region.  If the input is not a region then
//   returns the input without any checks.  This function helps path functions accept 1-regions.
// Arguments:
//   path = input to process
//   name = name of parameter to use in error message.  Default: "path"
function force_path(path, name="path") =
   is_region(path) ?
       assert(len(path)==1, str("\nParameter \"",name,"\" must be a path or singleton region, but is a multicomponent region."))
       path[0]
   : path;

/// Internal Function: _path_select()
/// Usage:
///   _path_select(path,s1,u1,s2,u2,[closed]):
/// Description:
///   Returns a portion of a path, from between the `u1` part of segment `s1`, to the `u2` part of
///   segment `s2`.  Both `u1` and `u2` are values between 0.0 and 1.0, inclusive, where 0 is the start
///   of the segment, and 1 is the end.  Both `s1` and `s2` are integers, where 0 is the first segment.
/// Arguments:
///   path = The path to get a section of.
///   s1 = The number of the starting segment.
///   u1 = The proportion along the starting segment, between 0.0 and 1.0, inclusive.
///   s2 = The number of the ending segment.
///   u2 = The proportion along the ending segment, between 0.0 and 1.0, inclusive.
///   closed = If true, treat path as a closed polygon.
function _path_select(path, s1, u1, s2, u2, closed=false) =
    let(
        lp = len(path),
        l = lp-(closed?0:1),
        u1 = s1<0? 0 : s1>l? 1 : u1,
        u2 = s2<0? 0 : s2>l? 1 : u2,
        s1 = constrain(s1,0,l),
        s2 = constrain(s2,0,l),
        pathout = concat(
            (s1<l && u1<1)? [lerp(path[s1],path[(s1+1)%lp],u1)] : [],
            [for (i=[s1+1:1:s2]) path[i]],
            (s2<l && u2>0)? [lerp(path[s2],path[(s2+1)%lp],u2)] : []
        )
    ) pathout;

// Section: Path length calculation


// Function: path_length()
// Synopsis: Returns the path length.
// Topics: Paths
// See Also: path_segment_lengths(), path_length_fractions()
// Usage:
//   path_length(path,[closed])
// Description:
//   Returns the length of the given {{path}}.
// Arguments:
//   path = Path of any dimension or 1-region. 
//   closed = true if the path is closed.  Default: false for paths, true for 1-regions
// Example:
//   path = rect(10);
//   echo(path_length(path));              // Displays 30
//   echo(path_length(path,closed=true));  // Displays 40
function path_length(path,closed) =
    is_1region(path) ? path_length(path[0], default(closed,true)) :
    assert(is_path(path,undef), "\nInvalid path in path_length.")
    let(closed=default(closed,false))
    assert(is_bool(closed))
    len(path)<2? 0 :
    sum([for (i = [0:1:len(path)-2]) norm(path[i+1]-path[i])])+(closed?norm(path[len(path)-1]-path[0]):0);

// Function: path_segment_lengths()
// Synopsis: Returns a list of the lengths of segments in a {{path}}.
// Topics: Paths
// See Also: path_length(), path_length_fractions()
// Usage:
//   path_segment_lengths(path,[closed])
// Description:
//   Returns list of the length of each segment in a path
// Arguments:
//   path = path in any dimension or 1-region
//   closed = true if the path is closed.  Default: false for paths, true for 1-regions
function path_segment_lengths(path, closed) =
    is_1region(path) ? path_segment_lengths(path[0], default(closed,true)) :
    let(closed=default(closed,false))
    assert(is_path(path,undef),"\nInvalid path in path_segment_lengths.")
    assert(is_bool(closed))
    [
        for (i=[0:1:len(path)-2]) norm(path[i+1]-path[i]),
        if (closed) norm(path[0]-last(path))
    ];

/// Internal Function: _path_self_intersections()
/// Usage:
///   isects = _path_self_intersections(path, [closed], [eps]);
/// Description:
///   Locates all self intersection {{points}} of the given {{path}}.  Returns a list of intersections, where
///   each intersection is a list like [POINT, SEGNUM1, PROPORTION1, SEGNUM2, PROPORTION2] where
///   POINT is the coordinates of the intersection point, SEGNUMs are the integer indices of the
///   intersecting segments along the path, and the PROPORTIONS are the 0.0 to 1.0 proportions
///   of how far along those segments they intersect at.  A proportion of 0.0 indicates the start
///   of the segment, and a proportion of 1.0 indicates the end of the segment.
///   .
///   This function does not return self-intersecting segments, only the points
///   where non-parallel segments intersect.  
/// Arguments:
///   path = The path to find self intersections of.
///   closed = If true, treat path like a closed polygon.  Default: true
///   eps = The epsilon error value to determine whether two points coincide.  Default: 1e-9
/// Example(2D):
///   path = [
///       [-100,100], [0,-50], [100,100], [100,-100], [0,50], [-100,-100]
///   ];
///   isects = _path_self_intersections(path, closed=true);
///   // isects == [[[-33.3333, 0], 0, 0.666667, 4, 0.333333], [[33.3333, 0], 1, 0.333333, 3, 0.666667]]
///   stroke(path, closed=true, width=1);
///   for (isect=isects) translate(isect[0]) color("blue") sphere(d=10);
function _path_self_intersections(path, closed=true, eps=_EPSILON) =
    let(
        path = closed ? list_wrap(path,eps=eps) : path,
        plen = len(path)
    )
    [ for (i = [0:1:plen-3]) let(
          a1 = path[i],
          a2 = path[i+1], 
          seg_normal = unit([-(a2-a1).y, (a2-a1).x],[0,0]),
          vals = path*seg_normal,
          ref  = a1*seg_normal,
            // The value of vals[j]-ref is positive if vertex j is one one side of the
            // line [a1,a2] and negative on the other side. Only a segment with opposite
            // signs at its two vertices can have an intersection with segment
            // [a1,a2]. The variable signals is zero when abs(vals[j]-ref) is less than
            // eps and the sign of vals[j]-ref otherwise.  
          signals = [for(j=[i+2:1:plen-(i==0 && closed? 2: 1)]) 
                        abs(vals[j]-ref) <  eps ? 0 : sign(vals[j]-ref) ]
        )
        if(max(signals)>=0 && min(signals)<=0 ) // some remaining edge intersects line [a1,a2]
        for(j=[i+2:1:plen-(i==0 && closed? 3: 2)])
            if( signals[j-i-2]*signals[j-i-1]<=0 ) let( // segm [b1,b2] intersects line [a1,a2]
                b1 = path[j],
                b2 = path[j+1],
                isect = _general_line_intersection([a1,a2],[b1,b2],eps=eps) 
            )
            if (isect 
                && isect[1]>=-eps
                && isect[1]<= 1+eps
                && isect[2]>= -eps 
                && isect[2]<= 1+eps)
                [isect[0], i, isect[1], j, isect[2]]
    ];

// Section: Resampling - changing the number of points in a path
//   Unlike other path related functions, the resampling functions in this section
//   default to `closed=true`, which means they assume the input path represents
//   a polygon.  

// Input `data` is a list that sums to an integer. 
// Returns rounded version of input data so that every 
// entry is rounded to an integer and the sum is the same as
// that of the input.  Works by rounding an entry in the list
// and passing the rounding error forward to the next entry.
// This generally distributes the error in a uniform manner.
function _sum_preserving_round(data, index=0) =
    index == len(data)-1 ? list_set(data, len(data)-1, round(data[len(data)-1])) :
    let(
        newval = round(data[index]),
        error = newval - data[index]
    ) _sum_preserving_round(
        list_set(data, [index,index+1], [newval, data[index+1]-error]),
        index+1
    );

// Function: subdivide_path()
// Synopsis: Subdivides a path to produce a more finely sampled path.
// SynTags: Path
// Topics: Paths, Path Subdivision
// See Also: subdivide_and_slice(), resample_path(), jittered_poly()
// Usage:
//   newpath = subdivide_path(path, n|refine=|maxlen=, [method=], [closed=], [exact=]);
// Description:
//   Takes a {{path}} as input and subdivides the path to produce a more
//   finely sampled path.  By default the path is assumed to describe a closed polygon (`closed=true`).
//   You control the subdivision process by using the `maxlen` arg
//   to specify a maximum segment length, or by specifying `n` or `refine`, which request
//   a certain {{point}} count in the output.
//   .
//   You can specify the point count using the `n` option, where
//   you give the number of points you want in the output, or you can use
//   the `refine` option, where you specify a resampling factor.  If `refine=3` then
//   the number of points would increase by a factor of three, so a four point square would
//   have 12 points after subdivision.  With point-count subdivision, the new points can be distributed
//   proportional to length (`method="length"`), which is the default, or they can be divided up evenly among all the path segments
//   (`method="segment"`).  If the extra points don't fit evenly on the path then the
//   algorithm attempts to distribute them as uniformly as possible, but the result may be uneven.
//   The `exact` option, which is true by default, requires that the final point count is
//   exactly as requested.  For example, if you subdivide a four point square and request `n=13` then one
//   edge will have an extra point compared to the others.  
//   If you set `exact=false` then the
//   algorithm favors uniformity and the output path may have a different number of
//   points than you requested, but the sampling is still uniform.  In our example of the
//   square with `n=13`, you get only 12 points output, with the same number of points on each edge.
//   .
//   The points are always distributed uniformly on each segment.  The `method="length"` option
//   means that the number of points on a segment is based on its length, but the points are still
//   distributed uniformly on each segment, independent of the other segments.  
//   With the `"segment"` method you can also give `n` as a vector of counts.  This 
//   specifies the desired point count on each segment: with vector valued `n` the `subdivide_path`
//   function places `n[i]-1` points on segment `i`.  The reason for the -1 is to avoid
//   double counting the endpoints, which are shared by pairs of segments, so that for
//   a closed polygon the total number of points is sum(n).  With an open
//   path there is an extra point at the end, so the number of points is sum(n)+1.
//   .
//   If you use the `maxlen` option then you specify the maximum length segment allowed in the output.
//   Each segment is subdivided into the largest number of segments meeting your requirement.  As above,
//   the sampling is uniform on each segment, independent of the other segments.  With the `maxlen` option
//   you cannot specify `method` or `exact`.    
// Arguments:
//   path = path in any dimension or a 1-region
//   n = scalar total number of points desired or with `method="segment"` can be a vector requesting `n[i]-1` new points added to segment i.
//   ---
//   refine = increase total number of points by this factor (specify only one of n, refine and maxlen)
//   maxlen = maximum length segment in the output (specify only one of n, refine and maxlen)
//   closed = set to false if the path is open.  Default: true
//   exact = if true return exactly the requested number of points, possibly sacrificing uniformity.  If false, return uniform point sample that may not match the number of points requested.  (Not allowed with maxlen.) Default: true
//   method = One of `"length"` or `"segment"`.  If `"length"`, adds vertices in proportion to segment length, so short segments get fewer points.  If `"segment"`, add points evenly among the segments, so all segments get the same number of points.  (Not allowed with maxlen.) Default: `"length"`
// Example(2D):
//   mypath = subdivide_path(square([2,2],center=true), 12);
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D):
//   mypath = subdivide_path(square([8,2],center=true), 12);
//   move_copies(mypath)circle(r=.2,$fn=32);
// Example(2D):
//   mypath = subdivide_path(square([8,2],center=true), 12, method="segment");
//   move_copies(mypath)circle(r=.2,$fn=32);
// Example(2D):
//   mypath = subdivide_path(square([2,2],center=true), 17, closed=false);
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D): Specifying different numbers of points on each segment
//   mypath = subdivide_path(hexagon(side=2), [2,3,4,5,6,7], method="segment");
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D): Requested point total is 14 but 15 points output due to extra end point
//   mypath = subdivide_path(pentagon(side=2), [3,4,3,4], method="segment", closed=false);
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D): Since 17 is not divisible by 5, a completely uniform distribution is not possible. 
//   mypath = subdivide_path(pentagon(side=2), 17);
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D): With `exact=false` a uniform distribution, but only 15 points
//   mypath = subdivide_path(pentagon(side=2), 17, exact=false);
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D): With `exact=false` you can also get extra points, here 20 instead of requested 18
//   mypath = subdivide_path(pentagon(side=2), 18, exact=false);
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D): Using refine in this example multiplies the point count by 3 by adding 2 points to each edge.
//   mypath = subdivide_path(pentagon(side=2), refine=3);
//   move_copies(mypath)circle(r=.1,$fn=32);
// Example(2D): However, refine doesn't distribute evenly by segment unless you change the method.  With the default method set to `"length"`, the points are distributed with more on the long segments in this example using refine.  
//   mypath = subdivide_path(square([8,2],center=true), refine=3);
//   move_copies(mypath)circle(r=.2,$fn=32);
// Example(2D): In this example with maxlen, every side gets a different number of new points
//   path = [[0,0],[0,4],[10,6],[10,0]];
//   spath = subdivide_path(path, maxlen=2, closed=true);
//   move_copies(spath) circle(r=.25,$fn=12);
// Example(FlatSpin,VPD=15,VPT=[0,0,1.5]): Three-dimensional paths also work
//   mypath = subdivide_path([[0,0,0],[2,0,1],[2,3,2]], 12);
//   move_copies(mypath)sphere(r=.1,$fn=32);
function subdivide_path(path, n, refine, maxlen, closed=true, exact, method) =
    let(path = force_path(path))
    assert(is_path(path,undef), "\nInvalid path or 1-region.")
    assert(num_defined([n,refine,maxlen]), "\nMust give exactly one of n, refine, and maxlen.")
    refine==1 || n==len(path) ? path :
    is_def(maxlen) ?
        assert(is_undef(method), "\nCannot give method with maxlen.")
        assert(is_undef(exact), "\nCannot give exact with maxlen.")
        [
         for (p=pair(path,closed))
           let(steps = ceil(norm(p[1]-p[0])/maxlen))
           each lerpn(p[0], p[1], steps, false),
         if (!closed) last(path)
        ]               
    :
    let(
        exact = default(exact, true),
        method = default(method, "length")
    )
    assert(method=="length" || method=="segment")
    let(
        n = !is_undef(n)? n :
            !is_undef(refine)? len(path) * refine :
            undef
    )
    assert((is_num(n) && n>0) || is_vector(n), "\nParameter n to subdivide_path must be postive number or vector.")
    let(
        count = len(path) - (closed?0:1), 
        add_guess = method=="segment"?
                       (
                          is_list(n)
                          ? assert(len(n)==count, "\nVector parameter n to subdivide_path has the wrong length.")
                            add_scalar(n,-1)
                          : repeat((n-len(path)) / count, count)
                       )
                  : // method=="length"
                    assert(is_num(n), "\nParameter n to subdivide path must be a number when method=\"length\".")
                    let(
                        path_lens = path_segment_lengths(path,closed),
                        add_density = (n - len(path)) / sum(path_lens)
                    )
                    path_lens * add_density,
        add = exact? _sum_preserving_round(add_guess)
                   : [for (val=add_guess) round(val)]
    )
    [
        for (i=[0:1:count-1]) 
           each lerpn(path[i],select(path,i+1), 1+add[i],endpoint=false),
        if (!closed) last(path)
    ];

// Function: resample_path()
// Synopsis: Returns an equidistant set of points along a path.
// SynTags: Path
// Topics: Paths
// See Also: simplify_path(), subdivide_path()
// Usage:
//   newpath = resample_path(path, n|spacing=, [keep_corners=], [closed=]);
// Description:
//   Compute a uniform resampling of the input {{path}}.
//   By default the path is assumed to describe a closed polygon (`closed=true`).
//   If you specify `n` then the output path has `n`
//   {{points}} spaced uniformly (by linear interpolation along the input path segments).  The only points of the
//   input path that are guaranteed to appear in the output path are the starting and ending points, and any
//   points that have an angular deflection of at least the number of degrees given in `keep_corners`.
//   If you specify `spacing` then the length you give is rounded to the nearest spacing that gives
//   a uniform sampling of the path and the resulting uniformly sampled path is returned.
//   .
//   Because this function operates on a discrete input path the quality of the output depends on
//   the sampling of the input.  If you want accurate output, use many points for the input.
// Arguments:
//   path = path in any dimension or a 1-region
//   n = Number of points in output
//   ---
//   spacing = Approximate spacing desired
//   keep_corners = If given a scalar, path vertices with deflection angle greater than this are preserved in the output.
//   closed = set to true if path is closed.  Default: true
// Example(2D):  Subsampling lots of points from a smooth curve
//   path = xscale(2,circle($fn=250, r=10));
//   sampled = resample_path(path, 16);
//   stroke(path);
//   color("red")move_copies(sampled) circle($fn=16);
// Example(2D): Specified spacing is rounded to make a uniform sampling
//   path = xscale(2,circle($fn=250, r=10));
//   sampled = resample_path(path, spacing=17);
//   stroke(path);
//   color("red")move_copies(sampled) circle($fn=16);
// Example(2D): Notice that the corners are excluded.
//   path = square(20);
//   sampled = resample_path(path, spacing=6);
//   stroke(path,closed=true);
//   color("red")move_copies(sampled) circle($fn=16);
// Example(2D): Forcing preservation of corners.
//   path = square(20);
//   sampled = resample_path(path, spacing=6, keep_corners=90);
//   stroke(path,closed=true);
//   color("red")move_copies(sampled) circle($fn=16);
// Example(2D): Closed set to false
//   path = square(20);
//   sampled = resample_path(path, spacing=6,closed=false);
//   stroke(path);
//   color("red")move_copies(sampled) circle($fn=16);
function resample_path(path, n, spacing, keep_corners, closed=true) =
    let(path = force_path(path))
    assert(is_path(path,undef), "\nInvalid path or 1-region.")
    assert(num_defined([n,spacing])==1,"\nMust define exactly one of n and spacing.")
    assert(n==undef || (is_integer(n) && n>0))
    assert(spacing==undef || (is_finite(spacing) && spacing>0))
    assert(is_bool(closed))
    let(
        corners = is_undef(keep_corners)
          ? [0, len(path)-(closed?0:1)]
          : [
                0,
                for (i = [1:1:len(path)-(closed?1:2)])
                    let( ang = abs(modang(vector_angle(select(path,i-1,i+1))-180)) )
                    if (ang >= keep_corners) i,
                len(path)-(closed?0:1),
            ],
        pcnt = len(path),
        plen = path_length(path, closed=closed),
        subpaths = [ for (p = pair(corners)) [for(i = [p.x:1:p.y]) path[i%pcnt]] ],
        n = is_undef(n)? undef : closed? n+1 : n
    )
    assert(n==undef || n >= len(corners), "\nThere are more than `n=` corners whose angle is greater than `keep_corners=`.")
    let(
        lens = [for (subpath = subpaths) path_length(subpath)],
        part_ns = is_undef(n)
          ? [for (i=idx(subpaths)) max(1,round(lens[i]/spacing)-1)]
          : let(
                ccnt = len(corners),
                parts = [for (l=lens) (n-ccnt) * l/plen]
            )
            _sum_preserving_round(parts),
        out = [
            for (i = idx(subpaths))
                let(
                    subpath = subpaths[i],
                    splen = lens[i],
                    pn = part_ns[i] + 1,
                    distlist = lerpn(0, splen, pn, false),
                    cuts = path_cut_points(subpath, distlist, closed=false)
                )
                each column(cuts,0),
            if (!closed) last(path)
        ]
    ) out;

// Function: path_tangents()
// Synopsis: Returns tangent vectors for each point along a path.
// Topics: Paths
// See Also: path_normals()
// Usage:
//   tangs = path_tangents(path, [closed], [uniform]);
// Description:
//   Compute the tangent vector to the input {{path}}.  The derivative approximation is described in deriv().
//   The returned vectors are normalized to length 1.  If any derivatives are zero then
//   the function fails with an error.  If you set `uniform` to false then the sampling is
//   assumed to be non-uniform and the derivative is computed with adjustments to produce corrected
//   values.
// Arguments:
//   path = path of any dimension or a 1-region
//   closed = set to true of the path is closed.  Default: false for paths, true for 1-regions
//   uniform = set to false to correct for non-uniform sampling.  Default: true
// Example(2D): A shape with non-uniform sampling gives distorted derivatives that may be undesirable.  Derivatives tilt toward the long edges of the rectangle.  
//   rect = square([10,3]);
//   tangents = path_tangents(rect,closed=true);
//   stroke(rect,closed=true, width=0.25);
//   color("purple")
//       for(i=[0:len(tangents)-1])
//           stroke([rect[i]-tangents[i], rect[i]+tangents[i]],width=.25, endcap2="arrow2");
// Example(2D): Setting uniform to false corrects the distorted derivatives for this example:
//   rect = square([10,3]);
//   tangents = path_tangents(rect,closed=true,uniform=false);
//   stroke(rect,closed=true, width=0.25);
//   color("purple")
//       for(i=[0:len(tangents)-1])
//           stroke([rect[i]-tangents[i], rect[i]+tangents[i]],width=.25, endcap2="arrow2");
function path_tangents(path, closed, uniform=true) =
    is_1region(path) ? path_tangents(path[0], default(closed,true), uniform) :
    let(closed=default(closed,false))
    assert(is_bool(closed))
    assert(is_path(path,undef))
    !uniform ? [for(t=deriv(path,closed=closed, h=path_segment_lengths(path,closed))) unit(t)]
             : [for(t=deriv(path,closed=closed)) unit(t)];

// Function: path_normals()
// Synopsis: Returns normal vectors for each point along a path.
// Topics: Paths
// See Also: path_tangents()
// Usage:
//   norms = path_normals(path, [tangents], [closed]);
// Description:
//   Compute the normal vector to the input {{path}}.  This vector is perpendicular to the
//   path tangent and lies in the plane of the curve.  For 3d paths we define the plane of the curve
//   at path {{point}} i to be the plane defined by point i and its two neighbors.  At the endpoints of open paths
//   we use the three end points.  For 3d paths the computed normal is the one lying in this plane that points
//   toward the center of curvature at that path point.  For 2D paths, which lie in the xy plane, the normal
//   is the path pointing to the right of the direction the path is traveling.  If points are collinear then
//   a 3d path has no center of curvature, and hence the 
//   normal is not uniquely defined.  In this case the function issues an error.
//   For 2D paths the plane is always defined so the normal fails to exist only
//   when the derivative is zero (in the case of repeated points).
// Arguments:
//   path = 2D or 3D path or a 1-region
//   tangents = path tangents optionally supplied
//   closed = if true path is treated as a polygon.  Default: false for paths, true for 1-regions
function path_normals(path, tangents, closed) =
    is_1region(path) ? path_normals(path[0], tangents, default(closed,true)) :
    let(closed=default(closed,false))
    assert(is_path(path,[2,3]))
    assert(is_bool(closed))
    let(
         tangents = default(tangents, path_tangents(path,closed)),
         dim=len(path[0])
    )
    assert(is_path(tangents) && len(tangents[0])==dim,"\nDimensions of path and tangents must match.")
    [
     for(i=idx(path))
         let(
             pts = i==0 ? (closed? select(path,-1,1) : select(path,0,2))
                 : i==len(path)-1 ? (closed? select(path,i-1,i+1) : select(path,i-2,i))
                 : select(path,i-1,i+1)
        )
        dim == 2 ? [tangents[i].y,-tangents[i].x]
                 : let( v=cross(cross(pts[1]-pts[0], pts[2]-pts[0]),tangents[i]))
                   assert(norm(v)>_EPSILON, "\n3D path contains collinear points.")
                   unit(v)
    ];

// Function: surface_normals()
// Synopsis: Estimates the normals to a surface defined by a {{point}} array
// Topics: Math, Geometry
// See Also: path_tangents(), path_normals()
// Usage:
//   normals = surface_normals(surf, [col_wrap=], [row_wrap=]);
// Description:
//   Numerically estimate the normals to a surface defined by a 2D array of 3d {{points}}, which can
//   also be regarded as an array of {{paths}} (all of the same length).  
// Arguments:
//   surf = surface in 3d defined by a 2D array of points
//   ---
//   row_wrap = if true then wrap path in the row direction (first index)
//   col_wrap = if true then wrap path in the column direction (second index)
function surface_normals(surf, col_wrap=false, row_wrap=false) =
  let(
      rowderivs = [for(y=[0:1:len(surf)-1])  path_tangents(surf[y],closed=col_wrap)],
      colderivs = [for(x=[0:1:len(surf[0])-1]) path_tangents(column(surf,x), closed=row_wrap)]
  )
  [for(y=[0:1:len(surf)-1])
     [for(x=[0:1:len(surf[0])-1])
         cross(colderivs[x][y],rowderivs[y][x])]];

// Function: path_cut_points()
// Synopsis: Returns a list of cut {{points}} at a list of distances from the first point in a {{path}}.
// Topics: Paths, Path Subdivision
// See Also: path_cut(), split_path_at_self_crossings()
// Usage:
//   cuts = path_cut_points(path, cutdist, [closed=], [direction=]);
//
// Description:
//   Cuts a {{path}} at a list of distances from the first {{point}} in the path.  Returns a list of the cut
//   points and indices of the next point in the path after that point.  So for example, a return
//   value entry of [[2,3], 5] means that the cut point was [2,3] and the next point on the path after
//   this point is path[5].  If the path is too short then path_cut_points asserts an error.  If you set
//   `direction` to true then `path_cut_points` also returns the tangent vector to the path and a normal
//   vector to the path.  It tries to find a normal vector that is coplanar to the path near the cut
//   point.  If this fails, it returns a normal vector parallel to the xy plane.  The output with
//   direction vectors are in the form `[point, next_index, tangent, normal]`.
//   .
//   If you give the last point of the path as a cut point, then the returned index is
//   one larger than the last index (so it would not be a valid index).  If you use the closed
//   option then the returned index is equal to the path length for cuts along the closing
//   path segment, and if you give a point equal to the path length you get an
//   index of len(path)+1 for the index.  
//
// Arguments:
//   path = path to cut
//   cutdist = distances where the path should be cut (a list) or a scalar single distance
//   ---
//   closed = set to true if the curve is closed.  Default: false for paths, true for 1-regions
//   direction = set to true to return direction vectors.  Default: false
//
// Example(NORENDER):
//   square=[[0,0],[1,0],[1,1],[0,1]];
//   path_cut_points(square, [.5,1.5,2.5]);   // Returns [[[0.5, 0], 1], [[1, 0.5], 2], [[0.5, 1], 3]]
//   path_cut_points(square, [0,1,2,3]);      // Returns [[[0, 0], 1], [[1, 0], 2], [[1, 1], 3], [[0, 1], 4]]
//   path_cut_points(square, [0,0.8,1.6,2.4,3.2], closed=true);  // Returns [[[0, 0], 1], [[0.8, 0], 1], [[1, 0.6], 2], [[0.6, 1], 3], [[0, 0.8], 4]]
//   path_cut_points(square, [0,0.8,1.6,2.4,3.2]);               // Returns [[[0, 0], 1], [[0.8, 0], 1], [[1, 0.6], 2], [[0.6, 1], 3], undef]
function path_cut_points(path, cutdist, closed=false, direction=false) =
    let(long_enough = len(path) >= (closed ? 3 : 2))
    assert(long_enough,len(path)<2 ? "\nTwo points needed to define a path." : "\nClosed path must include three points.")
    is_num(cutdist) ? path_cut_points(path, [cutdist], closed, direction)[0] :
    cutdist == []? [] :
    assert(is_vector(cutdist))
    assert(is_increasing(cutdist), "\nCut distances must be an increasing list.")
    assert(cutdist[0]>=0, str("Cut distances must be non-negative.  Got: ", cutdist[0]))
    let(cuts = path_cut_points_recurse(path,cutdist,closed))
    !direction
       ? cuts
       : let(
             dir = _path_cuts_dir(path, cuts, closed),
             normals = _path_cuts_normals(path, cuts, dir, closed)
         )
         hstack(cuts, list_to_matrix(dir,1), list_to_matrix(normals,1));

// Main recursive path cut function
function path_cut_points_recurse(path, dists, closed=false, pind=0, dtotal=0, dind=0, result=[]) =
    dind == len(dists) ? result :
    let(
        lastpt = len(result)==0? [] : last(result)[0],       // location of last cut point
        dpartial = len(result)==0? 0 : norm(lastpt-select(path,pind)),  // remaining length in segment
        nextpoint = dists[dind] < dpartial+dtotal  // Do we have enough length left on the current segment?
           ? [lerp(lastpt,select(path,pind),(dists[dind]-dtotal)/dpartial),pind] 
           : _path_cut_single(path, dists[dind]-dtotal-dpartial, closed, pind)
    ) 
    path_cut_points_recurse(path, dists, closed, nextpoint[1], dists[dind],dind+1, concat(result, [nextpoint]));

// Search for a single cut point in the path
function _path_cut_single(path, dist, closed=false, ind=0, eps=1e-7) =
    // If we get to the end of the path (ind is last point or wraparound for closed case) then
    // check if we are within epsilon of the final path point.  If not we're out of path, so we fail
    ind==len(path)-(closed?0:1) ?
       assert(dist<eps,"\nPath is too short for specified cut distance.")
       [select(path,ind),ind+1]
    :let(d = norm(path[ind]-select(path,ind+1))) d > dist ?
        [lerp(path[ind],select(path,ind+1),dist/d), ind+1] :
        _path_cut_single(path, dist-d,closed, ind+1, eps);

// Find normal directions to the path, coplanar to local part of the path
// Or return a vector parallel to the x-y plane if the above fails
function _path_cuts_normals(path, cuts, dirs, closed=false) =
    [for(i=[0:len(cuts)-1])
        len(path[0])==2? [-dirs[i].y, dirs[i].x]
          : 
            let(
                plane = len(path)<3 ? undef :
                let(start = max(min(cuts[i][1],len(path)-1),2)) _path_plane(path, start, start-2)
            )
            plane==undef?
                ( dirs[i].x==0 && dirs[i].y==0 ? [1,0,0]  // If it's z direction return x vector
                                               : unit([-dirs[i].y, dirs[i].x,0])) // otherwise perpendicular to projection
                : unit(cross(dirs[i],cross(plane[0],plane[1])))
    ];

// Scan from the specified point (ind) to find a noncoplanar triple to use
// to define the plane of the path.
function _path_plane(path, ind, i,closed) =
    i<(closed?-1:0) ? undef :
    !is_collinear(path[ind],path[ind-1], select(path,i))?
        [select(path,i)-path[ind-1],path[ind]-path[ind-1]] :
        _path_plane(path, ind, i-1);

// Find the direction of the path at the cut points
function _path_cuts_dir(path, cuts, closed=false, eps=1e-2) =
    [for(ind=[0:len(cuts)-1])
        let(
            zeros = path[0]*0,
            nextind = cuts[ind][1],
            nextpath = unit(select(path, nextind+1)-select(path, nextind),zeros),
            thispath = unit(select(path, nextind) - select(path,nextind-1),zeros),
            lastpath = unit(select(path,nextind-1) - select(path, nextind-2),zeros),
            nextdir =
                nextind==len(path) && !closed? lastpath :
                (nextind<=len(path)-2 || closed) && approx(cuts[ind][0], path[nextind],eps)
                   ? unit(nextpath+thispath)
              : (nextind>1 || closed) && approx(cuts[ind][0],select(path,nextind-1),eps)
                   ? unit(thispath+lastpath)
              :  thispath
        ) nextdir
    ];

// Function: split_path_at_self_crossings()
// Synopsis: Split a 2D {{path}} wherever it crosses itself.
// SynTags: PathList
// Topics: Paths, Path Subdivision
// See Also: path_cut(), path_cut_points()
// Usage:
//   paths = split_path_at_self_crossings(path, [closed], [eps]);
// Description:
//   Splits a 2D {{path}} into sub-paths wherever the original path crosses itself.
//   By default the path is assumed to describe a closed polygon (`closed=true`).
//   Splits may occur mid-segment, so new vertices are created at the intersection points.
//   Returns a list of the resulting subpaths.  
// Arguments:
//   path = A 2D path or a 1-region.
//   closed = If true, treat path as a closed polygon.  Default: true
//   eps = Acceptable variance.  Default: 1e-9
// Example(2D,NoAxes):
//   path = [ [-100,100], [0,-50], [100,100], [100,-100], [0,50], [-100,-100] ];
//   paths = split_path_at_self_crossings(path);
//   rainbow(paths) stroke($item, closed=false, width=3);
function split_path_at_self_crossings(path, closed=true, eps=_EPSILON) =
    let(path = force_path(path))
    assert(is_path(path,2), "\nMust give a 2D path.")
    assert(is_bool(closed))
    let(
        path = list_unwrap(path, eps=eps),
        isects = deduplicate(
            eps=eps,
            concat(
                [[0, 0]],
                sort([
                    for (
                        a = _path_self_intersections(path, closed=closed, eps=eps),
                        ss = [ [a[1],a[2]], [a[3],a[4]] ]
                    ) if (ss[0] != undef) ss
                ]),
                [[len(path)-(closed?1:2), 1]]
            )
        )
    ) [
        for (p = pair(isects))
            let(
                s1 = p[0][0],
                u1 = p[0][1],
                s2 = p[1][0],
                u2 = p[1][1],
                section = _path_select(path, s1, u1, s2, u2, closed=closed),
                outpath = deduplicate(eps=eps, section)
            )
            if (len(outpath)>1) outpath
    ];

function _extreme_angle_fragment(seg, fragments, rightmost=true, eps=_EPSILON) =
    !fragments? [undef, []] :
    let(
        delta = seg[1] - seg[0],
        segang = atan2(delta.y,delta.x),
        frags = [
            for (i = idx(fragments)) let(
                fragment = fragments[i],
                fwdmatch = approx(seg[1], fragment[0], eps=eps),
                bakmatch =  approx(seg[1], last(fragment), eps=eps)
            ) [
                fwdmatch,
                bakmatch,
                bakmatch? reverse(fragment) : fragment
            ]
        ],
        angs = [
            for (frag = frags)
                (frag[0] || frag[1])? let(
                    delta2 = frag[2][1] - frag[2][0],
                    segang2 = atan2(delta2.y, delta2.x)
                ) modang(segang2 - segang) : (
                    rightmost? 999 : -999
                )
        ],
        fi = rightmost? min_index(angs) : max_index(angs)
    ) abs(angs[fi]) > 360? [undef, fragments] : let(
        remainder = [for (i=idx(fragments)) if (i!=fi) fragments[i]],
        frag = frags[fi],
        foundfrag = frag[2]
    ) [foundfrag, remainder];

/// Internal Function: _assemble_a_path_from_fragments()
/// Usage:
///   _assemble_a_path_from_fragments(subpaths);
/// Description:
///   Given a list of paths, assembles them together into one complete closed polygon path, and
///   remainder fragments.  Returns [PATH, FRAGMENTS] where FRAGMENTS is the list of remaining
///   unused path fragments.
/// Arguments:
///   fragments = List of paths to be assembled into complete polygons.
///   rightmost = If true, assemble paths using rightmost turns. Leftmost if false.
///   startfrag = The fragment to start with.  Default: 0
///   eps = The epsilon error value to determine whether two points coincide.  Default: 1e-9
function _assemble_a_path_from_fragments(fragments, rightmost=true, startfrag=0, eps=_EPSILON) =
    len(fragments)==0? [[],[]] :
    len(fragments)==1? [fragments[0],[]] :
    let(
        path = fragments[startfrag],
        newfrags = [for (i=idx(fragments)) if (i!=startfrag) fragments[i]]
    ) are_ends_equal(path, eps=eps)? (
        // starting fragment is already closed
        [path, newfrags]
    ) : let(
        // Find rightmost/leftmost continuation fragment
        seg = select(path,-2,-1),
        extrema = _extreme_angle_fragment(seg=seg, fragments=newfrags, rightmost=rightmost, eps=eps),
        foundfrag = extrema[0],
        remainder = extrema[1]
    ) is_undef(foundfrag)? (
        // No remaining fragments connect!  INCOMPLETE PATH!
        // Treat it as complete.
        [path, remainder]
    ) : are_ends_equal(foundfrag, eps=eps)? (
        // Found fragment is already closed
        [foundfrag, concat([path], remainder)]
    ) : let(
        fragend = last(foundfrag),
        hits = [for (i = idx(path,e=-2)) if(approx(path[i],fragend,eps=eps)) i]
    ) hits? (
        let(
            // Found fragment intersects with initial path
            hitidx = last(hits),
            newpath = list_head(path,hitidx),
            newfrags = concat(len(newpath)>1? [newpath] : [], remainder),
            outpath = concat(slice(path,hitidx,-2), foundfrag)
        )
        [outpath, newfrags]
    ) : let(
        // Path still incomplete.  Continue building it.
        newpath = concat(path, list_tail(foundfrag)),
        newfrags = concat([newpath], remainder)
    )
    _assemble_a_path_from_fragments(
        fragments=newfrags,
        rightmost=rightmost,
        eps=eps
    );

/// Internal Function: _assemble_path_fragments()
/// Usage:
///   _assemble_path_fragments(subpaths);
/// Description:
///   Given a list of paths, assembles them together into complete closed polygon paths if it can.
///   Polygons with area < eps are discarded and not returned.  
/// Arguments:
///   fragments = List of paths to be assembled into complete polygons.
///   eps = The epsilon error value to determine whether two points coincide.  Default: 1e-9
function _assemble_path_fragments(fragments, eps=_EPSILON, _finished=[]) =
    len(fragments)==0? _finished :
    let(
        minxidx = min_index([
            for (frag=fragments) min(column(frag,0))
        ]),
        result_l = _assemble_a_path_from_fragments(
            fragments=fragments,
            startfrag=minxidx,
            rightmost=false,
            eps=eps
        ),
        result_r = _assemble_a_path_from_fragments(
            fragments=fragments,
            startfrag=minxidx,
            rightmost=true,
            eps=eps
        ),
        l_area = abs(polygon_area(result_l[0])),
        r_area = abs(polygon_area(result_r[0])),
        result = l_area < r_area? result_l : result_r,
        newpath = list_unwrap(result[0]),
        remainder = result[1],
        finished = min(l_area,r_area)<eps ? _finished : concat(_finished, [newpath])
    ) _assemble_path_fragments(
        fragments=remainder,
        eps=eps,
        _finished=finished
    );

/// Different but similar path assembly function that is much faster than
/// _assemble_path_fragments and can work in 3d, but cannot handle loops.
///
/// Takes a list of paths that are in the correct direction and assembles
/// them into a list of paths.  Returns a list of assembled paths.
/// If `closed=false` then any paths that are closed have duplicate
/// endpoints, and open paths do not have duplicate endpoints.
/// If `closed=true` then all paths are assumed closed and none of the returned
/// paths have duplicate endpoints.
///
/// It is assumed that the paths do not intersect each other.
/// Paths can be in any dimension
function _assemble_partial_paths(paths, closed=false, eps=1e-7) =
    let(
        pathlist = _assemble_partial_paths_recur(paths, eps)
        //// this eliminates crossing paths that cross only at vertices in the input paths lists
        // splitpaths =
        //     [for(path=pathlist) each
        //        let(
        //            searchlist = vector_search(path,eps,path),
        //            duplist = [for(i=idx(searchlist)) if (len(searchlist[i])>1) i]
        //        )
        //        duplist==[] ? [path]
        //       :               
        //        let(
        //            fragments = [for(i=idx(duplist)) select(path, duplist[i], select(duplist,i+1))]
        //        )
        //        len(fragments)==1 ? fragments
        //                          : _assemble_path_fragments(fragments)
        //     ]
    )
    closed ? [for(path=pathlist) list_unwrap(path)] : pathlist;

function _assemble_partial_paths_recur(edges, eps, paths=[], i=0) =
    i==len(edges) ? paths :
    norm(edges[i][0]-last(edges[i]))<eps ? _assemble_partial_paths_recur(edges, eps, paths,i+1) :
    let(    // Find paths that connects on left side and right side of the edges (if one exists)
        
        left = [for(j=idx(paths)) if (approx(last(paths[j]),edges[i][0],eps)) j],
        right = [for(j=idx(paths)) if (approx(last(edges[i]),paths[j][0],eps)) j]
    )
    let(
        keep_path = list_remove(paths,[if (len(left)>0) left[0],if (len(right)>0) right[0]]),
        update_path =  left==[] && right==[] ? edges[i]
                    : left==[] ? concat(list_head(edges[i]),paths[right[0]])
                    : right==[] ?  concat(paths[left[0]],slice(edges[i],1,-1))
                    : left[0] != right[0] ? concat(paths[left[0]],slice(edges[i],1,-2), paths[right[0]])
                    : concat(paths[left[0]], slice(edges[i],1,-1)) // last arg -2 removes duplicate endpoints but this is handled in passthrough function
    )
    _assemble_partial_paths_recur(edges, eps, concat(keep_path, [update_path]), i+1);

// onescad: BOSL2/lists.scad
//////////////////////////////////////////////////////////////////////
// LibFile: lists.scad
//   Functions for operating on generic lists.  Provides functiosn for indexing lists, changing list
//   structure, and constructing lists by rearranging or modifying another list. 
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Data Management
// FileSummary: List indexing, change list structure, rearrange/modify lists
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Terminology:
//   **List** = An ordered collection of zero or more arbitrary items.  ie: `["a", "b", "c"]`, or `[3, "a", [4,5]]`
//   **Vector** = A list of numbers. ie: `[4, 5, 6]`
//   **Set** = A list of unique items.

// Section: List Query Operations

// Function: is_homogeneous()
// Alias: is_homogenous()
// Synopsis: Returns true if all members of a list are of the same type.
// Topics: List Handling, Type Checking
// See Also: is_vector(), is_matrix()
// Usage:
//   bool = is_homogeneous(list, [depth]);
// Description:
//   Returns true when the list has elements of same type up to the depth `depth`.
// Arguments:
//   l = the list to check
//   depth = the lowest level the check is done.  Default: 10
// Example:
//   a = is_homogeneous([[1,["a"]], [2,["b"]]]);     // Returns true
//   b = is_homogeneous([[1,["a"]], [2,[true]]]);    // Returns false
//   c = is_homogeneous([[1,["a"]], [2,[true]]], 1); // Returns true
//   d = is_homogeneous([[1,["a"]], [2,[true]]], 2); // Returns false
//   e = is_homogeneous([[1,["a"]], [true,["b"]]]);  // Returns false
function is_homogeneous(l, depth=10) =
    !is_list(l) || l==[] ? false :
    let( l0=l[0] )
    [] == [for(i=[1:1:len(l)-1]) if( ! _same_type(l[i],l0, depth+1) )  0 ];

function _same_type(a,b, depth) = 
    (depth==0) ||
    (is_undef(a) && is_undef(b)) ||
    (is_bool(a) && is_bool(b)) ||
    (is_num(a) && is_num(b)) ||
    (is_string(a) && is_string(b)) ||
    (is_list(a) && is_list(b) && len(a)==len(b) 
          && []==[for(i=idx(a)) if( ! _same_type(a[i],b[i],depth-1) ) 0] );

// Function: min_length()
// Synopsis: Given a list of sublists, returns the length of the shortest sublist.
// Topics: List Handling
// See Also: max_length()
// Usage:
//   llen = min_length(list);
// Description:
//   Returns the length of the shortest sublist in a list of lists.
// Arguments:
//   list = A list of lists.
// Example:
//   slen = min_length([[3,4,5],[6,7,8,9]]);  // Returns: 3
function min_length(list) =
    assert(is_list(list), "Invalid input." )
    min([for (v = list) len(v)]);

// Function: max_length()
// Synopsis: Given a list of sublists, returns the length of the longest sublist.
// Topics: List Handling
// See Also: min_length()
// Usage:
//   llen = max_length(list);
// Description:
//   Returns the length of the longest sublist in a list of lists.
// Arguments:
//   list = A list of lists.
// Example:
//   llen = max_length([[3,4,5],[6,7,8,9]]);  // Returns: 4
function max_length(list) =
    assert(is_list(list), "Invalid input." )
    max([for (v = list) len(v)]);

function _list_shape_recurse(v) =
    let( alen = [for(vi=v) is_list(vi) ? len(vi): -1] )
    v==[] || max(alen)==-1 ? [] :
    let( add = max(alen)!=min(alen) ? undef : alen[0] ) 
    concat( add, _list_shape_recurse(flatten(v)));

// Function: list_shape()
// Synopsis: Returns the dimensions of an array.
// Topics: Matrices, List Handling
// See Also: is_homogenous()
// Usage:
//   dims = list_shape(v, [depth]);
// Description:
//   Returns the size of a multi-dimensional array, a list of the lengths at each depth.
//   If the returned value has `dims[i] = j` then it means the ith index ranges of j items.
//   The return `dims[0]` is equal to the length of v.  Then `dims[1]` is equal to the
//   length of the lists in v, and in general, `dims[i]` is equal to the length of the items
//   nested to depth i in the list v.  If the length of items at that depth is inconsistent, then
//   `undef` is returned.  If no items exist at that depth then `0` is returned.  Note that
//   for simple vectors or matrices it is faster to compute `len(v)` and `len(v[0])`.  
// Arguments:
//   v = list to get shape of
//   depth = depth to compute the size of.  If not given, returns a list of sizes at all depths. 
// Example:
//   a = list_shape([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]]);     // Returns [2,2,3]
//   b = list_shape([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]], 0);  // Returns 2
//   c = list_shape([[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]], 2);  // Returns 3
//   d = list_shape([[[1,2,3],[4,5,6]],[[7,8,9]]]);                // Returns [2,undef,3]
function list_shape(v, depth=undef) =
    assert( is_undef(depth) || ( is_finite(depth) && depth>=0 ), "Invalid depth.")
    ! is_list(v) ? 0 :
    (depth == undef)
    ?   concat([len(v)], _list_shape_recurse(v))
    :   (depth == 0)
        ?  len(v)
        :  let( dimlist = _list_shape_recurse(v))
           (depth > len(dimlist))? 0 : dimlist[depth-1] ;

// Function: in_list()
// Synopsis: Returns true if a value is in a list.
// Topics: List Handling
// See Also: select(), slice()
// Usage:
//   bool = in_list(val, list, [idx]);
// Description:
//   Returns true if value `val` is in list `list`. When `val==NAN` the answer will be false for any list.
// Arguments:
//   val = The simple value to search for.
//   list = The list to search.
//   idx = If given, searches the given columns for matches for `val`.
// Example:
//   a = in_list("bar", ["foo", "bar", "baz"]);  // Returns true.
//   b = in_list("bee", ["foo", "bar", "baz"]);  // Returns false.
//   c = in_list("bar", [[2,"foo"], [4,"bar"], [3,"baz"]], idx=1);  // Returns true.

// Note that a huge complication occurs because OpenSCAD's search() finds
// index i as a hits if the val equals list[i] but also if val equals list[i][0].
// This means every hit needs to be checked to see if it's actually a hit,
// and if the first hit is a mismatch we have to keep searching.
// We assume that the normal case doesn't have mixed data, and try first
// with just one hit, but if this finds a mismatch then we try again
// with all hits, which could be slow for long lists.
function in_list(val,list,idx) = 
    assert(is_list(list),"Input is not a list")
    assert(is_undef(idx) || is_finite(idx), "Invalid idx value.")
    let( firsthit = search([val], list, num_returns_per_match=1, index_col_num=idx)[0] )
    firsthit==[] ? false
    : is_undef(idx) && val==list[firsthit] ? true
    : is_def(idx) && val==list[firsthit][idx] ? true
    // first hit was found but didn't match, so try again with all hits
    : let ( allhits = search([val], list, 0, idx)[0])
      is_undef(idx) ? [for(hit=allhits) if (list[hit]==val) 1] != []
    : [for(hit=allhits) if (list[hit][idx]==val) 1] != [];

// Section: List Indexing

// Function: select()
// Synopsis: Returns one or more items from a list, with wrapping.
// Topics: List Handling
// See Also: slice(), column(), last()
// Description:
//   Returns a portion of a list, wrapping around past the beginning, if end<start. 
//   The first item is index 0. Negative indexes are counted back from the end.
//   The last item is -1.  If only the `start` index is given, returns just the value
//   at that position when `start` is a number or the selected list of entries when `start` is
//   a list of indices or a range.
// Usage:
//   item = select(list, start);
//   item = select(list, [s:d:e]);
//   item = select(list, [i0,i1...,ik]);
//   list = select(list, start, end);
// Arguments:
//   list = The list to get the portion of.
//   start = Either the index of the first item or an index range or a list of indices.
//   end = The index of the last item when `start` is a number. When `start` is a list or a range, `end` should not be given.
// Example:
//   l = [3,4,5,6,7,8,9];
//   a = select(l, 5, 6);   // Returns [8,9]
//   b = select(l, 5, 8);   // Returns [8,9,3,4]
//   c = select(l, 5, 2);   // Returns [8,9,3,4,5]
//   d = select(l, -3, -1); // Returns [7,8,9]
//   e = select(l, 3, 3);   // Returns [6]
//   f = select(l, 4);      // Returns 7
//   g = select(l, -2);     // Returns 8
//   h = select(l, [1:3]);  // Returns [4,5,6]
//   i = select(l, [3,1]);  // Returns [6,4]
function select(list, start, end) =
    assert( is_list(list) || is_string(list), "Invalid list.")
    let(l=len(list))
    l==0
      ? []
      : end==undef
          ? is_num(start)
              ? list[ (start%l+l)%l ]
              : assert( start==[] || is_vector(start) || is_range(start), "Invalid start parameter")
                [for (i=start) list[ (i%l+l)%l ] ]
          : assert(is_finite(start), "When `end` is given, `start` parameter should be a number.")
            assert(is_finite(end), "Invalid end parameter.")
            let( s = (start%l+l)%l, e = (end%l+l)%l )
            (s <= e)
              ? [ for (i = [s:1:e])   list[i] ]
              : [ for (i = [s:1:l-1]) list[i], 
                  for (i = [0:1:e])   list[i] ] ;

// Function: slice()
// Synopsis: Returns part of a list without wrapping.
// Topics: List Handling
// See Also: select(), column(), last()
// Usage:
//   list = slice(list, s, e);
// Description:
//   Returns a slice of a list, from the first position `s` up to and including the last position `e`.
//   The first item in the list is at index 0.  Negative indexes are counted back from the end, with
//   -1 referring to the last list item.  If `s` is after `e` then the empty list is returned.
//   If an index is off the start/end of the list it will refer to the list start/end.  
// Arguments:
//   list = The list to get the slice of.
//   start = The index of the first item to return.  Default: 0
//   end = The index of the last item to return.  Default: -1 (last item)
// Example:
//   a = slice([3,4,5,6,7,8,9], 3, 5);   // Returns [6,7,8]
//   b = slice([3,4,5,6,7,8,9], 2, -1);  // Returns [5,6,7,8,9]
//   c = slice([3,4,5,6,7,8,9], 1, 1);   // Returns [4]
//   d = slice([3,4,5,6,7,8,9], 5);      // Returns [8,9]
//   e = slice([3,4,5,6,7,8,9], 2, -2);  // Returns [5,6,7,8]
//   f = slice([3,4,5,6,7,8,9], 4, 3);   // Returns []
//   g = slice([3,4,5], 1, 5);           // Returns [4,5]
//   h = slice([3,4,5], 5, 7);           // Returns []
function slice(list,start=0,end=-1) =
    assert(is_list(list))
    assert(is_int(start))
    assert(is_int(end))
    !list? [] :
    let(
        l = len(list),
        start = start+(start<0 ? l : 0),
        end = end + (end<0? l : 0)
    )
    [if (start<=end && end>=0 && start<=l) for (i=[max(start,0):1:min(end,l-1)]) list[i]];

// Function: last()
// Synopsis: Returns the last item of a list.
// Topics: List Handling
// See Also: select(), slice(), column()
// Usage:
//   item = last(list);
// Description:
//   Returns the last element of a list, or undef if empty.
// Arguments:
//   list = The list to get the last element of.
// Example:
//   l = [3,4,5,6,7,8,9];
//   x = last(l);  // Returns 9.
function last(list) =
    list[len(list)-1];

// Function: list_head()
// Synopsis: Returns the elements at the beginning of a list.
// Topics: List Handling
// See Also: select(), slice(), list_tail(), last()
// Usage:
//   list = list_head(list, [to]);
// Description:
//   Returns the head of the given list, from the first item up until the `to` index, inclusive.
//   By default returns all but the last element of the list.  
//   If the `to` index is negative, then the length of the list is added to it, such that
//   `-1` is the last list item.  `-2` is the second from last.  `-3` is third from last, etc.
//   If the list is shorter than the given index, then the full list is returned.
// Arguments:
//   list = The list to get the head of.
//   to = The last index to include.  If negative, adds the list length to it.  ie: -1 is the last list item.  Default: -2
// Example:
//   hlist1 = list_head(["foo", "bar", "baz"]);  // Returns: ["foo", "bar"]
//   hlist2 = list_head(["foo", "bar", "baz"], -3); // Returns: ["foo"]
//   hlist3 = list_head(["foo", "bar", "baz"], 1);  // Returns: ["foo","bar"]
//   hlist4 = list_head(["foo", "bar", "baz"], -5); // Returns: []
//   hlist5 = list_head(["foo", "bar", "baz"], 5);  // Returns: ["foo","bar","baz"]
function list_head(list, to=-2) =
   assert(is_list(list))
   assert(is_finite(to))
   to<0? [for (i=[0:1:len(list)+to]) list[i]] :
   to<len(list)? [for (i=[0:1:to]) list[i]] :
   list;

// Function: list_tail()
// Synopsis: Returns the elements at the end of a list.
// Topics: List Handling
// See Also: select(), slice(), list_tail(), last()
// Usage:
//   list = list_tail(list, [from]);
// Description:
//   Returns the tail of the given list, from the `from` index up until the end of the list, inclusive.
//   By default returns all but the first item.  
//   If the `from` index is negative, then the length of the list is added to it, such that
//   `-1` is the last list item.  `-2` is the second from last.  `-3` is third from last, etc.
//   If you want it to return the last three items of the list, use `from=-3`.
// Arguments:
//   list = The list to get the tail of.
//   from = The first index to include.  If negative, adds the list length to it.  ie: -1 is the last list item.  Default: 1.
// Example:
//   tlist1 = list_tail(["foo", "bar", "baz"]);  // Returns: ["bar", "baz"]
//   tlist2 = list_tail(["foo", "bar", "baz"], -1); // Returns: ["baz"]
//   tlist3 = list_tail(["foo", "bar", "baz"], 2);  // Returns: ["baz"]
//   tlist4 = list_tail(["foo", "bar", "baz"], -5); // Returns: ["foo","bar","baz"]
//   tlist5 = list_tail(["foo", "bar", "baz"], 5);  // Returns: []
function list_tail(list, from=1) =
   assert(is_list(list))
   assert(is_finite(from))
   from>=0? [for (i=[from:1:len(list)-1]) list[i]] :
   let(from = from + len(list))
   from>=0? [for (i=[from:1:len(list)-1]) list[i]] :
   list;

// Function: bselect()
// Synopsis: Select list items using boolean index list.
// Topics: List Handling
// See Also: list_bset()
// Usage:
//   sublist = bselect(list, index);
// Description:
//   Returns the items in `list` whose matching element in `index` evaluates as true.  
// Arguments:
//   list = Initial list (or string) to extract items from.
//   index = List of values that will be evaluated as boolean, same length as `list`.  
// Example:
//   a = bselect([3,4,5,6,7], [false,true,true,false,true]);  // Returns: [4,5,7]
function bselect(list,index) =
    assert(is_list(list)||is_string(list), "First argument must be a list or string." )
    assert(is_list(index) && len(index)==len(list) , "Second argument must have same length as the first." )
    is_string(list)? str_join(bselect( [for (x=list) x], index)) :
    [for(i=idx(list)) if (index[i]) list[i]];

// Section: List Construction


// Function: repeat()
// Synopsis: Returns a list of repeated copies of a value.
// Topics: List Handling
// See Also: count(), lerpn()
// Usage:
//   list = repeat(val, n);
// Description:
//   Generates a list of `n` copies of the given value `val`.
//   If the count `n` is given as a list of counts, then this creates a
//   multi-dimensional array, filled with `val`.  If `n` is negative, returns the empty list. 
// Arguments:
//   val = The value to repeat to make the list or array.
//   n = The number of copies to make of `val`.  Can be a list to make an array of copies.
// Example:
//   a = repeat(1, 4);        // Returns [1,1,1,1]
//   b = repeat(8, [2,3]);    // Returns [[8,8,8], [8,8,8]]
//   c = repeat(0, [2,2,3]);  // Returns [[[0,0,0],[0,0,0]], [[0,0,0],[0,0,0]]]
//   d = repeat([1,2,3],3);   // Returns [[1,2,3], [1,2,3], [1,2,3]]
//   e = repeat(4, -1);       // Returns []
function repeat(val, n, i=0) =
    is_num(n)? [for(j=[1:1:n]) val] :
    assert( is_vector(n), "Invalid count number.")
    (i>=len(n))? val :
    [for (j=[1:1:n[i]]) repeat(val, n, i+1)];

// Function: list_bset()
// Synopsis: Returns a list where values are spread to locations indicated by a boolean index list.
// Topics: List Handling
// See Also: bselect()
// Usage:
//   arr = list_bset(indexset, valuelist, [dflt]);
// Description:
//   Opposite of `bselect()`.  Returns a list the same length as `indexlist`, where each item will
//   either be 0 if the corresponding item in `indexset` is false, or the next sequential value
//   from `valuelist` if the item is true.  The number of `true` values in `indexset` must be equal 
//   to the length of `valuelist`.
// Arguments:
//   indexset = A list of boolean values.
//   valuelist = The list of values to set into the returned list.
//   dflt = Default value to store when the indexset item is false.  Default: 0
// Example:
//   a = list_bset([false,true,false,true,false], [3,4]);  // Returns: [0,3,0,4,0]
//   b = list_bset([false,true,false,true,false], [3,4], dflt=1);  // Returns: [1,3,1,4,1]
function list_bset(indexset, valuelist, dflt=0) =
    assert(is_list(indexset), "The index set is not a list." )
    assert(is_list(valuelist), "The `valuelist` is not a list." )
    let( trueind = search([true], indexset,0)[0] )
    assert( !(len(trueind)>len(valuelist)), str("List `valuelist` too short; its length should be ",len(trueind)) )
    assert( !(len(trueind)<len(valuelist)), str("List `valuelist` too long; its length should be ",len(trueind)) )
    concat(
        list_set([],trueind, valuelist, dflt=dflt),    // Fill in all of the values
        repeat(dflt,len(indexset)-max(trueind)-1)  // Add trailing values so length matches indexset
    );

// Function: list()
// Synopsis: Expands a range into a full list.
// Topics: List Handling, Type Conversion
// See Also: scalar_vec3(), force_list()
// Usage:
//   list = list(l)
// Description:
//   Expands a range into a full list.  If given a list, returns it verbatim.
//   If given a string, explodes it into a list of single letters.
// Arguments:
//   l = The value to expand.
// Example:
//   l1 = list([3:2:9]);  // Returns: [3,5,7,9]
//   l2 = list([3,4,5]);  // Returns: [3,4,5]
//   l3 = list("Foo");    // Returns: ["F","o","o"]
//   l4 = list(23);       // Returns: [23]
function list(l) = is_list(l)? l : [for (x=l) x];

// Function: force_list()
// Synopsis: Coerces non-list values into a list.
// Topics: List Handling
// See Also: scalar_vec3()
// Usage:
//   list = force_list(value, [n], [fill]);
// Description:
//   Coerces non-list values into a list.  Makes it easy to treat a scalar input
//   consistently as a singleton list, as well as list inputs.
//   - If `value` is a list, then that list is returned verbatim.
//   - If `value` is not a list, and `fill` is not given, then a list of `n` copies of `value` will be returned.
//   - If `value` is not a list, and `fill` is given, then a list `n` items long will be returned where `value` will be the first item, and the rest will contain the value of `fill`.
// Arguments:
//   value = The value or list to coerce into a list.
//   n = The number of items in the coerced list.  Default: 1
//   fill = The value to pad the coerced list with, after the first value.  Default: undef (pad with copies of `value`)
// Example:
//   x = force_list([3,4,5]);  // Returns: [3,4,5]
//   y = force_list(5);  // Returns: [5]
//   z = force_list(7, n=3);  // Returns: [7,7,7]
//   w = force_list(4, n=3, fill=1);  // Returns: [4,1,1]
function force_list(value, n=1, fill) =
    is_list(value) ? value :
    is_undef(fill)? [for (i=[1:1:n]) value] : [value, for (i=[2:1:n]) fill];

// Section: List Modification

// Function: reverse()
// Synopsis: Reverses the elements of a list.
// Topics: List Handling
// See Also: select(), list_rotate()
// Usage:
//   rlist = reverse(list);
// Description:
//   Reverses a list or string.
// Arguments:
//   list = The list or string to reverse.
// Example:
//   reverse([3,4,5,6]);  // Returns [6,5,4,3]
function reverse(list) =
    assert(is_list(list)||is_string(list), str("Input to reverse must be a list or string. Got: ",list))
    let (elems = [ for (i = [len(list)-1 : -1 : 0]) list[i] ])
    is_string(list)? str_join(elems) : elems;

// Function: list_rotate()
// Synopsis: Rotates the ordering of a list.
// Topics: List Handling
// See Also: select(), reverse()
// Usage:
//   rlist = list_rotate(list, [n]);
// Description:
//   Rotates the contents of a list by `n` positions left, so that list[n] becomes the first entry of the list.
//   If `n` is negative, then the rotation is `abs(n)` positions to the right.
//   If `list` is a string, then a string is returned with the characters rotated within the string.
// Arguments:
//   list = The list to rotate.
//   n = The number of positions to rotate by.  If negative, rotated to the right.  Positive rotates to the left.  Default: 1
// Example:
//   l1 = list_rotate([1,2,3,4,5],-2); // Returns: [4,5,1,2,3]
//   l2 = list_rotate([1,2,3,4,5],-1); // Returns: [5,1,2,3,4]
//   l3 = list_rotate([1,2,3,4,5],0);  // Returns: [1,2,3,4,5]
//   l4 = list_rotate([1,2,3,4,5],1);  // Returns: [2,3,4,5,1]
//   l5 = list_rotate([1,2,3,4,5],2);  // Returns: [3,4,5,1,2]
//   l6 = list_rotate([1,2,3,4,5],3);  // Returns: [4,5,1,2,3]
//   l7 = list_rotate([1,2,3,4,5],4);  // Returns: [5,1,2,3,4]
//   l8 = list_rotate([1,2,3,4,5],5);  // Returns: [1,2,3,4,5]
//   l9 = list_rotate([1,2,3,4,5],6);  // Returns: [2,3,4,5,1]
function list_rotate(list,n=1) =
    assert(is_list(list)||is_string(list), "Invalid list or string.")
    assert(is_int(n), "The rotation number should be integer")
    let (
        ll = len(list),
        n = ((n % ll) + ll) % ll,
        elems = [
            for (i=[n:1:ll-1]) list[i],
            for (i=[0:1:n-1]) list[i]
        ]
    )
    is_string(list)? str_join(elems) : elems;

// Function: list_set()
// Synopsis: Sets the value of specific list items.
// Topics: List Handling
// See Also: list_insert(), list_remove(), list_remove_values()
// Usage:
//   list = list_set(list, indices, values, [dflt], [minlen]);
// Description:
//   Takes the input list and returns a new list such that `list[indices[i]] = values[i]` for all of
//   the (index,value) pairs supplied and unchanged for other indices.  If you supply `indices` that are 
//   larger that the length of the list then the list is extended and filled in with the `dflt` value.
//   If you specify indices smaller than zero then they index from the end, with -1 being the last element.
//   Negative indexing does not wrap around: an error occurs if you give a value smaller than `-len(list)`.
//   If you set `minlen` then the list is lengthed, if necessary, by padding with `dflt` to that length.  
//   Repetitions in `indices` are not allowed. The lists `indices` and `values` must have the same length.  
//   If `indices` is given as a scalar, then that index of the given `list` will be set to the scalar value of `values`.
// Arguments:
//   list = List to set items in.  Default: []
//   indices = List of indices into `list` to set.
//   values = List of values to set.
//   dflt = Default value to store in sparse skipped indices.
//   minlen = Minimum length to expand list to.
// Example:
//   a = list_set([2,3,4,5], 2, 21);  // Returns: [2,3,21,5]
//   b = list_set([2,3,4,5], [1,3], [81,47]);  // Returns: [2,81,4,47]
function list_set(list=[],indices,values,dflt=0,minlen=0) =
    assert(is_list(list))
    !is_list(indices)?
        assert(is_finite(indices))
        let(
            index = indices<0 ? indices+len(list) : indices
        )
        assert(index>=0, str("Index ",indices," is smaller than negative list length"))
        (
            index<len(list) ?
                [
                  for(i=[0:1:index-1]) list[i],
                  values,
                  for(i=[index+1:1:len(list)-1]) list[i],
                  for(i=[len(list):1:minlen-1]) dflt
                ]
            : concat(list, repeat(dflt, index-len(list)), [values], repeat(dflt, minlen-index-1))
        )
  : indices==[] && values==[]
      ? concat(list, repeat(dflt, minlen-len(list)))
  : assert(is_vector(indices) && is_list(values) && len(values)==len(indices),
           "Index list and value list must have the same length")
    let(  indices = [for(ind=indices) ind<0 ? ind+len(list) : ind],
          midx = max(len(list)-1, max(indices))
    )
    assert(min(indices)>=0, "Index list contains value smaller than negative list length")
    [
       for (i=[0:1:midx])
           let(
               j = search(i,indices,0),
               k = j[0]
           )
           assert( len(j)<2, "Repeated indices are not allowed." )
           k!=undef ? values[k]
         : i<len(list) ? list[i]
         : dflt,
       each repeat(dflt, minlen-max(len(list),max(indices)+1))
    ];

// Function: list_swap()
// Synopsis: Swaps two items in a list by index
// Topics: List Handling
// See Also: list_insert(), list_remove(), list_remove_values()
// Usage:
//   list = list_swap(list, i, j);
// Description:
//   Takes the input list and returns a new list where `list[i]` and `list[j]` have switched values.  
// Arguments:
//   list = List to set items in.  Default: []
//   i = first index to swap. 
//   j = second index to swap. 
// Example:
//   a = list_swap([2,3,4,5], 0, 2);  // Returns: [4,3,2,5]
function list_swap(list,i,j) =
    assert(is_list(list))
    assert(i>=0 && j>=0 && i<len(list) && j<len(list),"indices out of bounds")
    [for(m=[0:len(list)-1]) m==i ? list[j] : m==j ? list[i] : list[m]];

// Function: list_remove()
// Synopsis: Removes items by index from a list.
// Topics: List Handling
// See Also: list_set(), list_insert(), list_remove_values()
// Usage:
//   list = list_remove(list, ind);
// Description:
//   If `ind` is a number remove `list[ind]` from the list.  If `ind` is a list of indices
//   remove from the list the item all items whose indices appear in `ind`.  If you give
//   indices that are not in the list they are ignored.  
// Arguments:
//   list = The list to remove items from.
//   ind = index or list of indices of items to remove. 
// Example:
//   a = list_remove([3,6,9,12],1);      // Returns: [3,9,12]
//   b = list_remove([3,6,9,12],[1,3]);  // Returns: [3,9]
//   c = list_remove([3,6],3);           // Returns: [3,6]
function list_remove(list, ind) =
    assert(is_list(list), "Invalid list in list_remove")
    is_finite(ind) ?
        (
         (ind<0 || ind>=len(list)) ? list
         :                                        
            [
              for (i=[0:1:ind-1]) list[i],
              for (i=[ind+1:1:len(list)-1]) list[i]
            ]
        )
    :   ind==[] ? list
    :   assert( is_vector(ind), "Invalid index list in list_remove")
        let(sres = search(count(list),ind,1))
        [
            for(i=idx(list))
                if (sres[i] == []) 
                    list[i]
        ];

// Section: List Iteration Index Helper

// Function: idx()
// Synopsis: Returns a range useful for iterating over a list.
// Topics: List Handling, Iteration
// See Also: count()
// Usage:
//   range = idx(list, [s=], [e=], [step=]);
//   for(i=idx(list, [s=], [e=], [step=])) ...
// Description:
//   Returns the range that gives the indices for a given list.  This makes is a little bit
//   easier to loop over a list by index, when you need the index numbers and looping of list values isn't enough.
//   Note that the return is a **range** not a list.  
// Arguments:
//   list = The list to returns the index range of.
//   ---
//   s = The starting index.  Default: 0
//   e = The delta from the end of the list.  Default: -1 (end of list)
//   step = The step size to stride through the list.  Default: 1
// Example(2D):
//   colors = ["red", "green", "blue"];
//   for (i=idx(colors)) right(20*i) color(colors[i]) circle(d=10);
function idx(list, s=0, e=-1, step=1) =
    assert(is_list(list)||is_string(list), "Invalid input." )
    let( ll = len(list) )
    ll == 0 ? [0:1:ll-1] :
    let(
        _s = posmod(s,ll),
        _e = posmod(e,ll)
    ) [_s : step : _e];

// Section: Lists of Subsets


// Function: pair()
// Synopsis: Returns a list of overlapping consecutive pairs in a list.
// Topics: List Handling, Iteration
// See Also: idx(), triplet(), combinations(), permutations()
// Usage:
//   p = pair(list, [wrap]);
//   for (p = pair(list, [wrap])) ...  // On each iteration, p contains a list of two adjacent items.
// Description:
//   Returns a list of all of the pairs of adjacent items from a list, optionally wrapping back to the front.  The pairs overlap, and
//   are returned in order starting with the first two entries in the list.  If the list has less than two elements, the empty list is returned. 
// Arguments:
//   list = The list to use for making pairs
//   wrap = If true, wrap back to the start from the end.  ie: return the last and first items as the last pair.  Default: false
// Example(2D): Does NOT wrap from end to start,
//   for (p = pair(circle(d=40, $fn=12)))
//       stroke(p, endcap2="arrow2");
// Example(2D): Wraps around from end to start.
//   for (p = pair(circle(d=40, $fn=12), wrap=true))
//       stroke(p, endcap2="arrow2");
// Example:
//   l = ["A","B","C","D"];
//   echo([for (p=pair(l)) str(p.y,p.x)]);  // Outputs: ["BA", "CB", "DC"]
function pair(list, wrap=false) =
    assert(is_list(list)||is_string(list), "Invalid input." )
    assert(is_bool(wrap))
    let( L = len(list)-1)
    L<1 ? [] :
    [
      for (i=[0:1:L-1]) [list[i], list[i+1]],
      if(wrap) [list[L], list[0]]
    ];

// Function: triplet()
// Synopsis: Returns a list of overlapping consecutive triplets in a list.
// Topics: List Handling, Iteration
// See Also: idx(), pair(), combinations(), permutations()
// Usage:
//   list = triplet(list, [wrap]);
//   for (t = triplet(list, [wrap])) ...
// Description:
//   Returns a list of all adjacent triplets from a list, optionally wrapping back to the front.
//   If you set `wrap` to true then the first triplet is the one centered on the first list element, so it includes
//   the last element and the first two elements.  If the list has fewer than three elements then the empty list is returned.
// Arguments:
//   list = list to produce triplets from
//   wrap = if true, wrap triplets around the list.  Default: false
// Example:
//   list = [0,1,2,3,4];
//   a = triplet(list);               // Returns [[0,1,2],[1,2,3],[2,3,4]]
//   b = triplet(list,wrap=true);     // Returns [[4,0,1],[0,1,2],[1,2,3],[2,3,4],[3,4,0]]
//   letters = ["A","B","C","D","E"];
//   [for (p=triplet(letters)) str(p.z,p.y,p.x)];     // Returns: ["CBA", "DCB", "EDC"]
// Example(2D):
//   path = [for (i=[0:24]) polar_to_xy(i*2, i*360/12)];
//   for (t = triplet(path)) {
//       a = t[0]; b = t[1]; c = t[2];
//       v = unit(unit(a-b) + unit(c-b));
//       translate(b) rot(from=FWD,to=v) anchor_arrow2d();
//   }
//   stroke(path);
function triplet(list, wrap=false) =
    assert(is_list(list)||is_string(list), "Invalid input." )
    assert(is_bool(wrap))
    let(L=len(list))
    L<3 ? [] :
    [
      if(wrap) [list[L-1], list[0], list[1]],
      for (i=[0:1:L-3]) [list[i],list[i+1],list[i+2]],
      if(wrap) [list[L-2], list[L-1], list[0]]
    ];

// Section: Changing List Structure


// Function: list_to_matrix()
// Synopsis: Groups items in a list into sublists.
// Topics: Matrices, List Handling
// See Also: column(), submatrix(), hstack(), flatten(), full_flatten()
// Usage:
//   groups = list_to_matrix(v, cnt, [dflt]);
// Description:
//   Takes a flat list of values, and groups items in sets of `cnt` length.
//   The opposite of this is `flatten()`.
// Arguments:
//   v = The list of items to group.
//   cnt = The number of items to put in each grouping. 
//   dflt = The default value to fill in with if the list is not a multiple of `cnt` items long.  Default: undef
// Example:
//   v = [1,2,3,4,5,6];
//   a = list_to_matrix(v,2)  // returns [[1,2], [3,4], [5,6]]
//   b = list_to_matrix(v,3)  // returns [[1,2,3], [4,5,6]]
//   c = list_to_matrix(v,4,0)  // returns [[1,2,3,4], [5,6,0,0]]
function list_to_matrix(v, cnt, dflt=undef) =
    [for (i = [0:cnt:len(v)-1]) [for (j = [0:1:cnt-1]) default(v[i+j], dflt)]];

// Function: flatten()
// Synopsis: Flattens a list of sublists into a single list.
// Topics: Matrices, List Handling
// See Also: column(), submatrix(), hstack(), full_flatten()
// Usage:
//   list = flatten(l);
// Description:
//   Takes a list of lists and flattens it by one level.
// Arguments:
//   l = List to flatten.
// Example:
//   l = flatten([[1,2,3], [4,5,[6,7,8]]]);  // returns [1,2,3,4,5,[6,7,8]]
function flatten(l) =
    !is_list(l)? l :
    [for (a=l) if (is_list(a)) (each a) else a];

// onescad: BOSL2/comparisons.scad
//////////////////////////////////////////////////////////////////////
// LibFile: comparisons.scad
//   Functions for comparisons with lists, ordering and sorting
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Data Management
// FileSummary: Comparisons and sorting.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: List comparison operations

// Function: approx()
// Synopsis: Returns true if two values are equal to within a small epsilon value.
// Topics: Comparisons
// See Also: all_zero(), all_nonzero()
// Usage:
//   test = approx(a, b, [eps])
// Description:
//   Compares two numbers, vectors, or matrices.  Returns true if they are closer than `eps` to each other.
//   Results are undefined if `a` and `b` are of different types, or if vectors or matrices contain non-numbers.
// Arguments:
//   a = First value.
//   b = Second value.
//   eps = The maximum allowed difference between `a` and `b` to consider as "no difference". Default: 1e-9.
// Example:
//   test1 = approx(-0.3333333333,-1/3);  // Returns: true
//   test2 = approx(0.3333333333,1/3);    // Returns: true
//   test3 = approx(0.3333,1/3);          // Returns: false
//   test4 = approx(0.3333,1/3,eps=1e-3); // Returns: true
//   test5 = approx(PI,3.1415926536);     // Returns: true
//   test6 = approx([0,0,sin(45)],[0,0,sqrt(2)/2]);  // Returns: true
function approx(a,b,eps=_EPSILON) = 
    a == b? is_bool(a) == is_bool(b) :
    is_num(a) && is_num(b)? abs(a-b) <= eps :
    is_list(a) && is_list(b) && len(a) == len(b)? (
        [] == [
            for (i=idx(a))
            let(aa=a[i], bb=b[i])
            if(
                is_num(aa) && is_num(bb)? abs(aa-bb) > eps :
                !approx(aa,bb,eps=eps)
            ) 1
        ]
    ) : false;

// Function: all_zero()
// Synopsis: Returns true if the value(s) given are approximately zero.
// Topics: Comparisons, List Handling
// See Also: approx(), all_zero(), all_nonzero()
// Usage:
//   x = all_zero(x, [eps]);
// Description:
//   Returns true if its argument is approximately zero, to within `eps`.  
//   If passed a nonempty list, returns true if all its entries are approximately zero. 
//   Otherwise, returns false.
// Arguments:
//   x = The value to check.
//   eps = The maximum allowed variance.  Default: 1e-9
// Example:
//   a = all_zero(0);  // Returns: true.
//   b = all_zero(1e-3);  // Returns: false.
//   c = all_zero([0,0,0]);  // Returns: true.
//   d = all_zero([0,0,1e-3]);  // Returns: false.
//   e = all_zero(1,eps=1);       // Returns: true.
//   f = all_zero([1],eps=1);     // Returns: true.
//   g = all_zero(0,eps=0);       // Returns: true.
function all_zero(x, eps=_EPSILON) =
    is_finite(x)? abs(x)<=eps :
    is_vector(x) && [for (xx=x) if(abs(xx)>eps) 1] == [];

// Function: all_nonzero()
// Synopsis: Returns true if the value(s) given are not approximately zero.
// Topics: Comparisons, List Handling
// See Also: approx(), all_zero(), all_nonzero()
// Usage:
//   test = all_nonzero(x, [eps]);
// Description:
//   Returns true if the absolute value of its argument is greater than `eps`.
//   If passed a nonempty list, returns true if all its entries have absolute value greater than `eps`.
//   Otherwise, returns false.
// Arguments:
//   x = The value to check.
//   eps = The maximum allowed variance.  Default: 1e-9
// Example:
//   a = all_nonzero(0);  // Returns: false.
//   b = all_nonzero(1e-3);  // Returns: true.
//   c = all_nonzero([0,0,0]);  // Returns: false.
//   d = all_nonzero([0,0,1e-3]);  // Returns: false.
//   e = all_nonzero([1e-3,1e-3,1e-3]);  // Returns: true.
//   f = all_nonzero(1,eps=1);             // Returns: false.
//   g = all_nonzero([1],eps=1);           // Returns: false.
//   h = all_nonzero([0],eps=0);           // Returns: false.
function all_nonzero(x, eps=_EPSILON) =
    is_finite(x)? abs(x)>eps :
    is_vector(x) && [for (xx=x) if(abs(xx)<=eps) 1] == [];

// Function: all_positive()
// Synopsis: Returns true if the value(s) given are greater than zero.
// Topics: Comparisons, List Handling
// See Also: approx(), all_zero(), all_nonzero(), all_negative(), all_nonpositive(), all_nonnegative()
// Usage:
//   test = all_positive(x,[eps]);
// Description:
//   Returns true if the argument is finite and greater than zero, within epsilon tolerance if desired.
//   If passed a list returns true if all the entries are finite positive numbers.
//   Otherwise, returns false.
// Arguments:
//   x = The value to check.
//   eps = Tolerance. Default: 0
// Example:
//   a = all_positive(-2);  // Returns: false.
//   b = all_positive(0);  // Returns: false.
//   c = all_positive(2);  // Returns: true.
//   d = all_positive([0,0,0]);  // Returns: false.
//   e = all_positive([0,1,2]);  // Returns: false.
//   f = all_positive([3,1,2]);  // Returns: true.
//   g = all_positive([3,-1,2]);  // Returns: false.
function all_positive(x,eps=0) =
    is_finite(x)? x>eps :
    is_vector(x) && [for (xx=x) if(xx<=eps) 1] == [];

// Function: all_nonnegative()
// Synopsis: Returns true if the value(s) given are greater than or equal to zero.
// Topics: Comparisons, List Handling
// See Also: approx(), all_zero(), all_nonzero(), all_positive(), all_negative(), all_nonpositive(), all_nonnegative()
// Usage:
//   all_nonnegative(x, [eps]);
// Description:
//   Returns true if the finite number passed to it is greater than or equal to zero.
//   If passed a list, returns true if all the elements are finite non-negative numbers. 
//   Otherwise, returns false.
// Arguments:
//   x = The value to check.
//   eps = tolerance.  Default: 0
// Example:
//   a = all_nonnegative(-2);  // Returns: false.
//   b = all_nonnegative(0);  // Returns: true.
//   c = all_nonnegative(2);  // Returns: true.
//   d = all_nonnegative([0,0,0]);  // Returns: true.
//   e = all_nonnegative([0,1,2]);  // Returns: true.
//   f = all_nonnegative([0,-1,-2]);  // Returns: false.
//   g = all_nonnegative([3,1,2]);  // Returns: true.
//   h = all_nonnegative([3,-1,2]);  // Returns: false.
//   i = all_nonnegative([-3,-1,-2]);  // Returns: false.
function all_nonnegative(x,eps=0) =
    is_finite(x)? x>=-eps :
    is_vector(x) && [for (xx=x) if(xx<-eps) 1] == [];

// Function: all_equal()
// Synopsis: Returns true if all items in a list are approximately equal to each other.
// Topics: Comparisons, List Handling
// See Also: approx(), all_zero(), all_nonzero(), all_positive(), all_negative(), all_nonpositive(), all_nonnegative()
// Usage:
//   b = all_equal(vec, [eps]);
// Description:
//   Returns true if all of the entries in vec are equal to each other, or approximately equal to each other if eps is set.
// Arguments:
//   vec = vector to check
//   eps = Set to tolerance for approximate equality.  Default: 0
function all_equal(vec,eps=0) =
   eps==0 ? [for(v=vec) if (v!=vec[0]) v] == []
          : [for(v=vec) if (!approx(v,vec[0],eps)) v] == [];

// Function: are_ends_equal()
// Synopsis: Returns true if the first and last items in a list are approximately equal.
// Topics: Comparisons, List Handling
// See Also: approx(), all_zero(), all_nonzero(), all_positive(), all_negative(), all_nonpositive(), all_nonnegative()
// Usage:
//   are_ends_equal(list, [eps]);
// Description:
//   Returns true if the first and last points in the given list are equal to within epsilon.
// Arguments:
//   list = list to check
//   eps = Tolerance for approximate equality.  Default: 1e-9
function are_ends_equal(list, eps=_EPSILON) =
  assert(is_list(list) && len(list)>0, "Must give a nonempty list")
  approx(list[0], list[len(list)-1], eps=eps);

// Function: is_increasing()
// Synopsis: Returns true if every item in a list is greater than the previous item. 
// Topics: Comparisons, List Handling
// See Also: max_index(), min_index(), is_increasing(), is_decreasing()
// Usage:
//    bool = is_increasing(list, [strict]);
// Description:
//   Returns true if the list is (non-strictly) increasing, or strictly increasing if `strict=true`.
//   The list can be a list of any items that OpenSCAD can compare, or it can be a string, which gets
//   evaluated character by character.
// Arguments:
//   list = list (or string) to check
//   strict = set to true to test that list is strictly increasing.  Default: false
// Example:
//   a = is_increasing([1,2,3,4]);  // Returns: true
//   b = is_increasing([1,3,2,4]);  // Returns: false
//   c = is_increasing([1,3,3,4]);  // Returns: true
//   d = is_increasing([1,3,3,4],strict=true);  // Returns: false
//   e = is_increasing([4,3,2,1]);  // Returns: false
function is_increasing(list,strict=false) =
    assert(is_list(list)||is_string(list))
    strict ? len([for (p=pair(list)) if(p.x>=p.y) true])==0
           : len([for (p=pair(list)) if(p.x>p.y) true])==0;

function _type_num(x) =
    is_undef(x)?  0 :
    is_bool(x)?   1 :
    is_nan(x)?    2 :
    is_num(x)?    3 :
    is_string(x)? 4 :
    is_list(x)?   5 : 6;

// Function: compare_vals()
// Synopsis: Compares two values, possibly of different type.
// Topics: Comparisons, List Handling
// See Also: approx(), is_increasing(), is_decreasing()
// Usage:
//   test = compare_vals(a, b);
// Description:
//   Compares two values.  Lists are compared recursively.
//   Returns a negative value if a<b.  Returns a positive value if a>b.  Returns 0 if a==b.
//   If types are not the same, then undef < bool < nan < num < str < list < range.
// Arguments:
//   a = First value to compare.
//   b = Second value to compare.
function compare_vals(a, b) =
    (a==b)? 0 :
    let(t1=_type_num(a), t2=_type_num(b)) (t1!=t2)? (t1-t2) :
    is_list(a)? compare_lists(a,b) :
    is_nan(a)? 0 :
    (a<b)? -1 : (a>b)? 1 : 0;

// Function: compare_lists()
// Synopsis: Compares two lists of values, possibly of different type.
// Topics: Comparisons, List Handling
// See Also: compare_vals(), approx(), is_increasing(), is_decreasing()
// Usage:
//   test = compare_lists(a, b)
// Description:
//   Compare contents of two lists using `compare_vals()`.
//   Returns a negative number if `a`<`b`.
//   Returns 0 if `a`==`b`.
//   Returns a positive number if `a`>`b`.
// Arguments:
//   a = First list to compare.
//   b = Second list to compare.
function compare_lists(a, b) =
    a==b? 0 :
    let(
        cmps = [
            for (i = [0:1:min(len(a),len(b))-1])
            let( cmp = compare_vals(a[i],b[i]) )
            if (cmp!=0) cmp
        ]
    )
    cmps==[]? (len(a)-len(b)) : cmps[0];

// Section: Finding the index of the minimum or maximum of a list


// Function: min_index()
// Synopsis: Returns the index of the minimum value in the given list.
// Topics: List Handling
// See Also: max_index(), is_increasing(), is_decreasing()
// Usage:
//   idx = min_index(vals);
//   idxlist = min_index(vals, all=true);
// Description:
//   Returns the index of the first occurrence of the minimum value in the given list. 
//   If `all` is true then returns a list of all indices where the minimum value occurs.
// Arguments:
//   vals = vector of values
//   all = set to true to return indices of all occurrences of the minimum.  Default: false
// Example:
//   a = min_index([5,3,9,6,2,7,8,2,1]); // Returns: 8
//   b = min_index([5,3,9,6,2,7,8,2,7],all=true); // Returns: [4,7]
function min_index(vals, all=false) =
    assert( is_vector(vals), "Invalid or empty list of numbers.")
    all ? search(min(vals),vals,0) : search(min(vals), vals)[0];

// Function: max_index()
// Synopsis: Returns the index of the maximum value in the given list.
// Topics: List Handling
// See Also: min_index(), is_increasing(), is_decreasing()
// Usage:
//   idx = max_index(vals);
//   idxlist = max_index(vals, all=true);
// Description:
//   Returns the index of the first occurrence of the maximum value in the given list. 
//   If `all` is true then returns a list of all indices where the maximum value occurs.
// Arguments:
//   vals = vector of values
//   all = set to true to return indices of all occurrences of the maximum.  Default: false
// Example:
//   max_index([5,3,9,6,2,7,8,9,1]); // Returns: 2
//   max_index([5,3,9,6,2,7,8,9,1],all=true); // Returns: [2,7]
function max_index(vals, all=false) =
    assert( is_vector(vals) && len(vals)>0 , "Invalid or empty list of numbers.")
    all ? search(max(vals),vals,0) : search(max(vals), vals)[0];

// Function: deduplicate()
// Synopsis: Returns a list with all consecutive duplicate values removed.
// Topics: List Handling
// See Also: deduplicate_indexed()
// Usage:
//   list = deduplicate(list, [closed], [eps]);
// Description:
//   Removes consecutive duplicate items in a list.
//   When `eps` is zero, the comparison between consecutive items is exact.
//   Otherwise, comparisons use {{approx()}}, including recursive comparison of numeric lists.
//   Unlike {{unique()}} only consecutive duplicates are removed and the list is *not* sorted.
//   If `closed` is true, the last and first entries are also compared as adjacent items.
//   If these comparisons would remove every item of nonempty input, one item is retained.
//   Empty input is returned unchanged.
// Arguments:
//   list = The list to deduplicate.
//   closed = If true, treats first and last list entry as adjacent.  Default: false
//   eps = The maximum tolerance between items.  Default: 1e-9
// Example:
//   a = deduplicate([8,3,4,4,4,8,2,3,3,8,8]);  // Returns: [8,3,4,8,2,3,8]
//   b = deduplicate(closed=true, [8,3,4,4,4,8,2,3,3,8,8]);  // Returns: [8,3,4,8,2,3]
//   c = deduplicate("Hello");  // Returns: "Helo"
//   d = deduplicate([[3,4],[7,2],[7,1.99],[1,4]],eps=0.1);  // Returns: [[3,4],[7,1.99],[1,4]]
//   e = deduplicate([[7,undef],[7,undef],[1,4],[1,4+1e-12]],eps=0);    // Returns: [[7,undef],[1,4],[1,4+1e-12]]
//   f = deduplicate([7,7],closed=true);  // Returns: [7]
//   g = deduplicate("aaa",closed=true); // Returns: "a"
function deduplicate(list, closed=false, eps=_EPSILON) =
    assert(is_list(list)||is_string(list))
    let(
        l = len(list),
        end = l-(closed?0:1),
        result = is_string(list) ? chr([for (i=[0:1:l-1]) if (i==end || list[i] != list[(i+1)%l]) ord(list[i])]) :
                 eps==0 ? [for (i=[0:1:l-1]) if (i==end || list[i] != list[(i+1)%l]) list[i]] :
                 [for (i=[0:1:l-1]) if (i==end || !approx(list[i], list[(i+1)%l], eps)) list[i]]
    )
    l>0 && len(result)==0 ? (is_string(list) ? list[l-1] : [list[l-1]]) : result;

// Function: deduplicate_indexed()
// Synopsis: Takes a list of indices into a list of values, and returns a list of indices whose values are not consecutively the same.
// Topics: List Handling
// See Also: deduplicate()
// Usage:
//   new_idxs = deduplicate_indexed(list, [indices], [closed], [eps]);
// Description:
//   Given a list, and a list of indices, removes consecutive indices corresponding to list values that are equal
//   or approximately equal.  If you omit the `indices` parameter then it defaults to the list `[0,...,len(list)-1]` so
//   the return value is the indices of the deduplication of the entire input list.  This is useful if you need to
//   remove the duplicates from list A and then remove the corresponding points from list B.  The `list` input
//   may itself have duplicates, so multiple distinct index values can correspond to the same list value.
//   When this happens, the index returned for a run of identical items will be the last index listed in the index list.
//   Comparisons match {{deduplicate()}}: exact equality when `eps` is zero, otherwise {{approx()}},
//   including recursive comparison of numeric lists. 
//   If `closed` is true, the last and first selected entries are compared as adjacent items.
//   If no indices would survive from a nonempty selection, the last supplied index is retained.
//   An empty selection returns `[]`, including when the data is empty and `indices` is omitted.
// Arguments:
//   list = The list that the indices index into.
//   indices = The list of indices to deduplicate.  Default: `count(len(list))`
//   closed = If true, treats the last and first selected entries as adjacent, retaining one index if all would be removed. Default: false
//   eps = Tolerance for recursive approximate comparisons; zero selects exact equality. Default: 1e-9
// Example:
//   a = deduplicate_indexed([8,6,4,6,3], [1,4,3,1,2,2,0,1]);  // Returns: [1,4,1,2,0,1]
//   b = deduplicate_indexed([8,6,4,6,3], [1,4,3,1,2,2,0,1], closed=true);  // Returns: [1,4,1,2,0]
//   c = deduplicate_indexed([[7,undef],[7,undef],[1,4],[1,4],[1,4+1e-12]],eps=0);    // Returns: [1,3,4]
//   d = deduplicate_indexed([7,7],closed=true);          // Returns: [1]
//   e = deduplicate_indexed([7,7,7],[2,0],closed=true);  // Returns: [0]
//   f = deduplicate_indexed([]);                       // Returns: []
//   g = deduplicate_indexed([1,2],[]);                 // Returns: []
// Example: Remove duplicates from `a` and then remove corresponding points from `b`.
//   a = [1, 1, 2, 3, 4, 4, 5, 5, 5];
//   b = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];
//   ind = deduplicate_indexed(a,count(len(a)));  // Returns: [1,2,3,5,8]
//   echo(select(a,ind));         // Displays:  [1,2,3,4,5]
//   echo(select(b,ind));         // Displays:  ["B", "C", "D", "F", "I"]
function deduplicate_indexed(list, indices, closed=false, eps=_EPSILON) =
    assert(is_list(list)||is_string(list), "Improper list or string.")
    let(indices=default(indices, count(len(list))))
    indices==[]? [] :
    assert(is_vector(indices), "Indices must be a list of numbers.")
    assert(len(list)>0, "Bad index in indices: input data is empty.")
    let(
        l = len(indices),
        end = l-(closed?0:1),
        result = [
            for (i = [0:1:l-1]) let(
                idx1 = indices[i],
                idx2 = indices[(i+1)%l],
                a = assert(idx1>=0,"Bad index.")
                    assert(idx1<len(list),"Bad index in indices.")
                    list[idx1],
                b = assert(idx2>=0,"Bad index.")
                    assert(idx2<len(list),"Bad index in indices.")
                    list[idx2],
                eq = eps==0 ? a==b : approx(a,b,eps)
            )
            if (i==end || !eq) indices[i]
        ]
    )
    result==[] ? [indices[l-1]] : result;

// Function: list_wrap()
// Synopsis: Returns a list whose last value is the same as the first.
// Topics: List Handling, Paths
// See Also: list_unwrap(), deduplicate()
// Usage:
//   list_wrap(path, [eps]);
// Description:
//   Force a list to wrap around so that its last point is equal to its first point:  if the first and last entries are equal, simply returns the list unchanged.
//   Otherwise returns the list with the first point duplicated at the end of the list.  Comparisons are done to the tolerance `eps`.  Lists of length 0 or
//   1 are returned unchanged.  
// Arguments:
//   list = list to unwrap
//   eps = epsilon for comparison.  Default: 1e-9
function list_wrap(list, eps=_EPSILON) =
    assert(is_list(list))
    assert(is_finite(eps) && eps>=0)
    len(list)<2 || are_ends_equal(list,eps=eps)? list : [each list, list[0]];

// Function: list_unwrap()
// Synopsis: Removes the last item of a list if its first and last values are equal.
// Topics: List Handling, Paths
// See Also: list_wrap(), deduplicate()
// Usage:
//   list_unwrap(list, [eps]);
// Description:
//   If a list's last point matches its first point then delete the last point.  Inverse operation to {{list_wrap()}}.  Note that if the first/last points
//   are repeated then the output may still have the first point equal to the last point.  Comparisons are done to the tolerance `eps`.  If the list has
//   length 0 or 1 it is returned unchanged.  
// Arguments:
//   list = list to unwrap
//   eps = epsilon for comparison.  Default: 1e-9
function list_unwrap(list, eps=_EPSILON) =
    assert(is_list(list))
    len(list)>=2 && are_ends_equal(list,eps=eps)? [for (i=[0:1:len(list)-2]) list[i]] : list;

// Function: unique()
// Synopsis: Returns a sorted list with all duplicates removed.
// Topics: List Handling
// See Also: shuffle(), sort(), sortidx(), unique_count()
// Usage:
//   ulist = unique(list);
// Description:
//   Given a string or a list returns the sorted string or the sorted list with all repeated items removed.
//   The sorting order of non homogeneous lists is the function `sort` order.
// Arguments:
//   list = The list to process.
// Example:
//   sorted = unique([5,2,8,3,1,3,8,7,5]);  // Returns: [1,2,3,5,7,8]
//   sorted = unique("axdbxxc");  // Returns: "abcdx"
//   sorted = unique([true,2,"xba",[1,0],true,[0,0],3,"a",[0,0],2]); // Returns: [true,2,3,"a","xba",[0,0],[1,0]]
function unique(list) =
    assert(is_list(list)||is_string(list), "Invalid input." )
    is_string(list)? chr(unique([for (x = list) ord(x)])) :
    len(list)<=1? list : 
    is_homogeneous(list,1) && ! is_list(list[0])
    ?   _unique_sort(list)
    :   let( sorted = sort(list))
        [
            for (i=[0:1:len(sorted)-1])
                if (i==0 || (sorted[i] != sorted[i-1]))
                    sorted[i]
        ];

function _unique_sort(l) =
    len(l) <= 1 ? l : 
    let(
        pivot   = l[floor(len(l)/2)],
        equal   = [ for(li=l) if( li==pivot) li ],
        lesser  = [ for(li=l) if( li<pivot ) li ],
        greater = [ for(li=l) if( li>pivot) li ]
    )
    concat(
        _unique_sort(lesser), 
        equal[0], 
        _unique_sort(greater)
    );

// Function: unique_count()
// Synopsis: Returns a sorted list of unique items with counts.
// Topics: List Handling
// See Also: shuffle(), sort(), sortidx(), unique()
// Usage:
//   sorted_counts = unique_count(list);
// Description:
//   Returns `[sorted,counts]` where `sorted` is a sorted list of the unique items in `list` and `counts` is a list such 
//   that `counts[i]` gives the number of times that `sorted[i]` appears in `list`.
//   An empty list or empty string returns `[[],[]]`.
// Arguments:
//   list = The list to analyze. 
// Example:
//   sorted = unique_count([5,2,8,3,1,3,8,3,5]);  // Returns: [ [1,2,3,5,8], [1,1,3,2,2] ]
//   empty = unique_count("");                    // Returns: [[],[]]
function unique_count(list) =
    assert(is_list(list) || is_string(list), "Invalid input." )
    len(list)==0 ? [[],[]] : 
    is_homogeneous(list,1) && ! is_list(list[0])
    ?    let( sorted = _group_sort(list) )
        [ [for(s=sorted) s[0] ], [for(s=sorted) len(s) ] ]
    :   let( 
            list = sort(list),
            ind = [0, for(i=[1:1:len(list)-1]) if (list[i]!=list[i-1]) i] 
        )
        [ select(list,ind), deltas( concat(ind,[len(list)]) ) ];

// Function: unique_approx_indexed()
// Synopsis: Returns indices of a subset whose retained items are separated by more than a tolerance.
// Topics: List Handling, Comparisons
// See Also: unique_approx(), unique(), deduplicate_indexed()
// Usage:
//   indices = unique_approx_indexed(data, [eps]);
// Description:
//   Returns indices of a subset whose retained items are pairwise farther apart than `eps`.
//   For a vector of numbers, distance is the absolute difference and indices are in value-sorted order.
//   For a list of points, distance is Euclidean and returned indices are in input order.
//   As with {{unique_approx()}}, a discarded item need not be within `eps` of any retained item:
//   it can be discarded because it is close to another item that is also discarded.
// Arguments:
//   data = A vector of numbers or a list of points of the same dimension.
//   eps = Nonnegative minimum separation between retained items. Default: 1e-9
// Example:
//   unique_approx_indexed([0,0.9,1.8],eps=1); // Returns: [0]
function unique_approx_indexed(data,eps=_EPSILON) =
  is_vector(data) ?
    let(
        sind = sortidx(data)
    )
    [sind[0], 
     for(i=[1:1:len(data)-1]) if (abs(data[sind[i]]-data[sind[i-1]])>eps) sind[i]
    ]
  :  
  let(
      dups = vector_search(data,eps,data)
  )
  [for(i=idx(data)) if (min(dups[i])==i) i];

// Section: Sorting


// returns true for valid index specifications idx in the interval [imin, imax) 
// note that idx can't have any value greater or EQUAL to imax
// this allows imax=INF as a bound to numerical lists
function _valid_idx(idx,imin,imax) =
    is_undef(idx) 
    || ( is_finite(idx)  
         && ( is_undef(imin) || idx>=imin ) 
         && ( is_undef(imax) || idx< imax ) )
    || ( is_list(idx)  
         && ( is_undef(imin) || min(idx)>=imin ) 
         && ( is_undef(imax) || max(idx)< imax ) )
    || ( is_range(idx) 
         && ( is_undef(imin) || (idx[1]>0 && idx[0]>=imin ) || (idx[1]<0 && idx[0]<=imax ) )
         && ( is_undef(imax) || (idx[1]>0 && idx[2]<=imax ) || (idx[1]<0 && idx[2]>=imin ) ) );

function _group_sort(l) =
    len(l) == 0 ? [] : 
    len(l) == 1 ? [l] : 
    let(
        pivot   = l[floor(len(l)/2)],
        equal   = [ for(li=l) if( li==pivot) li ],
        lesser  = [ for(li=l) if( li< pivot) li ],
        greater = [ for(li=l) if( li> pivot) li ]
    )
    concat(
        _group_sort(lesser), 
        [equal], 
        _group_sort(greater)
    );

// Sort a vector of scalar values with the native comparison operator
// all elements should have the same type.
function _sort_scalars(arr) =
    len(arr)<=1 ? arr : 
    let(
        pivot   = arr[floor(len(arr)/2)],
        lesser  = [ for (y = arr) if (y  < pivot) y ],
        equal   = [ for (y = arr) if (y == pivot) y ],
        greater = [ for (y = arr) if (y  > pivot) y ]
    ) 
    concat( _sort_scalars(lesser), equal, _sort_scalars(greater) );

// lexical sort of a homogeneous list of vectors by the vector components with indices in idxlist
// all idxlist indices should be in the range of the vector dimensions
// idxlist must be undef or a simple list of numbers
// uses native comparison operator
function _sort_vectors(arr, idxlist, _i=0) =
    len(arr)<=1 || ( is_list(idxlist) && _i>=len(idxlist) ) || _i>=len(arr[0])  ? arr :
    let(
        k = is_list(idxlist) ? idxlist[_i] : _i,
        pivot   = arr[floor(len(arr)/2)][k],
        lesser  = [ for (entry=arr) if (entry[k]  < pivot ) entry ],
        equal   = [ for (entry=arr) if (entry[k] == pivot ) entry ],
        greater = [ for (entry=arr) if (entry[k]  > pivot ) entry ]
      )
    concat(
        _sort_vectors(lesser,  idxlist, _i  ), 
        _sort_vectors(equal,   idxlist, _i+1), 
        _sort_vectors(greater, idxlist, _i  ) );

// sorting using compare_vals(); returns indexed list when `indexed==true`
function _sort_general(arr, idx=undef, indexed=false) =
    (len(arr)<=1) ? (indexed ? count(len(arr)) : arr) :
    ! indexed && is_undef(idx)
    ? _lexical_sort(arr)
    : let( labeled = is_undef(idx) ? [for(i=idx(arr)) [i,arr[i]]]
                                   : [for(i=idx(arr)) [i, [for(j=idx) arr[i][j]]]],
           arrind = _indexed_sort(labeled))
      indexed 
      ? arrind
      : [for(i=arrind) arr[i]];

// lexical sort using compare_vals()
function _lexical_sort(arr) = 
    len(arr)<=1? arr : 
    let( pivot = arr[floor(len(arr)/2)] )
    let(
        lesser  = [ for (entry=arr) if (compare_vals(entry, pivot) <0 ) entry ],
        equal   = [ for (entry=arr) if (compare_vals(entry, pivot)==0 ) entry ],
        greater = [ for (entry=arr) if (compare_vals(entry, pivot) >0 ) entry ]
      )
    concat(_lexical_sort(lesser), equal, _lexical_sort(greater));

// given a list of pairs, return the first element of each pair of the list sorted by the second element of the pair
// the sorting is done using compare_vals()
function _indexed_sort(arrind) = 
    arrind==[] ? [] : len(arrind)==1? [arrind[0][0]] : 
    let( pivot = arrind[floor(len(arrind)/2)][1] )
    let(
        lesser  = [ for (entry=arrind) if (compare_vals(entry[1], pivot) <0 ) entry ],
        equal   = [ for (entry=arrind) if (compare_vals(entry[1], pivot)==0 ) entry[0] ],
        greater = [ for (entry=arrind) if (compare_vals(entry[1], pivot) >0 ) entry ]
      )
    concat(_indexed_sort(lesser), equal, _indexed_sort(greater));

// Function: sort()
// Synopsis: Returns a sorted list.
// Topics: List Handling
// See Also: shuffle(), sortidx(), unique(), unique_count(), group_sort()
// Usage:
//   slist = sort(list, [idx]);
// Description:
//   Sorts the given list in lexicographic order. The sort is stable, meaning equivalent items do not change order. 
//   If the input is a homogeneous simple list or a homogeneous 
//   list of vectors (see function is_homogeneous), the sorting method uses the native comparison operator and is faster. 
//   When sorting non-homogeneous list the elements are compared with `compare_vals`, with types ordered according to
//   `undef < boolean < nan < number < string < list < range`.  Comparison of lists is recursive. 
//   When comparing vectors, homogeneous or not, the parameter `idx` may be used to select the components to compare.
//   Note that homogeneous lists of vectors may contain mixed types provided that for any two list elements
//   list[i] and list[j] satisfies  type(list[i][k])==type(list[j][k]) for all k. 
//   Strings are allowed as any list element and are compared with the native operators although no substring
//   comparison is possible.  
// Arguments:
//   list = The list to sort.
//   idx = If given, do the comparison based just on the specified index, range or list of indices.  
// Example: 
//   // Homogeneous lists
//   l1 = [45,2,16,37,8,3,9,23,89,12,34];
//   sorted1 = sort(l1);  // Returns [2,3,8,9,12,16,23,34,37,45,89]
//   l2 = [["oat",0], ["cat",1], ["bat",3], ["bat",2], ["fat",3]];
//   sorted2 = sort(l2); // Returns: [["bat",2],["bat",3],["cat",1],["fat",3],["oat",0]]
//   // Non-homegenous list
//   l3 = [[4,0],[7],[3,9],20,[4],[3,1],[8]];
//   sorted3 = sort(l3); // Returns: [20,[3,1],[3,9],[4],[4,0],[7],[8]]
function sort(list, idx=undef) = 
    assert(is_list(list)||is_string(list), "Invalid input." )
    is_string(list)? chr(sort([for (x = list) ord(x)])) :
    !is_list(list) || len(list)<=1 ? list :
    is_homogeneous(list,1)
    ?   let(size = list_shape(list[0]))
        size==0 ?         _sort_scalars(list)
        : len(size)!=1 ?  _sort_general(list,idx)  
        : is_undef(idx) ? _sort_vectors(list)
        : assert( _valid_idx(idx) , "Invalid indices.")
          _sort_vectors(list,[for(i=idx) i])        
    : _sort_general(list,idx);

// Function: sortidx()
// Synopsis: Returns a list of sorted indices into a list.
// Topics: List Handling
// See Also: shuffle(), sort(), group_sort(), unique(), unique_count()
// Usage:
//   idxlist = sortidx(list, [idx]);
// Description:
//   Given a list, sort it as function `sort()`, and returns
//   a list of indexes into the original list in that sorted order.
//   The sort is stable, so equivalent items do not change order.  
//   If you iterate the returned list in order, and use the list items
//   to index into the original list, then you are accessing the original
//   values in sorted order.
// Arguments:
//   list = The list to sort.
//   idx = If given, do the comparison based just on the specified index, range or list of indices.  
// Example:
//   lst = ["d","b","e","c"];
//   idxs = sortidx(lst);  // Returns: [1,3,0,2]
//   ordered = select(lst, idxs);   // Returns: ["b", "c", "d", "e"]
// Example:
//   lst = [
//       ["foo", 88, [0,0,1], false],
//       ["bar", 90, [0,1,0], true],
//       ["baz", 89, [1,0,0], false],
//       ["qux", 23, [1,1,1], true]
//   ];
//   idxs1 = sortidx(lst, idx=1); // Returns: [3,0,2,1]
//   idxs2 = sortidx(lst, idx=0); // Returns: [1,2,0,3]
//   idxs3 = sortidx(lst, idx=[1,3]); // Returns: [3,0,2,1]
function sortidx(list, idx=undef) = 
    assert(is_list(list)||is_string(list), "Invalid list." )
    is_homogeneous(list,1)
    ?   let( 
            size = list_shape(list[0]),
            aug  = ! (size==0 || len(size)==1) ? 0 // for general sorting
                   : [for(i=[0:len(list)-1]) concat(i,list[i])], // for scalar or vector sorting
            lidx = size==0? [1] :                                // scalar sorting
                   len(size)==1 
                   ? is_undef(idx) ? [for(i=[0:len(list[0])-1]) i+1] // vector sorting
                                   : [for(i=idx) i+1]                // vector sorting
                   : 0   // just to signal
            )
        assert( ! ( size==0 && is_def(idx) ), 
                "The specification of `idx` is incompatible with scalar sorting." ) 
        assert( _valid_idx(idx) , "Invalid indices." ) 
        lidx!=0
        ?   let( lsort = _sort_vectors(aug,lidx) )
            [for(li=lsort) li[0] ]
        :   _sort_general(list,idx,indexed=true)
    : _sort_general(list,idx,indexed=true);

// onescad: BOSL2/linalg.scad
//////////////////////////////////////////////////////////////////////
// LibFile: linalg.scad
//   This file provides linear algebra, with support for matrix construction,
//   solutions to linear systems of equations, QR and Cholesky factorizations, and
//   matrix inverse.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Math
// FileSummary: Linear Algebra: solve linear systems, construct and modify matrices.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Matrices
//   The matrix, a rectangular array of numbers which represents a linear transformation,
//   is the fundamental object in linear algebra.  In OpenSCAD a matrix is a list of lists of numbers
//   with a rectangular structure.  Because OpenSCAD treats all data the same, most of the functions that
//   index matrices or construct them will work on matrices (lists of lists) whose elements are not numbers but may be
//   arbitrary data: strings, booleans, or even other lists.  It may even be acceptable in some cases if the structure is non-rectangular.
//   Of course, linear algebra computations and solutions require true matrices with rectangular structure, where all the entries are
//   finite numbers.
//   .
//   Matrices in OpenSCAD are lists of row vectors.  However, a potential source of confusion is that OpenSCAD
//   treats vectors as either column vectors or row vectors as demanded by
//   context.  Thus both `v*M` and `M*v` are valid if `M` is square and `v` has the right length.  If you want to multiply
//   `M` on the left by `v` and `w` you can do this with `[v,w]*M` but if you want to multiply on the right side with `v` and `w` as
//   column vectors, you now need to use {{transpose()}} because OpenSCAD doesn't adjust matrices
//   contextually:  `A=M*transpose([v,w])`.  The solutions are now columns of A and you must extract
//   them with {{column()}} or take the transpose of `A`.  


// Section: Matrix testing and display
function _im_shape(list) =
  [for(;is_list(list) && len(list)>0;list=list[0]) len(list)];

function _im_check_shape(list,shape) =
  [for(i=0;
       is_list(list) && len(list)>0;
       list=list[0],i=i+1)
    if(!is_undef(shape[i]) && len(list)!=shape[i]) 1];

function _is_matrix(list,rank) =
    rank==0 && is_num(list) ? true
  : !is_list(list) ? false
  : _is_matrix(list[0], rank-1) && is_consistent(list);

// Function: is_matrix()
// Synopsis: Check if input is a numeric matrix or tensor, optionally of specified size
// Topics: Matrices
// See Also: is_matrix_symmetric(), is_rotation()
// Usage:
//   test = is_matrix(A, [m], [n], [square])
//   test = is_matrix(A, [rank=], [shape=], [equal=])
// Description:
//   Returns true if A is a numeric matrix of height m and width n with finite entries.  If m or n
//   are omitted or set to undef then returns true for any positive dimension.
//   Alternatively, checks if A is a numerical rectangular array with `rank` levels of nesting
//   (a tensor of the specified rank).  The `shape` parameter specifies required dimensions at each
//   level, and may contain `undef` to leave a particular level unconstrained.  If you give `shape`
//   then the rank is determined from its length and you cannot give `rank`.
//   .
//   You cannot mix `m`, `n` and `square` with `rank`, `shape`, and `equal`.  
// Arguments:
//   A = The matrix to test.
//   m = If given, requires the matrix to have this height.
//   n = If given, requires the matrix to have this width.
//   square = If true, matrix must have height equal to width. Default: false
//   ---
//   rank = Specify rank (nesting level) of A, a positive integer.  Default: 2
//   shape = Nonempty list specifying required dimensions of A that may contain undef entries
//   equal = If true, all dimensions of A must be equal.  Default: false
function is_matrix(A,m,n,square,rank,shape,equal)=
    let(
        matrix=!is_undef(m) || !is_undef(n) || !is_undef(square),
        tensor=!is_undef(rank) || !is_undef(shape) || !is_undef(equal)
    )
    assert(!(matrix && tensor),"Cannot mix m, n, and square with rank, shape and equal")    
    let(shape = matrix? [m,n] : assert(is_undef(shape) || (is_list(shape) && len(shape)>0), "shape must be a nonempty list")shape,
        rank = is_def(shape) ? assert(is_undef(rank),"Cannot give rank and shape") len(shape)
             : is_def(rank) ? assert(rank>0,"Must give positive rank") rank
             : 2
    )
    is_def(shape) && _im_check_shape(A,shape)!=[] ? false
  : (equal || square)
      && ( !is_list(A) || len(A)==0 || (let(Ashape=_im_shape(A)) max(Ashape)!=min(Ashape))) ? false      
  : _is_matrix(A,rank);

// Function: is_matrix_symmetric()
// Synopsis: Checks if matrix is symmetric
// Topics: Matrices
// See Also: is_matrix(), is_rotation()
// Usage:
//   b = is_matrix_symmetric(A, [eps])
// Description:
//   Returns true if the input matrix is symmetric, meaning it approximately equals its transpose.  
//   The matrix can have arbitrary entries.  
// Arguments:
//   A = matrix to test
//   eps = epsilon for comparing equality.  Default: 1e-12
function is_matrix_symmetric(A,eps=1e-12) =
    approx(A,transpose(A), eps);

// Section: Matrix indexing

// Function: column()
// Synopsis: Extract a column from a matrix.
// Topics: Matrices, List Handling, Arrays
// See Also: select(), slice()
// Usage:
//   list = column(M, i);
// Description:
//   Extracts entry `i` from each list in M, or equivalently column i from the matrix M, and returns it as a vector.  
//   This function will return `undef` at all entry positions indexed by i not found in M.
// Arguments:
//   M = The given list of lists.
//   i = The index to fetch
// Example:
//   M = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]];
//   a = column(M,2);      // Returns [3, 7, 11, 15]
//   b = column(M,0);      // Returns [1, 5, 9, 13]
//   N = [ [1,2], [3], [4,5], [6,7,8] ];
//   c = column(N,1);      // Returns [1,undef,5,7]
//   data = [[1,[3,4]], [3, [9,3]], [4, [3,1]]];   // Matrix with non-numeric entries
//   d = column(data,0);   // Returns [1,3,4]
//   e = column(data,1);   // Returns [[3,4],[9,3],[3,1]]
function column(M, i) =
    assert( is_list(M), "The input is not a list." )
    assert( is_int(i) && i>=0, "Invalid index")
    [for(row=M) row[i]];

// Function: submatrix()
// Synopsis: Extract a submatrix from a matrix
// Topics: Matrices, Arrays
// See Also: column(), block_matrix(), submatrix_set()
// Usage:
//   mat = submatrix(M, idx1, idx2);
// Description:
//   The input must be a list of lists (a matrix or 2d array).  Returns a submatrix by selecting the rows listed in idx1 and columns listed in idx2.
// Arguments:
//   M = Given list of lists
//   idx1 = rows index list or range
//   idx2 = column index list or range
// Example:
//   M = [[ 1, 2, 3, 4, 5],
//        [ 6, 7, 8, 9,10],
//        [11,12,13,14,15],
//        [16,17,18,19,20],
//        [21,22,23,24,25]];
//   submatrix(M,[1:2],[3:4]);  // Returns [[9, 10], [14, 15]]
//   submatrix(M,[1], [3,4]));  // Returns [[9,10]]
//   submatrix(M,1, [3,4]));  // Returns [[9,10]]
//   submatrix(M,1,3));  // Returns [[9]]
//   submatrix(M, [3,4],1); // Returns  [[17],[22]]);
//   submatrix(M, [1,3],[2,4]); // Returns [[8,10],[18,20]]);
//   A = [[true,    17, "test"],
//        [[4,2],   91, false],
//        [6,    [3,4], undef]];
//   submatrix(A,[0,2],[1,2]);   // Returns [[17, "test"], [[3, 4], undef]]
function submatrix(M,idx1,idx2) =
    [for(i=idx1) [for(j=idx2) M[i][j] ] ];

// Section: Matrix construction and modification

// Function: ident()
// Synopsis: Return identity matrix.
// Topics: Affine, Matrices, Transforms
// See Also: IDENT, submatrix(), column()
// Usage:
//   mat = ident(n);
// Description:
//   Create an `n` by `n` square identity matrix.
// Arguments:
//   n = The size of the identity matrix square, `n` by `n`.
// Example:
//   mat = ident(3);
//   // Returns:
//   //   [
//   //     [1, 0, 0],
//   //     [0, 1, 0],
//   //     [0, 0, 1]
//   //   ]
// Example:
//   mat = ident(4);
//   // Returns:
//   //   [
//   //     [1, 0, 0, 0],
//   //     [0, 1, 0, 0],
//   //     [0, 0, 1, 0],
//   //     [0, 0, 0, 1]
//   //   ]
function ident(n) = [
    for (i = [0:1:n-1]) [
        for (j = [0:1:n-1]) (i==j)? 1 : 0
    ]
];

// Function: transpose()
// Synopsis: Transpose a matrix
// Topics: Linear Algebra, Matrices
// See Also: submatrix(), block_matrix(), hstack(), flatten()
// Usage:
//    M = transpose(M, [reverse]);
// Description:
//    Returns the transpose of the given input matrix.  The input can be a matrix with arbitrary entries or
//    a numerical vector.  If you give a vector then transpose returns it unchanged.  
//    When reverse=true, the transpose is done across the secondary diagonal.  (See example below.)
//    By default, reverse=false.
// Arguments:
//    M = matrix to transpose
//    reverse = if true reflect across secondary diagonal.  Default: false
// Example:
//   M = [
//       [1, 2, 3],
//       [4, 5, 6],
//       [7, 8, 9]
//   ];
//   t = transpose(M);
//   // Returns:
//   // [
//   //     [1, 4, 7], 
//   //     [2, 5, 8], 
//   //     [3, 6, 9]
//   // ]
// Example:
//   M = [
//       [1, 2, 3], 
//       [4, 5, 6]
//   ];
//   t = transpose(M);
//   // Returns:
//   // [
//   //     [1, 4],
//   //     [2, 5],
//   //     [3, 6],
//   // ]
// Example:
//   M = [
//       [1, 2, 3], 
//       [4, 5, 6], 
//       [7, 8, 9]
//   ];
//   t = transpose(M, reverse=true);
//   // Returns:
//   // [
//   //  [9, 6, 3],
//   //  [8, 5, 2],
//   //  [7, 4, 1]
//   // ]
// Example: Transpose on a list of numbers returns the list unchanged
//   transpose([3,4,5]);  // Returns: [3,4,5]
// Example: Transpose on non-numeric input
//   arr = [
//       [  "a",  "b", "c"],
//       [  "d",  "e", "f"],
//       [[1,2],[3,4],[5,6]]
//   ];
//   t = transpose(arr);
//   // Returns:
//   // [
//   //     ["a", "d", [1,2]],
//   //     ["b", "e", [3,4]],
//   //     ["c", "f", [5,6]],
//   // ]
function transpose(M, reverse=false) =
    assert( is_list(M) && len(M)>0, "Input to transpose must be a nonempty list.")
    is_list(M[0])
    ?   let( len0 = len(M[0]) )
        assert([for(a=M) if(!is_list(a) || len(a)!=len0) 1 ]==[], "Input to transpose has inconsistent row lengths." )
        reverse
        ? [for (i=[0:1:len0-1]) 
              [ for (j=[0:1:len(M)-1]) M[len(M)-1-j][len0-1-i] ] ] 
        : [for (i=[0:1:len0-1]) 
              [ for (j=[0:1:len(M)-1]) M[j][i] ] ] 
    :  assert( is_vector(M), "Input to transpose must be a vector or list of lists.")
           M;

// Function: outer_product()
// Synopsis: Compute the outer product of two vectors. 
// Topics: Linear Algebra, Matrices
// See Also: submatrix(), determinant()
// Usage:
//   x = outer_product(u,v);
// Description:
//   Compute the outer product of two vectors, which is a matrix.
// Usage:
//   M = outer_product(u,v);
function outer_product(u,v) =
  assert(is_vector(u) && is_vector(v), "The inputs must be vectors.")
  [for(ui=u) ui*v];

// Function: submatrix_set()
// Synopsis: Takes a matrix as input and change values in a submatrix.
// Topics: Matrices, Arrays
// See Also: column(), submatrix()
// Usage:
//   mat = submatrix_set(M, A, [m], [n]);
// Description:
//   Sets a submatrix of M equal to the matrix A.  By default the top left corner of M is set to A, but
//   you can specify offset coordinates m and n.  If A (as adjusted by m and n) extends beyond the bounds
//   of M then the extra entries are ignored.  You can pass in `A=[[]]`, a null matrix, and M will be
//   returned unchanged.  This function works on arbitrary lists of lists and the input M need not be rectangular in shape.  
// Arguments:
//   M = Original matrix.
//   A = Submatrix of new values to write into M
//   m = Row number of upper-left corner to place A at.  Default: 0
//   n = Column number of upper-left corner to place A at.  Default: 0
function submatrix_set(M,A,m=0,n=0) =
    assert(is_list(M))
    assert(is_list(A))
    assert(is_int(m))
    assert(is_int(n))
    let( badrows = [for(i=idx(A)) if (!is_list(A[i])) i])
    assert(badrows==[], str("Input submatrix malformed rows: ",badrows))
    [for(i=[0:1:len(M)-1])
        assert(is_list(M[i]), str("Row ",i," of input matrix is not a list"))
        [for(j=[0:1:len(M[i])-1]) 
            i>=m && i <len(A)+m && j>=n && j<len(A[0])+n ? A[i-m][j-n] : M[i][j]]];

// Function: hstack()
// Synopsis: Make a new matrix by stacking matrices horizontally.
// Topics: Matrices, Arrays
// See Also: column(), submatrix(), block_matrix()
// Usage: 
//   A = hstack(M1, M2)
//   A = hstack(M1, M2, M3)
//   A = hstack([M1, M2, M3, ...])
// Description:
//   Constructs a matrix by horizontally "stacking" together compatible matrices or vectors.  Vectors are treated as columns in the stack.
//   This command is the inverse of `column`.  Note: strings given in vectors are broken apart into lists of characters.  Strings given
//   in matrices are preserved as strings.  If you need to combine vectors of strings use {{list_to_matrix()}} as shown below to convert the
//   vector into a column matrix.  Also note that vertical stacking can be done directly with concat.  
// Arguments:
//   M1 = If given with other arguments, the first matrix (or vector) to stack.  If given alone, a list of matrices/vectors to stack. 
//   M2 = Second matrix/vector to stack
//   M3 = Third matrix/vector to stack.
// Example:
//   M = ident(3);
//   v1 = [2,3,4];
//   v2 = [5,6,7];
//   v3 = [8,9,10];
//   a = hstack(v1,v2);     // Returns [[2, 5], [3, 6], [4, 7]]
//   b = hstack(v1,v2,v3);  // Returns [[2, 5,  8],
//                          //          [3, 6,  9],
//                          //          [4, 7, 10]]
//   c = hstack([M,v1,M]);  // Returns [[1, 0, 0, 2, 1, 0, 0],
//                          //          [0, 1, 0, 3, 0, 1, 0],
//                          //          [0, 0, 1, 4, 0, 0, 1]]
//   d = hstack(column(M,0), submatrix(M,idx(M),[1 2]));  // Returns M
//   strvec = ["one","two"];
//   strmat = [["three","four"], ["five","six"]];
//   e = hstack(strvec,strvec); // Returns [["o", "n", "e", "o", "n", "e"],
//                              //          ["t", "w", "o", "t", "w", "o"]]
//   f = hstack(list_to_matrix(strvec,1), list_to_matrix(strvec,1));
//                              // Returns [["one", "one"],
//                              //          ["two", "two"]]
//   g = hstack(strmat,strmat); //  Returns: [["three", "four", "three", "four"],
//                              //            [ "five",  "six",  "five",  "six"]]
function hstack(M1, M2, M3) =
    (M3!=undef)? hstack([M1,M2,M3]) : 
    (M2!=undef)? hstack([M1,M2]) :
    assert(all([for(v=M1) is_list(v)]), "One of the inputs to hstack is not a list")
    let(
        minlen = min_length(M1),
        maxlen = max_length(M1)
    )
    assert(minlen==maxlen, "Input vectors to hstack must have the same length")
    [for(row=[0:1:minlen-1])
        [for(matrix=M1)
           each matrix[row]
        ]
    ];

// Section: Solving Linear Equations and Matrix Factorizations

// Function: linear_solve()
// Synopsis: Solve Ax=b or, for overdetermined case, solve the least square problem. 
// Topics: Matrices, Linear Algebra
// See Also: linear_solve3(), matrix_inverse(), rot_inverse(), back_substitute(), cholesky()
// Usage:
//   solv = linear_solve(A,b,[pivot])
// Description:
//   Solves the linear system Ax=b.  By default, uses the QR factorization, which is the slowest but most flexible
//   solution method.  If `A` is square and non-singular the unique solution is returned.  If `A` is overdetermined
//   the least squares solution is returned. If `A` is underdetermined, the minimal norm solution is returned.
//   If `A` is rank deficient or singular then linear_solve returns `[]`.  If `b` is a matrix that is compatible with `A`
//   then the problem is solved for the matrix valued right hand side and a matrix is returned.  Note that if you 
//   want to solve Ax=b1 and Ax=b2 that you need to form the matrix `transpose([b1,b2])` for the right hand side and then
//   transpose the returned value.  If `pivot` is set to true (the default) then
//   pivoting is used in the QR factorization, which is slower but expected to be more accurate.
//   .
//   If `A` is a square matrix you can select `method="lu"` to use LU decomposition, which may be slightly faster than QR on small problems.
//   .
//   If `A` is symmetric and positive definite then `method="cholesky"` is faster than LU decomposition.
//   (About 5x faster than LU decomposition on large problems.)
// Arguments:
//   A = Matrix describing the linear system, which need not be square
//   b = right hand side for linear system, which can be a matrix to solve several cases simultaneously.  Must be consistent with A.
//   pivot = if true use pivoting when computing the QR factorization.  Default: true
//   method = Set to "qr", "lu" or "cholesky" to choose the solution method.  Default: "qr"
function linear_solve(A,b,pivot=true,method="qr") =
    assert(is_matrix(A), "Input should be a matrix.")
    assert(in_list(method,["qr","cholesky","lu"]))
    let(
        m = len(A),
        n = len(A[0])
    )
    assert(is_vector(b,m) || is_matrix(b,m),"Invalid right hand side or incompatible with the matrix")
    method=="cholesky" ? let(
                             U=cholesky(A,transpose=true)
                         )
                         is_undef(U) ? []
                       :
                         back_substitute(U,back_substitute(U,b,transpose=true))
  : method=="lu" ? let(
                        LUP = lu_factor(A)
                   )
                   is_undef(LUP) ? []
                 :
                   back_substitute(LUP[1],
                                   back_substitute(LUP[0],
                                                   select(b,LUP[2]),transpose=true)
                   )
  :
    let (
        qr = m<n? qr_factor(transpose(A),pivot) : qr_factor(A,pivot),
        maxdim = max(n,m),
        mindim = min(n,m),
        Q = submatrix(qr[0],[0:maxdim-1], [0:mindim-1]),
        R = submatrix(qr[1],[0:mindim-1], [0:mindim-1]),
        P = qr[2],
        zeros = [for(i=[0:mindim-1]) if (approx(R[i][i],0)) i]
    )
    zeros != [] ? [] :
    m<n ? Q*back_substitute(R,transpose(P)*b,transpose=true) // Too messy to avoid input checks here
        : P*_back_substitute(R, transpose(Q)*b);

// Function: linear_solve3()
// Synopsis: Fast solution to Ax=b where A is 3x3.
// Topics: Matrices, Linear Algebra
// See Also: linear_solve(), matrix_inverse(), rot_inverse(), back_substitute(), cholesky()
// Usage:
//   x = linear_solve3(A,b)
// Description:
//   Fast solution to a 3x3 linear system using Cramer's rule (which appears to be the fastest
//   method in OpenSCAD).  The input `A` must be a 3x3 matrix.  Returns undef if `A` is singular.
//   The input `b` must be a 3-vector.  Note that Cramer's rule is not a stable algorithm, so for
//   the highest accuracy on ill-conditioned problems you may want to use the general solver, which is about ten times slower.
// Arguments:
//   A = 3x3 matrix for linear system
//   b = length 3 vector, right hand side of linear system
function linear_solve3(A,b) =
  // Arg sanity checking adds 7% overhead
  assert(b*0==[0,0,0], "Input b must be a 3-vector")
  assert(A*0==[[0,0,0],[0,0,0],[0,0,0]],"Input A must be a 3x3 matrix")
  let(
      Az = [for(i=[0:2])[A[i][0], A[i][1], b[i]]],
      Ay = [for(i=[0:2])[A[i][0], b[i], A[i][2]]],
      Ax = [for(i=[0:2])[b[i], A[i][1], A[i][2]]],
      detA = det3(A)
  )
  detA==0 ? undef : [det3(Ax), det3(Ay), det3(Az)] / detA;

// Function: rot_inverse()
// Synopsis: Invert 2d or 3d rotation transformations. 
// Topics: Matrices, Linear Algebra, Affine
// See Also: linear_solve(), linear_solve3(), matrix_inverse(), rot_inverse(), back_substitute(), cholesky()
// Usage:
//   B = rot_inverse(A)
// Description:
//   Inverts a 2d (3x3) or 3d (4x4) rotation matrix.  The matrix can be a rotation around any center,
//   so it may include a translation.  This is faster and likely to be more accurate than using `matrix_inverse()`.
function rot_inverse(T) =
    assert(is_matrix(T,square=true),"Matrix must be square")
    let( n = len(T))
    assert(n==3 || n==4, "Matrix must be 3x3 or 4x4")
    let(
        rotpart =  [for(i=[0:n-2]) [for(j=[0:n-2]) T[j][i]]],
        transpart = [for(row=[0:n-2]) T[row][n-1]]
    )
    assert(approx(determinant(T),1),"Matrix is not a rotation")
    concat(hstack(rotpart, -rotpart*transpart),[[for(i=[2:n]) 0, 1]]);

// Function: qr_factor()
// Synopsis: Compute QR factorization of a matrix.
// Topics: Matrices, Linear Algebra
// See Also: linear_solve(), linear_solve3(), matrix_inverse(), rot_inverse(), back_substitute(), cholesky()
// Usage:
//   qr = qr_factor(A,[pivot]);
// Description:
//   Calculates the QR factorization of the input matrix A and returns it as the list [Q,R,P].  This factorization can be
//   used to solve linear systems of equations.  The factorization is `A = Q*R*transpose(P)`.  If pivot is false (the default)
//   then P is the identity matrix and A = Q*R.  If pivot is true then column pivoting results in an R matrix where the diagonal
//   is non-decreasing.  The use of pivoting is supposed to increase accuracy for poorly conditioned problems, and is necessary
//   for rank estimation or computation of the null space, but it may be slower.
function qr_factor(A, pivot=false) =
    assert(is_matrix(A), "Input must be a matrix." )
    let(
        m = len(A),
        n = len(A[0])
    )
    let(
        qr = _qr_factor(transpose(A), Q=ident(m),p=count(n), pivot=pivot, col=0, m = m, n = n),
        Rzero = let( R = transpose(qr[1])) [
            for(i=[0:m-1]) [
                let( ri = R[i] )
                for(j=[0:n-1]) i>j ? 0 : ri[j]
            ]
        ]
    ) [transpose(qr[0]), Rzero, _makeP(qr[2])];

// make permutation matrix, multiply on the right to permute columns
function _makeP(p) =
  [
   for(i=[0:len(p)-1])
     [for(j=[0:len(p)-1])
        p[j]==i ? 1 : 0]];

function _qr_factor(A, Q, p, pivot, col, m, n) =
    col >= min(m-1, n) ? [Q, A, p] :
    let(
        swapind = !pivot ? undef
                : col+max_index([for(i=[col:n-1]) norm(slice(A[i],col,m-1))]),
        A = pivot ? list_swap(A,col,swapind) : A,
        p = pivot ? list_swap(p,col,swapind) : p,
        x = slice(A[col],col,m-1),
        alpha = (x[0] <= 0 ? 1 : -1) * norm(x),
        u = x - concat([alpha], repeat(0, len(x)-1)),
        nrm = norm(u),
        v = nrm == 0 ? u : u/nrm, 

        // Apply H to submatrix of A: Hsub*Asub = Asub - 2*v*(v^T*Asub)
        Asub = submatrix(A,[col:n-1],[col:m-1]),
        vtA = Asub*v,
        Asub_new = Asub - 2*outer_product(vtA,v),
        // Write updated submatrix back into A
        Anew = [for(j=[0:n-1])
                  j < col ? A[j]
                        : [
                            for(i=[0:1:col-1]) A[j][i],
                            each Asub_new[j-col]
                            ]
                  ],
        // Accumulate Q: Q = Q*H = Q - 2*(Q*v)*v^T  (only columns col: matter)
        Qvsub = v * slice(Q,col,-1),
        Qnew =  [for(j=[0:m-1])
                   j < col ? Q[j]
                           : Q[j] - 2*Qvsub*v[j-col]]
    )
    _qr_factor(Anew, Qnew, p, pivot, col+1, m, n);

// Produces an n x n matrix that swaps column i and j (when multiplied on the right)
function _swap_matrix(n,i,j) =
  assert(i<n && j<n && i>=0 && j>=0, "Swap indices out of bounds")
  [for(y=[0:n-1]) [for (x=[0:n-1])
     x==i ? (y==j ? 1 : 0)
   : x==j ? (y==i ? 1 : 0)
   : x==y ? 1 : 0]];

// Function: lu_factor()
// Synopsis: Compute LU factorization of a matrix with pivoting.
// Topics: Matrices, Linear Algebra
// See Also: linear_solve(), linear_solve3(), matrix_inverse(), rot_inverse(), back_substitute(), cholesky()
// Usage:
//   lt_u_p = lu_factor(A);
// Description:
//   Calculates the LU factorization of the input matrix A with pivoting [LT,U,p].  This factorization can be
//   used to solve linear systems of equations and is equivalent to Gaussian elimination.
//   The factorization is `select(A,p) = transpose(LT) * U`. The permutation `p` is an index list, not a matrix.
//   The LU decomposition only works on square,  nonsingular matrices.  If `A` is singular then returns undef.
function lu_factor(A) =
   assert(is_matrix(A,square=true), "Input must be a square matrix." )
   let(n=len(A))
   _lu_factor([], A, count(n), 0);

function _lu_factor(L,U,perm,k)=
   let(
       n = len(U)
   )
   k==n-1? [[each L,[each repeat(0,n-1),1]],U,perm]
 :
   let(
       p = k==0 ? 0 : k + max_index([for(i=[k:n-1]) abs(U[i][k])]),
       U = _swap_entries(U,p,k),
       L = p==k ? L : L * _swap_matrix(n,p,k),
       perm = _swap_entries(perm,p,k)
   )
   abs(U[k][k]) < _EPSILON ? undef
 :
  let(
      Lnew = [ each L,
               [each repeat(0,k),
                1,
                for(i=[k+1:n-1]) U[i][k] / U[k][k]
               ]
             ],
      Unew = [for(i=[0:n-1])
               i<=k ? U[i]
                    : [for (j=[0:n-1])
                             j<=k ? 0
                                  : U[i][j] - Lnew[k][i] * U[k][j]
                      ]
             ]
   )
   _lu_factor(Lnew,Unew,perm,k+1);

function _swap_entries(v,i,j) =
  i==j ? v : 
  [for(k=[0:len(v)-1]) k==i ? v[j]
                  : k==j ? v[i]
                  : v[k]
  ];

// Function: back_substitute()
// Synopsis: Solve an upper triangular system, Rx=b.  
// Topics: Matrices, Linear Algebra
// See Also: linear_solve(), linear_solve3(), matrix_inverse(), rot_inverse(), back_substitute(), cholesky()
// Usage:
//   x = back_substitute(R, b, [transpose]);
// Description:
//   Solves the problem Rx=b where R is an upper triangular square matrix.  The lower triangular entries of R are
//   ignored.  If transpose==true then instead solve transpose(R)*x=b.
//   You can supply a compatible matrix b and it will produce the solution for every column of b.  Note that if you want to
//   solve Rx=b1 and Rx=b2 you must set b to transpose([b1,b2]) and then take the transpose of the result.  If the matrix
//   is singular (e.g. has a zero on the diagonal) then it returns [].
function back_substitute(R, b, transpose = false) =
    assert(is_matrix(R, square=true))
    let(n=len(R))
    assert(is_vector(b,n) || is_matrix(b,n),str("R and b are not compatible in back_substitute ",n, len(b)))
    transpose
      ? reverse(_back_substitute(transpose(R, reverse=true), reverse(b)))  
      : _back_substitute(R,b);

function _back_substitute(R, b, x=[]) =
    let(n=len(R))
    len(x) == n ? x
    : let(ind = n - len(x) - 1)
      R[ind][ind] == 0 ? []
    : let(
          newvalue = len(x)==0
            ? b[ind]/R[ind][ind]
            : (b[ind]-list_tail(R[ind],ind+1) * x)/R[ind][ind]
      )
      _back_substitute(R, b, concat([newvalue],x));

// Function: cholesky()
// Synopsis: Compute the Cholesky factorization of a matrix. 
// Topics: Matrices, Linear Algebra
// See Also: linear_solve(), linear_solve3(), matrix_inverse(), rot_inverse(), back_substitute(), cholesky()
// Usage:
//   L = cholesky(A);
// Description:
//   Compute the cholesky factor, L, of the symmetric positive definite matrix A.
//   The matrix L is lower triangular and `L * transpose(L) = A`.  If the A is
//   not symmetric then an error is displayed.  If the matrix is symmetric but
//   not positive definite then undef is returned.
function cholesky(A,transpose=false) =
  assert(is_matrix(A,square=true),"A must be a square matrix")
  assert(is_matrix_symmetric(A),"Cholesky factorization requires a symmetric matrix")
  let (U=_cholesky(A))
  transpose || is_undef(U) ? U : transpose(U);

function _cholesky(A,j=0) =
    let(n=len(A))
    j==n ? A
  :
    let(
       newrow = j==0 ? A[j]
              : select(A[j],j,n-1) - ([[for(i=[0:j-1]) A[i][j]]] * submatrix(A,[0:j-1],[j:n-1]))[0]
    )
    newrow[0]<=0 ? undef   // Matrix not positive definite
  :
    let(
       newA = [for(i=[0:n-1]) i!=j ? A[i]
                                   : concat(repeat(0,j),newrow/sqrt(newrow[0]))]
    )
    _cholesky(newA,j+1);

// Section: Matrix Properties: Determinants, Norm, Trace

// Function: det2()
// Synopsis: Compute determinant of 2x2 matrix.
// Topics: Matrices, Linear Algebra
// See Also: det2(), det3(), det4(), determinant(), norm_fro(), matrix_trace()
// Usage:
//   d = det2(M);
// Description:
//   Rturns the determinant for the given 2x2 matrix.
// Arguments:
//   M = The 2x2 matrix to get the determinant of.
// Example:
//   M = [ [6,-2], [1,8] ];
//   det = det2(M);  // Returns: 50
function det2(M) = 
    assert(is_def(M) && M*0==[[0,0],[0,0]], "Expected square matrix (2x2)")
    cross(M[0],M[1]);

// Function: det3()
// Synopsis: Compute determinant of 3x3 matrix.
// Topics: Matrices, Linear Algebra
// See Also: det2(), det3(), det4(), determinant(), norm_fro(), matrix_trace()
// Usage:
//   d = det3(M);
// Description:
//   Returns the determinant for the given 3x3 matrix.
// Arguments:
//   M = The 3x3 square matrix to get the determinant of.
// Example:
//   M = [ [6,4,-2], [1,-2,8], [1,5,7] ];
//   det = det3(M);  // Returns: -334
function det3(M) =
    assert(is_def(M) && M*0==[[0,0,0],[0,0,0],[0,0,0]], "Expected square matrix (3x3).")
    M[0][0] * (M[1][1]*M[2][2]-M[2][1]*M[1][2]) -
    M[1][0] * (M[0][1]*M[2][2]-M[2][1]*M[0][2]) +
    M[2][0] * (M[0][1]*M[1][2]-M[1][1]*M[0][2]);

// Function: det4()
// Synopsis: Compute determinant of 4x4 matrix. 
// Topics: Matrices, Linear Algebra
// See Also: det2(), det3(), det4(), determinant(), norm_fro(), matrix_trace()
// Usage:
//   d = det4(M);
// Description:
//   Returns the determinant for the given 4x4 matrix.
// Arguments:
//   M = The 4x4 square matrix to get the determinant of.
// Example:
//   M = [ [6,4,-2,1], [1,-2,8,-3], [1,5,7,4], [2,3,4,7] ];
//   det = det4(M);  // Returns: -1773
function det4(M) =
    assert(is_def(M) && M*0==[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], "Expected square matrix (4x4).")
    M[0][0]*M[1][1]*M[2][2]*M[3][3] + M[0][0]*M[1][2]*M[2][3]*M[3][1] + M[0][0]*M[1][3]*M[2][1]*M[3][2]
    + M[0][1]*M[1][0]*M[2][3]*M[3][2] + M[0][1]*M[1][2]*M[2][0]*M[3][3] + M[0][1]*M[1][3]*M[2][2]*M[3][0]
    + M[0][2]*M[1][0]*M[2][1]*M[3][3] + M[0][2]*M[1][1]*M[2][3]*M[3][0] + M[0][2]*M[1][3]*M[2][0]*M[3][1]
    + M[0][3]*M[1][0]*M[2][2]*M[3][1] + M[0][3]*M[1][1]*M[2][0]*M[3][2] + M[0][3]*M[1][2]*M[2][1]*M[3][0]
    - M[0][0]*M[1][1]*M[2][3]*M[3][2] - M[0][0]*M[1][2]*M[2][1]*M[3][3] - M[0][0]*M[1][3]*M[2][2]*M[3][1]
    - M[0][1]*M[1][0]*M[2][2]*M[3][3] - M[0][1]*M[1][2]*M[2][3]*M[3][0] - M[0][1]*M[1][3]*M[2][0]*M[3][2]
    - M[0][2]*M[1][0]*M[2][3]*M[3][1] - M[0][2]*M[1][1]*M[2][0]*M[3][3] - M[0][2]*M[1][3]*M[2][1]*M[3][0]
    - M[0][3]*M[1][0]*M[2][1]*M[3][2] - M[0][3]*M[1][1]*M[2][2]*M[3][0] - M[0][3]*M[1][2]*M[2][0]*M[3][1];

// Function: determinant()
// Synopsis: compute determinant of an arbitrary square matrix. 
// Topics: Matrices, Linear Algebra
// See Also: det2(), det3(), det4(), determinant(), norm_fro(), matrix_trace()
// Usage:
//   d = determinant(M);
// Description:
//   Returns the determinant for the given square matrix.
// Arguments:
//   M = The NxN square matrix to get the determinant of.
// Example:
//   M = [ [6,4,-2,9], [1,-2,8,3], [1,5,7,6], [4,2,5,1] ];
//   det = determinant(M);  // Returns: 2267
function determinant(M) =
    assert(is_list(M), "Input must be a square matrix." )  
    len(M)==1? M[0][0] :
    len(M)==2? det2(M) :
    len(M)==3? det3(M) :
    len(M)==4? det4(M) :
    assert(is_matrix(M, square=true), "Input must be a square matrix." )    
    sum(
        [for (col=[0:1:len(M)-1])
            ((col%2==0)? 1 : -1) *
                M[col][0] *
                determinant(
                    [for (r=[1:1:len(M)-1])
                        [for (c=[0:1:len(M)-1])
                            if (c!=col) M[c][r]
                        ]
                    ]
                )
        ]
    );

// Function: norm_fro()
// Synopsis: Compute Frobenius norm of a matrix
// Topics: Matrices, Linear Algebra
// See Also: det2(), det3(), det4(), determinant(), norm_fro(), matrix_trace()
// Usage:
//    norm_fro(A)
// Description:
//    Computes frobenius norm of input matrix.  The frobenius norm is the square root of the sum of the
//    squares of all of the entries of the matrix.  On vectors it is the same as the usual 2-norm.
//    This is an easily computed norm that is convenient for comparing two matrices.
function norm_fro(A) =
    assert(is_matrix(A) || is_vector(A))
    norm(flatten(A));

// Function: matrix_trace()
// Synopsis: Compute the trace of a square matrix. 
// Topics: Matrices, Linear Algebra
// See Also: det2(), det3(), det4(), determinant(), norm_fro(), matrix_trace()
// Usage:
//   matrix_trace(M)
// Description:
//   Computes the trace of a square matrix, the sum of the entries on the diagonal.
function matrix_trace(M) =
   assert(is_matrix(M,square=true), "Input to trace must be a square matrix")
   [for(i=[0:1:len(M)-1])1] * [for(i=[0:1:len(M)-1]) M[i][i]];

// onescad: BOSL2/trigonometry.scad
//////////////////////////////////////////////////////////////////////
// LibFile: trigonometry.scad
//   Trigonometry shortcuts for people who can't be bothered to remember
//   all the function relations, or silly acronyms like SOHCAHTOA.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Math
// FileSummary: Trigonometry shortcuts for when you can't recall the mnemonic SOHCAHTOA.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Function: law_of_sines()
// Synopsis: Applies the Law of Sines for an arbitrary triangle.
// Topics: Geometry, Trigonometry, Triangles
// See Also: law_of_cosines()
// Usage:
//   B = law_of_sines(a, A, b);
//   b = law_of_sines(a, A, B=);
// Description:
//   Applies the Law of Sines for an arbitrary triangle.  Given side lengths `a` and `b` and the angle `A`
//   opposite `a`, returns the principal angle `B` opposite `b`.  A supplementary solution `180-B` may also
//   form a triangle when `A+(180-B)<180`.  Given `a`, its opposite angle `A`, and a second angle `B`,
//   returns the side opposite `B`.  Impossible combinations of positive sides and angles produce an error.
// Figure(2D;NoAxes;VPD=200;VPT=[0,25,0]):
//   stroke([[-50,0], [10,60], [50,0]], closed=true, width=2);
//   color("black") {
//       translate([ 33,35]) text(text="a", size=8, halign="center", valign="center");
//       translate([  0,-6]) text(text="b", size=8, halign="center", valign="center");
//       translate([-22,35]) text(text="c", size=8, halign="center", valign="center");
//   }
//   color("blue") {
//       translate([-37, 6]) text(text="A", size=8, halign="center", valign="center");
//       translate([  9,51]) text(text="B", size=8, halign="center", valign="center");
//       translate([ 38, 6]) text(text="C", size=8, halign="center", valign="center");
//   }
// Arguments:
//   a = The length of the first side.
//   A = The reference angle in degrees of the corner opposite of the first side.
//   b = The length of the second side.
//   ---
//   B = The reference angle in degrees of the corner opposite of the second side.
function law_of_sines(a, A, b, B) =
    // Triangle Law of Sines:
    //   a/sin(A) = b/sin(B) = c/sin(C)
    assert(num_defined([b,B]) == 1, "Must give exactly one of b= or B=.")
    let( r = a/sin(A) )
    is_undef(b) ?
        assert(!all_positive([a,A,B]) || A+B<180, "Triangle angles must sum to less than 180 degrees.")
        r*sin(B) :
    let(sinB = b/r, angleB = asin(constrain(sinB, -1, 1)))
    assert(!all_positive([a,A,b]) || (A<180 && sinB<=1+_EPSILON && A+angleB<180),
           "Side lengths and angle do not form a triangle.")
    angleB;

// Function: opp_ang_to_adj()
// Synopsis: Returns the adjacent side length from the length of the opposite side and the reference reference angle.
// Topics: Geometry, Trigonometry, Triangles
// See Also: adj_ang_to_hyp(), adj_ang_to_opp(), adj_opp_to_ang(), adj_opp_to_hyp(), hyp_adj_to_ang(), hyp_adj_to_opp(), hyp_ang_to_adj(), hyp_ang_to_opp(), hyp_opp_to_adj(), hyp_opp_to_ang(), opp_ang_to_adj(), opp_ang_to_hyp(), ang_adj_to_hyp(), ang_adj_to_opp(), opp_adj_to_ang(), opp_adj_to_hyp(), adj_hyp_to_ang(), adj_hyp_to_opp(), ang_hyp_to_adj(), ang_hyp_to_opp(), opp_hyp_to_adj(), opp_hyp_to_ang(), ang_opp_to_adj(), ang_opp_to_hyp()
// Usage:
//   adj = opp_ang_to_adj(opp,ang);
// Description:
//   Given the length of the opposite side and the reference reference angle of a right triangle,
//   returns the length of the adjacent side.
// Arguments:
//   opp = The length of the side of the right triangle that is opposite from the reference reference angle.
//   ang = The reference reference angle of the right triangle in degrees
// Example:
//   adj = opp_ang_to_adj(8,45);  // Returns: 8
function opp_ang_to_adj(opp,ang) =
    assert(is_finite(opp) && opp>=0, "Triangle side length should be a positive number." )
    assert(is_finite(ang) && ang>-90 && ang<90, "The reference angle should be an acute reference angle." )
    opp/tan(ang);

// Function: adj_ang_to_opp()
// Synopsis: Returns the opposite side length from the length of the adjacent side and the reference reference angle.
// Topics: Geometry, Trigonometry, Triangles
// See Also: adj_ang_to_hyp(), adj_ang_to_opp(), adj_opp_to_ang(), adj_opp_to_hyp(), hyp_adj_to_ang(), hyp_adj_to_opp(), hyp_ang_to_adj(), hyp_ang_to_opp(), hyp_opp_to_adj(), hyp_opp_to_ang(), opp_ang_to_adj(), opp_ang_to_hyp(), ang_adj_to_hyp(), ang_adj_to_opp(), opp_adj_to_ang(), opp_adj_to_hyp(), adj_hyp_to_ang(), adj_hyp_to_opp(), ang_hyp_to_adj(), ang_hyp_to_opp(), opp_hyp_to_adj(), opp_hyp_to_ang(), ang_opp_to_adj(), ang_opp_to_hyp()
// Usage:
//   opp = adj_ang_to_opp(adj,ang);
// Description:
//   Given the length of the adjacent side of a right triangle, and the reference reference angle, returns the length of the opposite side.
// Arguments:
//   adj = The length of the side of the right triangle that is adjacent to the reference reference angle.
//   ang = The reference reference angle of the right triangle in degrees
// Example:
//   opp = adj_ang_to_opp(8,45);  // Returns: 8
function adj_ang_to_opp(adj,ang) =
    assert(is_finite(adj)&&adj>=0, "Triangle side length should be a positive number." )
    assert(is_finite(ang) && ang>-90 && ang<90, "The reference angle should be an acute reference angle." )
    adj*tan(ang);

// Function: adj_ang_to_hyp()
// Synopsis: Returns the hypotenuse length from the length of the adjacent side and the reference reference angle.
// Topics: Geometry, Trigonometry, Triangles
// See Also: adj_ang_to_hyp(), adj_ang_to_opp(), adj_opp_to_ang(), adj_opp_to_hyp(), hyp_adj_to_ang(), hyp_adj_to_opp(), hyp_ang_to_adj(), hyp_ang_to_opp(), hyp_opp_to_adj(), hyp_opp_to_ang(), opp_ang_to_adj(), opp_ang_to_hyp(), ang_adj_to_hyp(), ang_adj_to_opp(), opp_adj_to_ang(), opp_adj_to_hyp(), adj_hyp_to_ang(), adj_hyp_to_opp(), ang_hyp_to_adj(), ang_hyp_to_opp(), opp_hyp_to_adj(), opp_hyp_to_ang(), ang_opp_to_adj(), ang_opp_to_hyp()
// Usage:
//   hyp = adj_ang_to_hyp(adj,ang);
// Description:
//   For a right triangle, given the length of the adjacent side, and the reference reference angle, returns the length of the hypotenuse.
// Arguments:
//   adj = The length of the side of the right triangle that is adjacent to the reference reference angle.
//   ang = The reference reference angle of the right triangle in degrees
// Example:
//   hyp = adj_ang_to_hyp(4,60);  // Returns: 8
function adj_ang_to_hyp(adj,ang) =
    assert(is_finite(adj) && adj>=0, "Triangle side length should be a positive number." )
    assert(is_finite(ang) && ang>-90 && ang<90, "The reference angle should be an acute reference angle." )
    adj/cos(ang);

// Function: opp_ang_to_hyp()
// Synopsis: Returns the hypotenuse length from the length of the opposite side and the reference reference angle.
// Topics: Geometry, Trigonometry, Triangles
// See Also: adj_ang_to_hyp(), adj_ang_to_opp(), adj_opp_to_ang(), adj_opp_to_hyp(), hyp_adj_to_ang(), hyp_adj_to_opp(), hyp_ang_to_adj(), hyp_ang_to_opp(), hyp_opp_to_adj(), hyp_opp_to_ang(), opp_ang_to_adj(), opp_ang_to_hyp(), ang_adj_to_hyp(), ang_adj_to_opp(), opp_adj_to_ang(), opp_adj_to_hyp(), adj_hyp_to_ang(), adj_hyp_to_opp(), ang_hyp_to_adj(), ang_hyp_to_opp(), opp_hyp_to_adj(), opp_hyp_to_ang(), ang_opp_to_adj(), ang_opp_to_hyp()
// Usage:
//   hyp = opp_ang_to_hyp(opp,ang);
// Description:
//   For a right triangle, given the length of the opposite side, and the reference reference angle, returns the length of the hypotenuse.
// Arguments:
//   opp = The length of the side of the right triangle that is opposite from the reference reference angle.
//   ang = The reference reference angle of the right triangle in degrees
// Example:
//   hyp = opp_ang_to_hyp(4,30);  // Returns: 8
function opp_ang_to_hyp(opp,ang) =
    assert(is_finite(opp) && opp>=0, "Triangle side length should be a positive number." )
    assert(is_finite(ang) && ang>-90 && ang<90, "The reference angle should be an acute reference angle." )
    opp/sin(ang);

// onescad: BOSL2/vectors.scad
//////////////////////////////////////////////////////////////////////
// LibFile: vectors.scad
//   This file provides some mathematical operations that apply to each
//   entry in a vector.  It provides normalization and angle computation, and
//   it provides functions for searching lists of vectors for matches to
//   a given vector.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Math
// FileSummary: Vector arithmetic, angle, and searching.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Vector Testing


// Function: is_vector()
// Synopsis: Returns true if the given value is a vector.
// Topics: Vectors, Math
// See Also: is_matrix(), is_path(), is_region()
// Usage:
//   bool = is_vector(v, [length], [zero=], [all_nonzero=], [eps=]);
// Description:
//   Returns true if v is a list of finite numbers.
// Arguments:
//   v = The value to test to see if it is a vector.
//   length = If given, make sure the vector is `length` items long.
//   ---
//   zero = If false, require that the `norm()` of the vector is not approximately zero.  If true, require the `norm()` of the vector to be approximately zero.  Default: `undef` (don't check vector `norm()`.)
//   all_nonzero = If true, requires all elements of the vector to be more than `eps` different from zero.  Default: `false`
//   eps = The minimum vector length that is considered non-zero.  Default: 1e-9
// Example:
//   is_vector(4);                          // Returns false
//   is_vector([4,true,false]);             // Returns false
//   is_vector([3,4,INF,5]);                // Returns false
//   is_vector([3,4,5,6]);                  // Returns true
//   is_vector([3,4,undef,5]);              // Returns false
//   is_vector([3,4,5],3);                  // Returns true
//   is_vector([3,4,5],4);                  // Returns false
//   is_vector([]);                         // Returns false
//   is_vector([0,4,0],3,zero=false);       // Returns true
//   is_vector([0,0,0],zero=false);         // Returns false
//   is_vector([0,0,1e-12],zero=false);     // Returns false
//   is_vector([0,1,0],all_nonzero=true);   // Returns false
//   is_vector([1,1,1],all_nonzero=true);   // Returns true
//   is_vector([],zero=false);              // Returns false
function is_vector(v, length, zero, all_nonzero=false, eps=_EPSILON) =
    is_list(v) && len(v)>0 && []==[for(vi=v) if(!is_finite(vi)) 0] 
    && (is_undef(length) || (assert(is_num(length))len(v)==length))
    && (is_undef(zero) || ((norm(v) >= eps) == !zero))
    && (!all_nonzero || all_nonzero(v,eps)) ;

// Section: Scalar operations on vectors

// Function: add_scalar()
// Synopsis: Adds a scalar value to every item in a vector.
// Topics: Vectors, Math
// See Also: v_mul(), v_div()
// Usage:  
//   v_new = add_scalar(v, s);
// Description:
//   Given a vector and a scalar, returns the vector with the scalar added to each item in it.
// Arguments:
//   v = The initial array.
//   s = A scalar value to add to every item in the array.
// Example:
//   a = add_scalar([1,2,3],3);            // Returns: [4,5,6]
function add_scalar(v,s) =
    assert(is_vector(v), "\nInput v must be a vector.")
    assert(is_finite(s), "\nInput s must be a finite scalar.")
    [for(entry=v) entry+s];

// Function: v_mul()
// Synopsis: Returns the element-wise multiplication of two equal-length vectors.
// Topics: Vectors, Math
// See Also: add_scalar(), v_div()
// Usage:
//   v3 = v_mul(v1, v2);
// Description:
//   Element-wise multiplication.  Multiplies each element of `v1` by the corresponding element of `v2`.
//   Both `v1` and `v2` must be the same length.  Returns a vector of the products. 
//   The items in `v1` and `v2` can be anything that OpenSCAD can multiply together.  
// Arguments:
//   v1 = The first vector.
//   v2 = The second vector.
// Example:
//   v_mul([3,4,5], [8,7,6]);  // Returns [24, 28, 30]
function v_mul(v1, v2) = 
    assert( is_list(v1) && is_list(v2) && len(v1)==len(v2), "\nIncompatible input.")
    [for (i = [0:1:len(v1)-1]) v1[i]*v2[i]];

// Function: v_abs()
// Synopsis: Returns the absolute values of the given vector.
// Topics: Vectors, Math
// See Also: v_ceil(), v_floor(), v_round()
// Usage:
//   v2 = v_abs(v);
// Description: Returns a vector of the absolute value of each element of vector `v`.
// Arguments:
//   v = The vector to get the absolute values of.
// Example:
//   v_abs([-1,3,-9]);  // Returns: [1,3,9]
function v_abs(v) =
    assert( is_vector(v), "\nInvalid vector." ) 
    [for (x=v) abs(x)];

// Section: Vector Properties


// Function: unit()
// Synopsis: Returns the unit length of a given vector.
// Topics: Vectors, Math
// See Also: v_abs(), v_floor(), v_ceil(), v_round()
// Usage:
//   v = unit(v, [error]);
// Description:
//   Returns the unit length normalized version of vector v.  If passed a zero-length vector,
//   asserts an error unless `error` is given, in which case the value of `error` is returned.
// Arguments:
//   v = The vector to normalize.
//   error = If given, and input is a zero-length vector, this value is returned.  Default: Assert error on zero-length vector.
// Example:
//   v1 = unit([10,0,0]);   // Returns: [1,0,0]
//   v2 = unit([0,10,0]);   // Returns: [0,1,0]
//   v3 = unit([0,0,10]);   // Returns: [0,0,1]
//   v4 = unit([0,-10,0]);  // Returns: [0,-1,0]
//   v5 = unit([0,0,0],[1,2,3]);    // Returns: [1,2,3]
//   v6 = unit([0,0,0]);    // Asserts an error.
function unit(v, error=[[["ASSERT"]]]) =
    assert(is_vector(v), "\nInvalid vector.")
    norm(v)<_EPSILON? (error==[[["ASSERT"]]]? assert(norm(v)>=_EPSILON,"\nCannot normalize a zero vector.") : error) :
    v/norm(v);

// Function: v_theta()
// Synopsis: Returns the angle counter-clockwise from X+ on the XY plane.
// Topics: Vectors, Math
// See Also: unit()
// Usage:
//   theta = v_theta([X,Y]);
// Description:
//   Given a vector, returns the angle in degrees counter-clockwise from X+ on the XY plane.
function v_theta(v) =
    assert( is_vector(v,2) || is_vector(v,3) , "\nInvalid vector.")
    atan2(v.y,v.x);

// Function: vector_angle()
// Synopsis: Returns the minor angle between two vectors.
// Topics: Vectors, Math
// See Also: unit(), v_theta()
// Usage:
//   ang = vector_angle(v1,v2);
//   ang = vector_angle([v1,v2]);
//   ang = vector_angle(PT1,PT2,PT3);
//   ang = vector_angle([PT1,PT2,PT3]);
// Description:
//   If given a single list of two vectors, like `vector_angle([V1,V2])`, returns the angle between the two vectors V1 and V2.
//   If given a single list of three points, like `vector_angle([A,B,C])`, returns the angle between the line segments AB and BC.
//   If given two vectors, like `vector_angle(V1,V2)`, returns the angle between the two vectors V1 and V2.
//   If given three points, like `vector_angle(A,B,C)`, returns the angle between the line segments AB and BC.
// Arguments:
//   v1 = First vector or point.
//   v2 = Second vector or point.
//   v3 = Third point in three point mode.
// Example:
//   ang1 = vector_angle(UP,LEFT);     // Returns: 90
//   ang2 = vector_angle(RIGHT,LEFT);  // Returns: 180
//   ang3 = vector_angle(UP+RIGHT,RIGHT);  // Returns: 45
//   ang4 = vector_angle([10,10], [0,0], [10,-10]);  // Returns: 90
//   ang5 = vector_angle([10,0,10], [0,0,0], [-10,10,0]);  // Returns: 120
//   ang6 = vector_angle([[10,0,10], [0,0,0], [-10,10,0]]);  // Returns: 120
function vector_angle(v1,v2,v3) =
    assert( ( is_undef(v3) && ( is_undef(v2) || same_shape(v1,v2) ) )
            || is_consistent([v1,v2,v3]) ,
            "\nBad arguments.")
    assert( is_vector(v1) || is_consistent(v1), "\nBad arguments.") 
    let( vecs = ! is_undef(v3) ? [v1-v2,v3-v2] :
                ! is_undef(v2) ? [v1,v2] :
                len(v1) == 3   ? [v1[0]-v1[1], v1[2]-v1[1]] 
                               : v1
    )
    assert(is_vector(vecs[0],2) || is_vector(vecs[0],3), "\nBad arguments.")
    let(
        norm0 = norm(vecs[0]),
        norm1 = norm(vecs[1])
    )
    assert(norm0>0 && norm1>0, "\nZero length vector.")
    // NOTE: constrain() corrects crazy FP rounding errors that exceed acos()'s domain.
    acos(constrain((vecs[0]*vecs[1])/(norm0*norm1), -1, 1));

// Function: vector_axis()
// Synopsis: Returns the perpendicular axis between two vectors.
// Topics: Vectors, Math
// See Also: unit(), v_theta(), vector_angle()
// Usage:
//   axis = vector_axis(v1,v2);
//   axis = vector_axis([v1,v2]);
//   axis = vector_axis(PT1,PT2,PT3);
//   axis = vector_axis([PT1,PT2,PT3]);
// Description:
//   If given a single list of two vectors, like `vector_axis([V1,V2])`, returns the vector perpendicular the two vectors V1 and V2.
//   If given a single list of three points, like `vector_axis([A,B,C])`, returns the vector perpendicular to the plane through a, B and C.
//   If given two vectors, like `vector_axis(V1,V2)`, returns the vector perpendicular to the two vectors V1 and V2.
//   If given three points, like `vector_axis(A,B,C)`, returns the vector perpendicular to the plane through a, B and C.
// Arguments:
//   v1 = First vector or point.
//   v2 = Second vector or point.
//   v3 = Third point in three point mode.
// Example:
//   axis1 = vector_axis(UP,LEFT);     // Returns: [0,-1,0] (FWD)
//   axis2 = vector_axis(RIGHT,LEFT);  // Returns: [0,-1,0] (FWD)
//   axis3 = vector_axis(UP+RIGHT,RIGHT);  // Returns: [0,1,0] (BACK)
//   axis4 = vector_axis([10,10], [0,0], [10,-10]);  // Returns: [0,0,-1] (DOWN)
//   axis5 = vector_axis([10,0,10], [0,0,0], [-10,10,0]);  // Returns: [-0.57735, -0.57735, 0.57735]
//   axis6 = vector_axis([[10,0,10], [0,0,0], [-10,10,0]]);  // Returns: [-0.57735, -0.57735, 0.57735]
function vector_axis(v1,v2=undef,v3=undef) =
    is_vector(v3)
    ?   assert(is_consistent([v3,v2,v1]), "\nBad arguments.")
        vector_axis(v1-v2, v3-v2)
    :   assert( is_undef(v3), "\nBad arguments.")
        is_undef(v2)
        ?   assert( is_list(v1), "\nBad arguments.")
            len(v1) == 2 
            ?   vector_axis(v1[0],v1[1]) 
            :   vector_axis(v1[0],v1[1],v1[2])
        :   assert( is_vector(v1,zero=false) && is_vector(v2,zero=false) && is_consistent([v1,v2])
                    , "\nBad arguments.")  
            let(
              eps = 1e-6,
              w1 = point3d(v1/norm(v1)),
              w2 = point3d(v2/norm(v2)),
              w3 = (norm(w1-w2) > eps && norm(w1+w2) > eps) ? w2 
                   : (norm(v_abs(w2)-UP) > eps)? UP 
                   : RIGHT
            ) unit(cross(w1,w3));

// Function: vector_bisect()
// Synopsis: Returns the vector that bisects two vectors.
// Topics: Vectors, Math
// See Also: unit(), v_theta(), vector_angle(), vector_axis()
// Usage:
//   newv = vector_bisect(v1,v2);
// Description:
//   Returns a unit vector that exactly bisects the minor angle between two given vectors.
//   If the normalized vectors are approximately opposed, returns `undef`. Both inputs must be nonzero vectors of the same length.
function vector_bisect(v1,v2) =
    assert(is_vector(v1))
    assert(is_vector(v2))
    assert(!approx(norm(v1),0), "\nZero length vector.")
    assert(!approx(norm(v2),0), "\nZero length vector.")
    assert(len(v1)==len(v2), "\nVectors are of different sizes.")
    let( v1 = unit(v1), v2 = unit(v2) )
    approx(v1,-v2)? undef : unit(v1+v2);

// Function: furthest_point()
// Synopsis: Finds the furthest point in a list of points.
// Topics: Geometry, Points, Distance
// See Also: pointlist_bounds(), closest_point()
// Usage:
//   index = furthest_point(pt, points);
// Description:
//   Given a nonempty list, `points`, finds the index of the furthest member from `pt`.
//   All points must have the same dimension as `pt`.
// Arguments:
//   pt = The point to find the farthest point from.
//   points = The list of points to search.
function furthest_point(pt, points) =
    assert( is_vector(pt), "\nInvalid point." )
    assert(is_matrix(points,undef,len(pt)), "\nInvalid pointlist or incompatible dimensions." )
    max_index([for (p=points) norm(p-pt)]);

// Function: vector_search()
// Synopsis: Finds points in a list that are close to a given point.
// Topics: Search, Points, Closest
// See Also: vector_search_tree(), vector_nearest()
// Usage:
//   indices = vector_search(query, r, target);
// Description:
//   Given a list of query points `query` and a `target` to search, 
//   finds the points in `target` that match each query point. A match holds when the 
//   distance between a point in `target` and a query point is less than or equal to `r`. 
//   The returned list contains a list for each query point containing, in arbitrary 
//   order, the indices of all points that match that query point.
//   You can also give a single query point; in that case the result is a list of matching indices.
//   The `target` may be a simple list of points or a search tree.
//   When `target` is a raw list of more than 400 points, a search tree is constructed for this call.
//   Shorter raw lists are searched directly. Search cost depends on the data distribution and number of matches.
//   Alternatively, `target` may be a prepared search structure built with {{vector_search_tree()}},
//   which is faster for repeated searches since the structure is not rebuilt.  
// Arguments:
//   query = A query point, or a list of query points to find matches for.
//   r = the search radius.
//   target = list of the points to search for matches or a search tree.
// Example(2D,Med): A set of four queries to find points within 1 unit of the query.  The circles show the search region and all have radius 1.  
//   $fn=32;
//   k = 2000;
//   points = list_to_matrix(rands(0,10,k*2,seed=13333),2);
//   queries = [for(i=[3,7],j=[3,7]) [i,j]];
//   search_ind = vector_search(queries, 1, points);
//   move_copies(points) circle(r=.08);
//   for(i=idx(queries)){
//       color("blue")stroke(move(queries[i],circle(r=1)), closed=true, width=.08);
//       color("red") move_copies(select(points, search_ind[i])) circle(r=.08);
//   }
// Example(2D,Med): when a series of searches with different radius are needed, its is faster to pre-compute the tree
//   $fn=32;
//   k = 2000;
//   points = list_to_matrix(rands(0,10,k*2,seed=13333),2);
//   queries1 = [for(i=[3,7]) [i,i]];
//   queries2 = [for(i=[3,7]) [10-i,i]];
//   r1 = 1;
//   r2 = .7;
//   search_tree = vector_search_tree(points);
//   search_1 = vector_search(queries1, r1, search_tree);
//   search_2 = vector_search(queries2, r2, search_tree);
//   move_copies(points) circle(r=.08);
//   for(i=idx(queries1)){
//       color("blue")stroke(move(queries1[i],circle(r=r1)), closed=true, width=.08);
//       color("red") move_copies(select(points, search_1[i])) circle(r=.08);
//   }
//   for(i=idx(queries2)){
//       color("green")stroke(move(queries2[i],circle(r=r2)), closed=true, width=.08);
//       color("red") move_copies(select(points, search_2[i])) circle(r=.08);
//   }
function vector_search(query, r, target) =
    query==[] ? [] :
    is_list(query) && target==[] ? is_vector(query) ? [] : [for(q=query) [] ] :
    assert( is_finite(r) && r>=0, 
            "\nThe query radius should be a positive number." )
    let(
        tgpts  = is_matrix(target),   // target is a point list
        tgtree = is_list(target)      // target is a tree
                 && (len(target)==2)
                 && is_matrix(target[0])
                 && is_list(target[1])
                 && (len(target[1])==4 || (len(target[1])==1 && is_list(target[1][0])) )
    )
    assert( tgpts || tgtree, 
            "\nThe target should be a list of points or a search tree compatible with the query." )
    let( 
        dim    = tgpts ? len(target[0]) : len(target[0][0]),
        simple = is_vector(query, dim)
        )
    assert( simple || is_matrix(query,undef,dim), 
            "\nThe query points should be a list of points compatible with the target point list.")
    tgpts 
    ?   len(target)<=400
        ?   simple ? [for(i=idx(target)) if(norm(target[i]-query)<=r) i ] :
            [for(q=query) [for(i=idx(target)) if(norm(target[i]-q)<=r) i ] ]
        :   let( tree = _bt_tree(target, count(len(target)), leafsize=25) )
            simple ? _bt_search(query, r, target, tree) :
            [for(q=query) _bt_search(q, r, target, tree)]
    :   simple ?  _bt_search(query, r, target[0], target[1]) :
        [for(q=query) _bt_search(q, r, target[0], target[1])];

//Ball tree search
function _bt_search(query, r, points, tree) = 
    assert( is_list(tree) 
            && (   ( len(tree)==1 && is_list(tree[0]) )
                || ( len(tree)==4 && is_num(tree[0]) && is_num(tree[1]) ) ), 
            "\nThe tree is invalid.")
    len(tree)==1 
    ?   assert( tree[0]==[] || is_vector(tree[0]), "\nThe tree is invalid." )
        [for(i=tree[0]) if(norm(points[i]-query)<=r) i ]
    :   norm(query-points[tree[0]]) > r+tree[1] ? [] :
        concat( 
            [ if(norm(query-points[tree[0]])<=r) tree[0] ],
            _bt_search(query, r, points, tree[2]),
            _bt_search(query, r, points, tree[3]) ) ;

//Ball tree construction
function _bt_tree(points, ind, leafsize=25) =
    len(ind)<=leafsize ? [ind] :
    let(bounds = pointlist_bounds(select(points,ind)))
    bounds[0]==bounds[1] ? [ind] :
    let(
        coord  = max_index(bounds[1]-bounds[0]), 
        projc  = [for(i=ind) points[i][coord] ],
        meanpr = mean(projc), 
        pivot  = min_index([for(p=projc) abs(p-meanpr)]),
        radius = max([for(i=ind) norm(points[ind[pivot]]-points[i]) ]),
        Lind   = [for(i=idx(ind)) if(projc[i]<=meanpr && i!=pivot) ind[i] ],
        Rind   = [for(i=idx(ind)) if(projc[i] >meanpr && i!=pivot) ind[i] ]
      )
    [ ind[pivot], radius, _bt_tree(points, Lind, leafsize), _bt_tree(points, Rind, leafsize) ];

// Section: Bounds


// Function: pointlist_bounds()
// Synopsis: Returns the min and max bounding coordinates for the given list of points.
// Topics: Geometry, Bounding Boxes, Bounds, Scaling
// See Also: closest_point(), furthest_point(), vnf_bounds()
// Usage:
//   pt_pair = pointlist_bounds(pts);
// Description:
//   Finds the bounds containing all the points in `pts`, which can be a list of points in any dimension.
//   Returns a list of two items: a list of the minimums and a list of the maximums.  For example, with
//   3d points `[[MINX, MINY, MINZ], [MAXX, MAXY, MAXZ]]`
// Arguments:
//   pts = List of points.
function pointlist_bounds(pts) =
    assert(is_path(pts,dim=undef,fast=true) , "\nInvalid pointlist." )
    let(
        select = ident(len(pts[0])),
        spread = [
            for(i=[0:len(pts[0])-1])
            let( spreadi = pts*select[i] )
            [ min(spreadi), max(spreadi) ]
        ]
    ) transpose(spread);

// onescad: BOSL2/affine.scad
//////////////////////////////////////////////////////////////////////
// LibFile: affine.scad
//   Matrix math and affine transformation matrices.
// Includes:
//   include <BOSL2/std.scad>
//////////////////////////////////////////////////////////////////////

// Section: Affine3d 4x4 Transformation Matrices


// Function: affine3d_identity()
// Synopsis: Returns a 3D (4x4) identity transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms
// See Also: affine2d_identity(), ident(), IDENT
// Usage:
//   mat = affine3d_identity();
// Description:
//   Create a 4x4 affine3d identity matrix.
// Example:
//   mat = affine2d_identity();
//   // Returns:
//   //   [
//   //     [1, 0, 0, 0],
//   //     [0, 1, 0, 0],
//   //     [0, 0, 1, 0],
//   //     [0, 0, 0, 1]
//   //   ]
function affine3d_identity() = ident(4);

// Function: affine3d_translate()
// Synopsis: Returns a 3D (4x4) translation transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Translation
// See Also: move(), translate(), left(), right(), fwd(), back(), down(), up(), affine2d_translate()
// Usage:
//   mat = affine3d_translate(v);
// Description:
//   Returns the 4x4 affine3d matrix to perform a 3D translation.
// Arguments:
//   v = 3D offset to translate by.  [X,Y,Z]
// Example:
//   mat = affine2d_translate([30,40,50]);
//   // Returns:
//   //   [
//   //     [1, 0, 0, 30],
//   //     [0, 1, 0, 40],
//   //     [0, 0, 1, 50]
//   //     [0, 0, 0,  1]
//   //   ]
function affine3d_translate(v=[0,0,0]) =
    assert(is_list(v))
    let( v = [for (i=[0:2]) default(v[i],0)] )
    [
        [1, 0, 0, v.x],
        [0, 1, 0, v.y],
        [0, 0, 1, v.z],
        [0 ,0, 0,   1]
    ];

// Function: affine3d_scale()
// Synopsis: Returns a 3D (4x4) scaling transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Scaling
// See Also: scale(), affine2d_scale()
// Usage:
//   mat = affine3d_scale(v);
// Description:
//   Returns the 4x4 affine3d matrix to perform a 3D scaling transformation.
// Arguments:
//   v = 3D vector of scaling factors.  [X,Y,Z]
// Example:
//   mat = affine3d_scale([3,4,5]);
//   // Returns:
//   //   [
//   //     [3, 0, 0, 0],
//   //     [0, 4, 0, 0],
//   //     [0, 0, 5, 0],
//   //     [0, 0, 0, 1]
//   //   ]
function affine3d_scale(v=[1,1,1]) =
    assert(is_list(v))
    let( v = [for (i=[0:2]) default(v[i],1)] )
    [
        [v.x,   0,   0, 0],
        [  0, v.y,   0, 0],
        [  0,   0, v.z, 0],
        [  0,   0,   0, 1]
    ];

// Function: affine3d_xrot()
// Synopsis: Returns a 3D (4x4) X-axis rotation transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine2d_zrot()
// Usage:
//   mat = affine3d_xrot(ang);
// Description:
//   Returns the 4x4 affine3d matrix to perform a rotation of a 3D vector around the X axis.
// Arguments:
//   ang = number of degrees to rotate.
// Example:
//   mat = affine3d_xrot(90);
//   // Returns:
//   //   [
//   //     [1, 0, 0, 0],
//   //     [0, 0,-1, 0],
//   //     [0, 1, 0, 0],
//   //     [0, 0, 0, 1]
//   //   ]
function affine3d_xrot(ang=0) =
    assert(is_finite(ang))
    [
        [1,        0,         0,   0],
        [0, cos(ang), -sin(ang),   0],
        [0, sin(ang),  cos(ang),   0],
        [0,        0,         0,   1]
    ];

// Function: affine3d_yrot()
// Synopsis: Returns a 3D (4x4) Y-axis rotation transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine2d_zrot()
// Usage:
//   mat = affine3d_yrot(ang);
// Description:
//   Returns the 4x4 affine3d matrix to perform a rotation of a 3D vector around the Y axis.
// Arguments:
//   ang = Number of degrees to rotate.
// Example:
//   mat = affine3d_yrot(90);
//   // Returns:
//   //   [
//   //     [ 0, 0, 1, 0],
//   //     [ 0, 1, 0, 0],
//   //     [-1, 0, 0, 0],
//   //     [ 0, 0, 0, 1]
//   //   ]
function affine3d_yrot(ang=0) =
    assert(is_finite(ang))
    [
        [ cos(ang), 0, sin(ang),   0],
        [        0, 1,        0,   0],
        [-sin(ang), 0, cos(ang),   0],
        [        0, 0,        0,   1]
    ];

// Function: affine3d_zrot()
// Synopsis: Returns a 3D (4x4) Z-axis rotation transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine2d_zrot()
// Usage:
//   mat = affine3d_zrot(ang);
// Description:
//   Returns the 4x4 affine3d matrix to perform a rotation of a 3D vector around the Z axis.
// Arguments:
//   ang = number of degrees to rotate.
// Example:
//   mat = affine3d_zrot(90);
//   // Returns:
//   //   [
//   //     [ 0,-1, 0, 0],
//   //     [ 1, 0, 0, 0],
//   //     [ 0, 0, 1, 0],
//   //     [ 0, 0, 0, 1]
//   //   ]
function affine3d_zrot(ang=0) =
    assert(is_finite(ang))
    [
        [cos(ang), -sin(ang), 0, 0],
        [sin(ang),  cos(ang), 0, 0],
        [       0,         0, 1, 0],
        [       0,         0, 0, 1]
    ];

// Function: affine3d_rot_by_axis()
// Synopsis: Returns a 3D (4x4) arbitrary-axis rotation transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine2d_zrot()
// Usage:
//   mat = affine3d_rot_by_axis(u, ang);
// Description:
//   Returns the 4x4 affine3d matrix to perform a rotation of a 3D vector around an axis.
// Arguments:
//   u = 3D axis vector to rotate around.
//   ang = number of degrees to rotate.
// Example:
//   mat = affine3d_rot_by_axis([1,1,1], 120);
//   // Returns approx:
//   //   [
//   //     [ 0, 0, 1, 0],
//   //     [ 1, 0, 0, 0],
//   //     [ 0, 1, 0, 0],
//   //     [ 0, 0, 0, 1]
//   //   ]
function affine3d_rot_by_axis(u=UP, ang=0) =
    assert(is_finite(ang))
    assert(is_vector(u,3))
    approx(ang,0)? affine3d_identity() :
    let(
        u = unit(u),
        c = cos(ang),
        c2 = 1-c,
        s = sin(ang)
    ) [
        [u.x*u.x*c2+c    , u.x*u.y*c2-u.z*s, u.x*u.z*c2+u.y*s, 0],
        [u.y*u.x*c2+u.z*s, u.y*u.y*c2+c    , u.y*u.z*c2-u.x*s, 0],
        [u.z*u.x*c2-u.y*s, u.z*u.y*c2+u.x*s, u.z*u.z*c2+c    , 0],
        [               0,                0,                0, 1]
    ];

// Function: affine3d_rot_from_to()
// Synopsis: Returns a 3D (4x4) tilt rotation transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Rotation
// See Also: rot(), xrot(), yrot(), zrot(), affine2d_zrot()
// Usage:
//   mat = affine3d_rot_from_to(from, to);
// Description:
//   Returns the 4x4 affine3d matrix to perform a rotation of a 3D vector from one vector direction to another.
// Arguments:
//   from = 3D axis vector to rotate from.
//   to = 3D axis vector to rotate to.
// Example:
//   mat = affine3d_rot_from_to(UP, RIGHT);
//   // Returns:
//   //   [
//   //     [ 0, 0, 1, 0],
//   //     [ 0, 1, 0, 0],
//   //     [-1, 0, 0, 0],
//   //     [ 0, 0, 0, 1]
//   //   ]
function affine3d_rot_from_to(from, to) =
    assert(is_vector(from))
    assert(is_vector(to))
    assert(len(from)==len(to))
    let(
        from = unit(point3d(from)),
        to = unit(point3d(to))
    ) approx(from,to)? affine3d_identity() :
    from.z==0 && to.z==0 ?  affine3d_zrot(v_theta(point2d(to)) - v_theta(point2d(from)))
    :
    let(
        u = vector_axis(from,to),
        ang = vector_angle(from,to),
        c = cos(ang),
        c2 = 1-c,
        s = sin(ang)
    ) [
        [u.x*u.x*c2+c    , u.x*u.y*c2-u.z*s, u.x*u.z*c2+u.y*s, 0],
        [u.y*u.x*c2+u.z*s, u.y*u.y*c2+c    , u.y*u.z*c2-u.x*s, 0],
        [u.z*u.x*c2-u.y*s, u.z*u.y*c2+u.x*s, u.z*u.z*c2+c    , 0],
        [               0,                0,                0, 1]
    ];

// Function: affine3d_mirror()
// Synopsis: Returns a 3D (4x4) reflection transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Reflection, Mirroring
// See Also: mirror(), xflip(), yflip(), zflip(), affine2d_mirror()
// Usage:
//   mat = affine3d_mirror(v);
// Description:
//   Returns the 4x4 affine3d matrix to perform a reflection of a 3D vector across the plane given by its normal vector.
// Arguments:
//   v = The normal vector of the plane to reflect across.
// Example:
//   mat = affine3d_mirror([1,0,0]);
//   // Returns:
//   //   [
//   //     [-1, 0, 0, 0],
//   //     [ 0, 1, 0, 0],
//   //     [ 0, 0, 1, 0],
//   //     [ 0, 0, 0, 1]
//   //   ]
// Example:
//   mat = affine3d_mirror([0,1,0]);
//   // Returns:
//   //   [
//   //     [ 1, 0, 0, 0],
//   //     [ 0,-1, 0, 0],
//   //     [ 0, 0, 1, 0],
//   //     [ 0, 0, 0, 1]
//   //   ]
function affine3d_mirror(v) =
    assert(is_vector(v))
    let(
        v=unit(point3d(v)),
        a=v.x, b=v.y, c=v.z
    ) [
        [1-2*a*a,  -2*a*b,  -2*a*c, 0],
        [ -2*b*a, 1-2*b*b,  -2*b*c, 0],
        [ -2*c*a,  -2*c*b, 1-2*c*c, 0],
        [      0,       0,       0, 1]
    ];

// Function: affine3d_skew()
// Synopsis: Returns a 3D (4x4) skewing transformation matrix.
// SynTags: Mat
// Topics: Affine, Matrices, Transforms, Skewing
// See Also: skew(), affine3d_skew_xy(), affine3d_skew_xz(), affine3d_skew_yz(), affine2d_skew()
// Usage:
//   mat = affine3d_skew([sxy=], [sxz=], [syx=], [syz=], [szx=], [szy=]);
// Description:
//   Returns the 4x4 affine3d matrix to perform a skew transformation.
// Arguments:
//   sxy = Skew factor multiplier for skewing along the X axis as you get farther from the Y axis.  Default: 0
//   sxz = Skew factor multiplier for skewing along the X axis as you get farther from the Z axis.  Default: 0
//   syx = Skew factor multiplier for skewing along the Y axis as you get farther from the X axis.  Default: 0
//   syz = Skew factor multiplier for skewing along the Y axis as you get farther from the Z axis.  Default: 0
//   szx = Skew factor multiplier for skewing along the Z axis as you get farther from the X axis.  Default: 0
//   szy = Skew factor multiplier for skewing along the Z axis as you get farther from the Y axis.  Default: 0
// Example:
//   mat = affine3d_skew(sxy=2,szx=3);
//   // Returns:
//   //   [
//   //     [ 1, 2, 0, 0],
//   //     [ 0, 1, 0, 0],
//   //     [ 0, 0, 1, 0],
//   //     [ 3, 0, 0, 1]
//   //   ]
function affine3d_skew(sxy=0, sxz=0, syx=0, syz=0, szx=0, szy=0) = [
    [  1, sxy, sxz, 0],
    [syx,   1, syz, 0],
    [szx, szy,   1, 0],
    [  0,   0,   0, 1]
];

// onescad: BOSL2/coords.scad
//////////////////////////////////////////////////////////////////////
// LibFile: coords.scad
//   Coordinate transformations and coordinate system conversions.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Math
// FileSummary: Conversions between coordinate systems.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Coordinate Manipulation

// Function: point2d()
// Synopsis: Convert a vector to 2D. 
// Topics: Coordinates, Points
// See Also: path2d(), point3d(), path3d()
// Usage:
//   pt = point2d(p, [fill]);
// Description:
//   Returns a 2D vector/point from a 2D or 3D vector.  If given a 3D point, removes the Z coordinate.
// Arguments:
//   p = The coordinates to force into a 2D vector/point.
//   fill = Value to fill missing values in vector with.  Default: 0
function point2d(p, fill=0) = assert(is_list(p)) [for (i=[0:1]) (p[i]==undef)? fill : p[i]];

// Function: path2d()
// Synopsis: Convert a path to 2D. 
// SynTags: Path
// Topics: Coordinates, Points, Paths
// See Also: point2d(), point3d(), path3d(), point4d(), path4d(), hstack()
// Usage:
//   pts = path2d(points);
// Description:
//   Returns a list of 2D vectors/points from a list of 2D, 3D or higher dimensional vectors/points.
//   Removes the extra coordinates from higher dimensional points.  The input must be a path, where
//   every vector has the same length.
// Arguments:
//   points = A list of 2D or 3D points/vectors.
function path2d(points) =
    assert(is_path(points,dim=undef,fast=true),"\nInput to path2d is not a path.")
    let (result = points * concat(ident(2), repeat([0,0], len(points[0])-2)))
    assert(is_def(result), "\nInvalid input to path2d.")
    result;

// Function: point3d()
// Synopsis: Convert a vector to 3D. 
// Topics: Coordinates, Points
// See Also: path2d(), point2d(), path3d()
// Usage:
//   pt = point3d(p, [fill]);
// Description:
//   Returns a 3D vector/point from a 2D or 3D vector.
// Arguments:
//   p = The coordinates to force into a 3D vector/point.
//   fill = Value to fill missing values in vector with.  Default: 0
function point3d(p, fill=0) =
    assert(is_list(p)) 
    [for (i=[0:2]) (p[i]==undef)? fill : p[i]];

// Function: path3d()
// Synopsis: Convert a path to 3D. 
// SynTags: Path
// Topics: Coordinates, Points, Paths
// See Also: point2d(), path2d(), point3d(), point4d(), path4d(), hstack()
// Usage:
//   pts = path3d(points, [fill]);
// Description:
//   Returns a list of 3D vectors/points from a list of 2D or higher dimensional vectors/points
//   by removing extra coordinates or adding the z coordinate.  
// Arguments:
//   points = A list of 2D, 3D or higher dimensional points/vectors.
//   fill = Scalar value to fill missing values in vectors with (in the 2D case).  Default: 0
function path3d(points, fill=0) =
    assert(is_num(fill))
    assert(is_path(points, dim=undef, fast=true), "\nInput to path3d is not a path.")
    let (
        change = len(points[0])-3,
        M = change < 0? [[1,0,0],[0,1,0]] : 
            concat(ident(3), repeat([0,0,0],change)),
        result = points*M
    )
    assert(is_def(result), "\nInput to path3d is invalid.")
    fill == 0 || change>=0 ? result : result + repeat([0,0,fill], len(result));

// Function: point4d()
// Synopsis: Convert a vector to 4d. 
// Topics: Coordinates, Points
// See Also: point2d(), path2d(), point3d(), path3d(), path4d()
// Usage:
//   pt = point4d(p, [fill]);
// Description:
//   Returns a 4D vector/point from a 2D or 3D vector.
// Arguments:
//   p = The coordinates to force into a 4D vector/point.
//   fill = Scalar value to fill missing values in vector with.  Default: 0
function point4d(p, fill=0) = assert(is_list(p))
                              [for (i=[0:3]) (p[i]==undef)? fill : p[i]];

// Section: Coordinate Systems

// Function: polar_to_xy()
// Synopsis: Convert 2D polar coordinates to cartesian coordinates. 
// SynTags: Path
// Topics: Coordinates, Points, Paths
// See Also: xy_to_polar(), xyz_to_cylindrical(), cylindrical_to_xyz(), xyz_to_spherical(), spherical_to_xyz()
// Usage:
//   pt = polar_to_xy(r, theta);
//   pt = polar_to_xy([R, THETA]);
//   pts = polar_to_xy([[R,THETA], [R,THETA], ...]);
// Description:
//   Called with two arguments, converts the `r` and `theta` 2D polar coordinate into an `[X,Y]` cartesian coordinate.
//   Called with one `[R,THETA]` vector argument, converts the 2D polar coordinate into an `[X,Y]` cartesian coordinate.
//   Called with a list of `[R,THETA]` vector arguments, converts each 2D polar coordinate into `[X,Y]` cartesian coordinates.
//   Theta is the angle counter-clockwise of X+ on the XY plane.
// Arguments:
//   r = distance from the origin.
//   theta = angle in degrees, counter-clockwise of X+.
// Example:
//   xy = polar_to_xy(20,45);    // Returns: ~[14.1421365, 14.1421365]
//   xy = polar_to_xy(40,30);    // Returns: ~[34.6410162, 20]
//   xy = polar_to_xy([40,30]);  // Returns: ~[34.6410162, 20]
//   xy = polar_to_xy([[40,30],[20,120]]);  // Returns: ~[[34.6410162, 20], [-10, 17.3205]]
// Example(2D):
//   r=40; ang=30; $fn=36;
//   pt = polar_to_xy(r,ang);
//   stroke(circle(r=r), closed=true, width=0.5);
//   color("black") stroke([[r,0], [0,0], pt], width=0.5);
//   color("black") stroke(arc(r=15, angle=ang), width=0.5);
//   color("red") move(pt) circle(d=3);
function polar_to_xy(r,theta) =
    theta != undef
      ? assert(is_num(r) && is_num(theta), "\nBad arguments.")
        [r*cos(theta), r*sin(theta)]
      : assert(is_list(r), "\nBad arguments.")
        is_num(r.x)
          ? polar_to_xy(r.x, r.y)
          : [for(p = r) polar_to_xy(p.x, p.y)];

// Function: project_plane()
// Synopsis: Project a set of points onto a specified plane, returning 2D points.  
// SynTags: Path
// Topics: Coordinates, Points, Paths
// See Also: lift_plane()
// Usage: 
//   xy = project_plane(plane, p);
// Usage: To get a transform matrix
//   M = project_plane(plane)
// Description:
//   Maps the provided 3D point(s) from 3D coordinates to a 2D coordinate system defined by `plane`.  Points that are not
//   on the specified plane are projected orthogonally onto the plane.  This coordinate system is useful if you need
//   to perform 2D operations on a coplanar set of data.  After those operations are done you can return the data
//   to 3D with `lift_plane()`.  You could also use this to force approximately coplanar data to be exactly coplanar.
//   The parameter p can be a point, path, region, bezier patch or VNF.
//   A VNF is returned as a VNF-like structure with 2D vertices.  This projected
//   representation can be passed to {{lift_plane()}}, but is not a standard 3D VNF. An empty VNF is returned unchanged.
//   Projection discards distance from the plane; lifting the result restores points on the plane, not their original depth.
//   The plane can be specified as
//   - A list of three points.  The planar coordinate system should have [0,0] at plane[0], with plane[1] lying on the Y+ axis.
//   - A list of non-collinear, coplanar points that define a plane.
//   - A plane definition `[A,B,C,D]` where `Ax+By+CZ=D`.  The closest point on that plane to the origin maps to the origin in the new coordinate system.
//   .
//   If you omit the point specification then `project_plane()` returns a transformation matrix that maps the specified plane to the XY plane.
//   Note that if you apply this transformation to data lying on the plane, it produces 3D points with the Z coordinate of zero.
// Arguments:
//   plane = plane specification or point list defining the plane
//   p = 3D point, path, region, VNF or bezier patch to project
// Example:
//   pt = [5,-5,5];
//   a=[0,0,0];  b=[10,-10,0];  c=[10,0,10];
//   xy = project_plane([a,b,c],pt);
// Example(3D): The yellow points in 3D project onto the red points in 2D
//   M = [[-1, 2, -1, -2], [-1, -3, 2, -1], [2, 3, 4, 53], [0, 0, 0, 1]];
//   data = apply(M,path3d(circle(r=10, $fn=20)));
//   move_copies(data) sphere(r=1);
//   color("red") move_copies(project_plane(data, data)) sphere(r=1);
// Example(3D,VPR=[70.40,0.00,18.70],VPD=292.71,VPT=[-3.65,16.28,13.46]): The arrows show the projection from the red circle to its projection in yellow.  Since we didn't use {{path2d()}} the projected curve is still a 3D curve with zero $z$ component.  
//   xyzpath = move([10,20,30], p=yrot(25, p=path3d(circle(d=100))));
//   mat = project_plane(xyzpath);
//   xypath = apply(mat, xyzpath);
//   %show_plane([0,0,1,0],[140,180]);
//   stroke(xyzpath,closed=true,color="red");
//   stroke(xypath,closed=true);
//   color("lightblue")
//     for(i=idx(xyzpath))
//       stroke([xyzpath[i], point3d(xypath[i])], endcap2="arrow2");
function project_plane(plane,p) =
      is_matrix(plane,3,3) && is_undef(p) ? // no data, 3 points given
          assert(!is_collinear(plane),"\nPoints defining the plane must not be collinear.")
          let(
              v = plane[2]-plane[0],
              y = unit(plane[1]-plane[0]),        // y axis goes to point b
              x = unit(v-(v*y)*y)   // x axis 
          )            
          frame_map(x,y,reverse=true) * move(-plane[0])
    : is_vector(plane,4) && is_undef(p) ?            // no data, plane given in "plane"
          assert(_valid_plane(plane), "\nPlane is not valid.")
          let(
               n = point3d(plane),
               cp = n * plane[3] / (n*n)
          )
          rot(from=n, to=UP) * move(-cp)
    : is_path(plane,3) && is_undef(p) ?               // no data, generic point list plane
          assert(len(plane)>=3, "\nNeed three points to define a plane.")
          let(plane = plane_from_points(plane, check_coplanar=true))
          assert(is_def(plane), "\nPoint list is not coplanar.")
          project_plane(plane)
    : assert(is_def(p), str("Invalid plane specification: ",plane))
      is_vnf(p) ? (p[0]==[] ? p : [project_plane(plane,p[0]), p[1]])
    : is_list(p) && is_list(p[0]) && is_vector(p[0][0],3) ?  // bezier patch or region
           [for(plist=p) project_plane(plane,plist)]
    : assert(is_vector(p,3) || is_path(p,3), str("\nData must be a 3D point, path, region, vnf, or bezier patch."))
      is_matrix(plane,3,3) ?
          assert(!is_collinear(plane),"\nPoints defining the plane must not be collinear.")
          let(
              v = plane[2]-plane[0],
              y = unit(plane[1]-plane[0]),        // y axis goes to point b
              x = unit(v-(v*y)*y)  // x axis 
          ) move(-plane[0],p) * transpose([x,y])
    : is_vector(p) ? point2d(apply(project_plane(plane),p))
    : path2d(apply(project_plane(plane),p));

// Function: lift_plane()
// Synopsis: Map a list of 2D points onto a plane in 3D. 
// SynTags: Path
// Topics: Coordinates, Points, Paths
// See Also: project_plane()
// Usage: 
//   xyz = lift_plane(plane, p);
// Usage: to get transform matrix
//   M =  lift_plane(plane);
// Description:
//   Converts the given 2D point on the plane to 3D coordinates of the specified plane.
//   The parameter `p` can be a 2D point, path, region, bezier patch, or a projected VNF (a VNF with 2d vertices)
//   returned by {{project_plane()}}. 
//   Lifting a projection does not recover any distance from the plane that was discarded during projection.
//   The plane can be specified as
//   - A list of three points.  The planar coordinate system will have [0,0] at plane[0], with plane[1] lying on the Y+ axis.
//   - A list of non-collinear, coplanar points that define a plane.
//   - A plane definition `[A,B,C,D]` where `Ax+By+CZ=D`.  The closest point on that plane to the origin maps to the origin in the new coordinate system.
//   .
//   If you do not supply `p` then you get a transformation matrix that operates in 3D, assuming that the Z coordinate of the points is zero.
//   This rotation matrix is the inverse of the one produced by {{project_plane()}}.
// Arguments:
//   plane = Plane specification or list of points to define a plane
//   p = 2D point, path, region, projected VNF, or bezier patch to transform.
function lift_plane(plane, p) =
      is_matrix(plane,3,3) && is_undef(p) ? // no data, 3 p given
          let(
              v = plane[2]-plane[0],
              y = unit(plane[1]-plane[0]),        // y axis goes to point b
              x = unit(v-(v*y)*y)   // x axis 
          )            
          move(plane[0]) * frame_map(x,y)
    : is_vector(plane,4) && is_undef(p) ?            // no data, plane given in "plane"
          assert(_valid_plane(plane), "\nPlane is not valid.")
          let(
               n = point3d(plane),
               cp = n * plane[3] / (n*n)
          )
          move(cp) * rot(from=UP, to=n)
    : is_path(plane,3) && is_undef(p) ?               // no data, generic point list plane
          assert(len(plane)>=3, "\nNeed three points to define a plane.")
          let(plane = plane_from_points(plane, check_coplanar=true))
          assert(is_def(plane), "Point list is not coplanar")
          lift_plane(plane)
    : _is_projected_vnf(p) ? (p[0]==[] ? p : [apply(lift_plane(plane),path3d(p[0])), p[1]])
    : is_list(p) && is_list(p[0]) && is_vector(p[0][0],2) ?  // bezier patch or region
           [for(plist=p) lift_plane(plane,plist)]
    : assert(is_vector(p,2) || is_path(p,2),"\nData must be a 2D point, path, region, projected VNF, or bezier patch.")
      is_matrix(plane,3,3) ?
          let(
              v = plane[2]-plane[0],
              y = unit(plane[1]-plane[0]),        // y axis goes to point b
              x = unit(v-(v*y)*y)  // x axis 
          ) move(plane[0],p * [x,y])
    : apply(lift_plane(plane),is_vector(p) ? point3d(p) : path3d(p));

/// Recognize the 2D vertex/face representation without broadening is_vnf().
/// Polygon faces have at least three indices, unlike the coordinate pairs in a 2D region or patch.
function _is_projected_vnf(x) =
    is_list(x) && len(x)==2 && is_list(x[0]) && is_list(x[1])
    && (x[0]==[] ? x[1]==[] : is_matrix(x[0],undef,2))
    && (x[1]==[] || (is_vector(x[1][0]) && len(x[1][0])>=3));

// Function: cylindrical_to_xyz()
// Synopsis: Convert cylindrical coordinates to cartesian coordinates. 
// SynTags: Path
// Topics: Coordinates, Points, Paths
// See Also: xyz_to_cylindrical(), xy_to_polar(), polar_to_xy(), xyz_to_spherical(), spherical_to_xyz()
// Usage:
//   pt = cylindrical_to_xyz(r, theta, z);
//   pt = cylindrical_to_xyz([RADIUS,THETA,Z]);
//   pts = cylindrical_to_xyz([[RADIUS,THETA,Z], [RADIUS,THETA,Z], ...]);
// Description:
//   Called with three arguments, converts the `r`, `theta`, and 'z' 3D cylindrical coordinate into an `[X,Y,Z]` cartesian coordinate.
//   Called with one `[RADIUS,THETA,Z]` vector argument, converts the 3D cylindrical coordinate into an `[X,Y,Z]` cartesian coordinate.
//   Called with a list of `[RADIUS,THETA,Z]` vector arguments, converts each 3D cylindrical coordinate into `[X,Y,Z]` cartesian coordinates.
//   Theta is the angle counter-clockwise of X+ on the XY plane.  Z is height above the XY plane.
// Arguments:
//   r = distance from the Z axis.
//   theta = angle in degrees, counter-clockwise of X+ on the XY plane.
//   z = Height above XY plane.
// Example:
//   xyz = cylindrical_to_xyz(20,30,40);
//   xyz = cylindrical_to_xyz([40,60,50]);
function cylindrical_to_xyz(r,theta,z) =
    theta != undef
      ? assert(is_num(r) && is_num(theta) && is_num(z), "\nBad arguments.")
        [r*cos(theta), r*sin(theta), z]
      : assert(is_list(r), "\nBad arguments.")
        is_num(r.x)
          ? cylindrical_to_xyz(r.x, r.y, r.z)
          : [for(p = r) cylindrical_to_xyz(p.x, p.y, p.z)];

// Function: spherical_to_xyz()
// Synopsis: Convert spherical coordinates to 3D cartesian coordinates. 
// SynTags: Path
// Topics: Coordinates, Points, Paths
// See Also: cylindrical_to_xyz(), xyz_to_spherical(), xyz_to_cylindrical(), altaz_to_xyz(), xyz_to_altaz()
// Usage:
//   pt = spherical_to_xyz(r, theta, phi);
//   pt = spherical_to_xyz([RADIUS,THETA,PHI]);
//   pts = spherical_to_xyz([[RADIUS,THETA,PHI], [RADIUS,THETA,PHI], ...]);
// Description:
//   Called with three arguments, converts the `r`, `theta`, and 'phi' 3D spherical coordinate into an `[X,Y,Z]` cartesian coordinate.
//   Called with one `[RADIUS,THETA,PHI]` vector argument, converts the 3D spherical coordinate into an `[X,Y,Z]` cartesian coordinate.
//   Called with a list of `[RADIUS,THETA,PHI]` vector arguments, converts each 3D spherical coordinate into `[X,Y,Z]` cartesian coordinates.
//   Theta is the angle counter-clockwise of X+ on the XY plane.  Phi is the angle down from the Z+ pole.
// Arguments:
//   r = distance from origin.
//   theta = angle in degrees, counter-clockwise of X+ on the XY plane.
//   phi = angle in degrees from the vertical Z+ axis.
// Example:
//   xyz = spherical_to_xyz(20,30,40);
//   xyz = spherical_to_xyz([40,60,50]);
//   xyzs = spherical_to_xyz([[40,60,50], [50,120,100]]);
function spherical_to_xyz(r,theta,phi) =
    theta != undef
      ? assert(is_num(r) && is_num(theta) && is_num(phi), "\nBad arguments.")
        r*[cos(theta)*sin(phi), sin(theta)*sin(phi), cos(phi)]
      : assert(is_list(r), "\nBad arguments.")
        is_num(r.x)
          ? spherical_to_xyz(r.x, r.y, r.z)
          : [for(p = r) spherical_to_xyz(p.x, p.y, p.z)];

// onescad: BOSL2/geometry.scad
//////////////////////////////////////////////////////////////////////
// LibFile: geometry.scad
//   Perform calculations on lines, polygons, planes and circles, including
//   normals, intersections of objects, distance between objects, and tangent lines.
//   Throughout this library, lines can be treated as either unbounded lines, as rays with
//   a single endpoint or as segments, bounded by endpoints at both ends.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Math
// FileSummary: Geometrical calculations including intersections of lines, circles and planes, circle from 3 points
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

function _is_point_on_line(point, line, bounded=false, eps=_EPSILON) =
    let( 
        v1 = (line[1]-line[0]),
        v0 = (point-line[0]),
        t  = v0*v1/(v1*v1),
        bounded = force_list(bounded,2),
        norm_crossprod = len(v1)==2 ? abs(cross(v0,v1)) : norm(cross(v0,v1))
    ) 
    norm_crossprod <= eps*norm(v1) 
    && (!bounded[0] || t>=-eps) 
    && (!bounded[1] || t<1+eps) ;

///Internal - distance from point `d` to the line passing through the origin with unit direction n
///_dist2line works for any dimension
function _dist2line(d,n) = norm(d-(d * n) * n);

///Internal
function _valid_line(line,dim,eps=_EPSILON) =
    is_matrix(line,2,dim)
    && norm(line[1]-line[0])>eps*max(norm(line[1]),norm(line[0]));

//Internal
function _valid_plane(p, eps=_EPSILON) = is_vector(p,4) && ! approx(norm(p),0,eps);

/// Internal Function: _is_at_left()
/// Usage:
///   pt = point_left_of_line2d(point, line);
/// Topics: Geometry, Points, Lines
/// Description:
///   Return true iff a 2d point is on or at left of the line defined by `line`.
/// Arguments:
///   pt = The 2d point to check position of.
///   line  = Array of two 2d points forming the line segment to test against.
///   eps = Tolerance in the geometrical tests.
function _is_at_left(pt,line,eps=_EPSILON) = _tri_class([pt,line[0],line[1]],eps) <= 0;

/// Internal Function: _degenerate_tri()
/// Usage:
///   degen = _degenerate_tri(triangle);
/// Topics: Geometry, Triangles
/// Description:
///   Return true for a specific kind of degeneracy: any two triangle vertices are equal
/// Arguments:
///   tri = A list of three 2d points
///   eps = Tolerance in the geometrical tests.
function _degenerate_tri(tri,eps) =
    max(norm(tri[0]-tri[1]), norm(tri[1]-tri[2]), norm(tri[2]-tri[0])) < eps ;

/// Internal Function: _tri_class()
/// Usage:
///   class = _tri_class(triangle);
/// Topics: Geometry, Triangles
/// Description:
///   Return  1 if the triangle `tri` is CW.
///   Return  0 if the triangle `tri` has colinear vertices.
///   Return -1 if the triangle `tri` is CCW.
/// Arguments:
///   tri = A list of the three 2d vertices of a triangle.
///   eps = Tolerance in the geometrical tests.
function _tri_class(tri, eps=_EPSILON) =
    let( crx = cross(tri[1]-tri[2],tri[0]-tri[2]) )
    abs( crx ) <= eps*norm(tri[1]-tri[2])*norm(tri[0]-tri[2]) ? 0 : sign( crx );

/// Internal Function: _pt_in_tri()
/// Usage:
///   class = _pt_in_tri(point, tri);
/// Topics: Geometry, Points, Triangles
/// Description:
//   For CW triangles `tri` :
///    return  1 if point is inside the triangle interior.
///    return =0 if point is on the triangle border.
///    return -1 if point is outside the triangle.
/// Arguments:
///   point = The point to check position of.
///   tri  =  A list of the three 2d vertices of a triangle.
///   eps = Tolerance in the geometrical tests.
function _pt_in_tri(point, tri, eps=_EPSILON) = 
    min(  _tri_class([tri[0],tri[1],point],eps), 
          _tri_class([tri[1],tri[2],point],eps), 
          _tri_class([tri[2],tri[0],point],eps) );

// Function: is_collinear()
// Synopsis: Determine if points are collinear.
// Topics: Geometry, Points, Collinearity
// See Also: is_collinear(), is_point_on_line(), point_line_distance(), line_from_points()
// Usage:
//   bool = is_collinear(a, [b, c], [eps]);
// Description:
//   Returns true if the points `a`, `b` and `c` are co-linear or if the list of points `a` is collinear.
// Arguments:
//   a = First point or list of points.
//   b = Second point or undef; it should be undef if `c` is undef
//   c = Third point or undef.
//   eps = Tolerance in geometric comparisons.  Default: 1e-9
function is_collinear(a, b, c, eps=_EPSILON) =
    assert( is_path([a,b,c],dim=undef)
            || ( is_undef(b) && is_undef(c) && is_path(a,dim=undef) ),
            "\nInput should be 3 points or a list of points with same dimension.")
    assert( is_finite(eps) && (eps>=0), "\nThe tolerance should be a non-negative value." )
    let( points = is_def(c) ? [a,b,c]: a )
    len(points)<3 ? true :
    _noncollinear_triple(points,error=false,eps=eps) == [];

// Function: line_normal()
// Synopsis: Return normal vector to given line. 
// Topics: Geometry, Lines
// See Also: line_intersection(), line_from_points()
// Usage:
//   vec = line_normal([P1,P2])
//   vec = line_normal(p1,p2)
// Description:
//   Returns the 2D normal vector to the given 2D line. This is otherwise known as the perpendicular vector counter-clockwise to the given ray.
// Arguments:
//   p1 = First point on 2D line.
//   p2 = Second point on 2D line.
// Example(2D):
//   p1 = [10,10];
//   p2 = [50,30];
//   n = line_normal(p1,p2);
//   stroke([p1,p2], endcap2="arrow2");
//   color("green") stroke([p1,p1+10*n], endcap2="arrow2");
//   color("blue") move_copies([p1,p2]) circle(d=2, $fn=12);
function line_normal(p1,p2) =
    is_undef(p2)
      ? assert( len(p1)==2 && !is_undef(p1[1]) , "\nInvalid input." )
        line_normal(p1[0],p1[1])
      : assert( _valid_line([p1,p2],dim=2), "\nInvalid line." )
        unit([p1.y-p2.y,p2.x-p1.x]);

// 2D Line intersection from two segments.
// This function returns [p,t,u] where p is the intersection point of
// the lines defined by the two segments, t is the proportional distance
// of the intersection point along s1, and u is the proportional distance
// of the intersection point along s2.  The proportional values run over
// the range of 0 to 1 for each segment, so if it is in this range, then
// the intersection lies on the segment.  Otherwise it lies somewhere on
// the extension of the segment.  If lines are parallel or coincident then
// it returns undef.
function _general_line_intersection(s1,s2,eps=_EPSILON) =
    let(
        denominator = cross(s1[0]-s1[1],s2[0]-s2[1])
    )
    approx(denominator,0,eps=eps) ? undef :
    let(
        t = cross(s1[0]-s2[0],s2[0]-s2[1]) / denominator,
        u = cross(s1[0]-s2[0],s1[0]-s1[1]) / denominator
    )
    [s1[0]+t*(s1[1]-s1[0]), t, u];

// Function: line_intersection()
// Synopsis: Compute intersection of two lines, segments or rays.
// Topics: Geometry, Lines
// See Also: line_normal(), line_from_points()
// Usage:
//    pt = line_intersection(line1, line2, [bounded1], [bounded2], [bounded=], [eps=]);
// Description:
//    Returns the intersection point of any two 2D lines, segments or rays.  Returns undef
//    if they do not intersect.  You specify a line by giving two distinct points on the
//    line.  You specify rays or segments by giving a pair of points and indicating
//    bounded[0]=true to bound the line at the first point, creating rays based at l1[0] and l2[0],
//    or bounded[1]=true to bound the line at the second point, creating the reverse rays bounded
//    at l1[1] and l2[1].  If bounded=[true, true] then you have segments defined by their two
//    endpoints.  By using bounded1 and bounded2 you can mix segments, rays, and lines as needed.
//    You can set the bounds parameters to true as a shorthand for [true,true] to sepcify segments.
// Arguments:
//    line1 = List of two points in 2D defining the first line, segment or ray
//    line2 = List of two points in 2D defining the second line, segment or ray
//    bounded1 = boolean or list of two booleans defining which ends are bounded for line1.  Default: [false,false]
//    bounded2 = boolean or list of two booleans defining which ends are bounded for line2.  Default: [false,false]
//    ---
//    bounded = boolean or list of two booleans defining which ends are bounded for both lines.  The bounded1 and bounded2 parameters override this if both are given.
//    eps = tolerance for geometric comparisons.  Default: 1e-9
// Example(2D):  The segments do not intersect but the lines do in this example. 
//    line1 = 10*[[9, 4], [5, 7]];
//    line2 = 10*[[2, 3], [6, 5]];
//    stroke(line1, endcaps="arrow2");
//    stroke(line2, endcaps="arrow2");
//    isect = line_intersection(line1, line2);
//    color("red") translate(isect) circle(r=1,$fn=12);
// Example(2D): Specifying a ray and segment using the shorthand variables.
//    line1 = 10*[[0, 2], [4, 7]];
//    line2 = 10*[[10, 4], [3, 4]];
//    stroke(line1);
//    stroke(line2, endcap2="arrow2");
//    isect = line_intersection(line1, line2, SEGMENT, RAY);
//    color("red") translate(isect) circle(r=1,$fn=12);
// Example(2D): Here we use the same example as above, but specify two segments using the bounded argument.
//    line1 = 10*[[0, 2], [4, 7]];
//    line2 = 10*[[10, 4], [3, 4]];
//    stroke(line1);
//    stroke(line2);
//    isect = line_intersection(line1, line2, bounded=true);  // Returns undef
function line_intersection(line1, line2, bounded1, bounded2, bounded, eps=_EPSILON) =
    assert( is_finite(eps) && (eps>=0), "\nThe tolerance should be a non-negative value." )
    assert( _valid_line(line1,dim=2,eps=eps), "\nFirst line invalid.")
    assert( _valid_line(line2,dim=2,eps=eps), "\nSecond line invalid.")
    assert( is_undef(bounded) || is_bool(bounded) || is_bool_list(bounded,2), "\nInvalid value for \"bounded\".")
    assert( is_undef(bounded1) || is_bool(bounded1) || is_bool_list(bounded1,2), "\nInvalid value for \"bounded1\".")
    assert( is_undef(bounded2) || is_bool(bounded2) || is_bool_list(bounded2,2), "\nInvalid value for \"bounded2\".")
    let(isect = _general_line_intersection(line1,line2,eps=eps))
    is_undef(isect) ? undef :
    let(
        bounded1 = force_list(first_defined([bounded1,bounded,false]),2),
        bounded2 = force_list(first_defined([bounded2,bounded,false]),2),
        good =  (!bounded1[0] || isect[1]>=0-eps)
             && (!bounded1[1] || isect[1]<=1+eps)
             && (!bounded2[0] || isect[2]>=0-eps)
             && (!bounded2[1] || isect[2]<=1+eps)
    )
    good ? isect[0] : undef;

// Function: plane3pt()
// Synopsis: Return a plane from 3 points. 
// Topics: Geometry, Planes
// See Also: plane3pt(), plane3pt_indexed(), plane_from_normal(), plane_from_points(), plane_from_polygon()
// Usage:
//   plane = plane3pt(p1, p2, p3);
//   plane = plane3pt([p1, p2, p3]);
// Description:
//   Generates the normalized cartesian equation of a plane from three 3d points.
//   Returns [A,B,C,D] where Ax + By + Cz = D is the equation of a plane.
//   Returns undef, if the points are collinear.
// Arguments:
//   p1 = The first point on the plane.
//   p2 = The second point on the plane.
//   p3 = The third point on the plane.
function plane3pt(p1, p2, p3) =
    is_undef(p2) && is_undef(p3) && is_path(p1,dim=3) ? plane3pt(p1[0],p1[1],p1[2])
  : assert( is_path([p1,p2,p3],dim=3) && len(p1)==3,
            "\nInvalid points or incompatible dimensions." )
    let(
        crx = cross(p3-p1, p2-p1),
        nrm = norm(crx)
    ) approx(nrm,0) ? undef :
    concat(crx, crx*p1)/nrm;

// Function: plane3pt_indexed()
// Synopsis: Given list of 3d points and 3 indices, return the plane they define.  
// Topics: Geometry, Planes
// See Also: plane3pt(), plane3pt_indexed(), plane_from_normal(), plane_from_points(), plane_from_polygon()
// Usage:
//   plane = plane3pt_indexed(points, i1, i2, i3);
// Description:
//   Given a list of 3d points, and the indices of three of those points,
//   generates the normalized cartesian equation of a plane that those points all
//   lie on. If the points are not collinear, returns [A,B,C,D] where Ax+By+Cz=D is the equation of a plane.
//   If they are collinear, returns [].
// Arguments:
//   points = A list of points.
//   i1 = The index into `points` of the first point on the plane.
//   i2 = The index into `points` of the second point on the plane.
//   i3 = The index into `points` of the third point on the plane.
function plane3pt_indexed(points, i1, i2, i3) =
    is_undef(i3) && is_undef(i2) && is_vector(i1) ? plane3pt_indexed(points, i1[0], i1[1], i1[2])
  :
    assert( is_vector([i1,i2,i3]) && min(i1,i2,i3)>=0 && is_list(points) && max(i1,i2,i3)<len(points),
            "\nInvalid or out of range indices." )
    assert( is_path([points[i1], points[i2], points[i3]],dim=3),
            "\nImproper points or improper dimensions." )
    let(
        p1 = points[i1],
        p2 = points[i2],
        p3 = points[i3]
    ) plane3pt(p1,p2,p3);

// Function: plane_from_normal()
// Synopsis: Return plane defined by normal vector and a point. 
// Topics: Geometry, Planes
// See Also: plane3pt(), plane3pt_indexed(), plane_from_normal(), plane_from_points(), plane_from_polygon()
// Usage:
//   plane = plane_from_normal(normal, [pt])
// Description:
//   Returns a plane defined by a normal vector and a point.  If you omit `pt`, you get a plane
//   passing through the origin.  
// Arguments:
//   normal = Normal vector to the plane to find.
//   pt = Point 3D on the plane to find.
// Example:
//   plane_from_normal([0,0,1], [2,2,2]);  // Returns the xy plane passing through the point (2,2,2)
function plane_from_normal(normal, pt=[0,0,0]) =
    assert( is_matrix([normal,pt],2,3) && !approx(norm(normal),0),
            "\nInputs `normal` and `pt` should be 3d vectors/points and `normal` cannot be zero." )
    concat(normal, normal*pt) / norm(normal);

// Eigenvalues for a 3×3 symmetrical matrix in decreasing order
// Based on: https://en.wikipedia.org/wiki/Eigenvalue_algorithm
function _eigenvals_symm_3(M) =
  let( p1 = pow(M[0][1],2) + pow(M[0][2],2) + pow(M[1][2],2) )
  (p1<_EPSILON)
  ? -sort(-[ M[0][0], M[1][1], M[2][2] ]) //  diagonal matrix: eigenvals in decreasing order
  : let(  q  = (M[0][0]+M[1][1]+M[2][2])/3,
          B  = (M - q*ident(3)),
          dB = [B[0][0], B[1][1], B[2][2]],
          p2 = dB*dB + 2*p1,
          p  = sqrt(p2/6),
          r  = det3(B/p)/2,
          ph = acos(constrain(r,-1,1))/3,
          e1 = q + 2*p*cos(ph),
          e3 = q + 2*p*cos(ph+120),
          e2 = 3*q - e1 - e3 )
    [ e1, e2, e3 ];

// the i-th normalized eigenvector of a 3×3 symmetrical matrix M from its eigenvalues
// using Cayley–Hamilton theorem according to:
// https://en.wikipedia.org/wiki/Eigenvalue_algorithm
function _eigenvec_symm_3(M,evals,i=0) =
    let(
        I = ident(3),
        A = (M - evals[(i+1)%3]*I) * (M - evals[(i+2)%3]*I) ,
        k = max_index( [for(i=[0:2]) norm(A[i]) ])
    )
    norm(A[k])<_EPSILON ? I[k] : A[k]/norm(A[k]);

// finds the eigenvector corresponding to the smallest eigenvalue of the covariance matrix of a pointlist
// returns the mean of the points, the eigenvector and the greatest eigenvalue
function _covariance_evec_eval(points, eigenvalue_id) =
    let(  pm    = sum(points)/len(points), // mean point
          Y     = [ for(i=[0:len(points)-1]) points[i] - pm ],
          M     = transpose(Y)*Y ,     // covariance matrix
          evals = _eigenvals_symm_3(M), // eigenvalues in decreasing order
          evec  = _eigenvec_symm_3(M,evals,i=eigenvalue_id) )
    [pm, evec, evals[0] ];

// Function: plane_from_points()
// Synopsis: Return plane defined by a set of 3D points, with arbitrary normal direction.
// Topics: Geometry, Planes, Points
// See Also: plane3pt(), plane3pt_indexed(), plane_from_normal(), plane_from_points(), plane_from_polygon()
// Usage:
//   plane = plane_from_points(points, [check_coplanar], [eps]);
// Description:
//   Given a list of 3 or more 3D points, returns the coefficients of the normalized cartesian equation of a plane,
//   that is [A,B,C,D] where Ax+By+Cz=D is the equation of the plane and norm([A,B,C])=1.
//   .
//   If `check_coplanar=true`, the plane is returned if the points are all coplanar; otherwise `undef` is returned if the points are collinear or not coplanar.
//   If `check_coplanar=false`, then the coplanarity check is skipped and a best-fit plane is returned (where "best fit"
//   means minimal perpendiclular point-plane distances, not minimal vertical distances as one would get with least-squares fitting).
//   The direction of the plane's normal is arbitrary and is not determined by the point order, unlike {{plane_from_polygon()}}.
// Arguments:
//   points = The list of points to find the best-fit plane.
//   check_coplanar = If true, verify the point coplanarity within `eps` tolerance.  Default: false
//   eps = Tolerance in geometric comparisons.  Default: 1e-9
// Example(FlatSpin,VPD=320,VPT=[-2,5,-2]): 100 non-coplanar random points (yellow spheres) distributed in a volume, showing the best-fit plane (transparent square) with its normal vector.
//   points = rot(45, v=[-0.3,1,0],
//       p=random_points(100,3,scale=[50,50,15],seed=47));
//   plane = plane_from_points(points);
//   move_copies(points) sphere(d=3, $fn=12);
//   cp = mean(points);
//   move(cp) rot(from=UP,to=plane_normal(plane)) {
//       color("#06f") anchor_arrow(50, flag=false);
//       %linear_extrude(0.1) square(100, center=true);
//   }
function plane_from_points(points, check_coplanar=false, eps=_EPSILON, fast) =
    assert( is_path(points,dim=3), "\nImproper 3d point list." )
    assert( is_finite(eps) && (eps>=0), "\nThe tolerance should be a non-negative value." )
    len(points) == 3
      ? plane3pt(points[0],points[1],points[2]) 
      : let(
            dep = is_def(fast) ? echo("In plane_from_points() the 'fast' parameter is deprecated; use 'check_coplanar' instead.") true : false,
            check = dep ? fast : check_coplanar,
            covmix = _covariance_evec_eval(points,2),
            pm     = covmix[0], // point mean
            evec   = covmix[1], // eigenvector corresponding to smallest eigenvalue
            eval0  = covmix[2], // smallest eigenvalue
            plane  = [ each evec, pm*evec]
        )
        check && _pointlist_greatest_distance(points,plane)>eps*eval0 ? undef :
        plane ;

// Function: plane_from_polygon()
// Synopsis: Given a 3d planar polygon, returns directed plane.  
// Topics: Geometry, Planes, Polygons
// See Also: plane3pt(), plane3pt_indexed(), plane_from_normal(), plane_from_points(), plane_from_polygon()
// Usage:
//   plane = plane_from_polygon(points, [check_coplanar], [eps]);
// Description:
//   Given a 3D planar polygon, returns the normalized cartesian equation of its plane. 
//   Returns [A,B,C,D] where Ax+By+Cz=D is the equation of the plane where norm([A,B,C])=1.
//   If not all the points in the polygon are coplanar, then [] is returned.
//   If `check_coplanar=true` and the points in the list are collinear or not coplanar, then `undef` is returned.
//   if `check_coplanar=false`, then the coplanarity test is skipped and a plane passing through 3 non-collinear arbitrary points is returned.
//   The normal direction is determined by the order of the points and the right hand rule.
// Arguments:
//   poly = The planar 3D polygon to find the plane of.
//   check_coplanar = If false, doesn't verify that all points in the polygon are coplanar.  Default: true
//   eps = Tolerance in geometric comparisons.  Default: 1e-9
// Example(3D):
//   xyzpath = rot(45, v=[0,1,0], p=path3d(star(n=5,step=2,d=100), 70));
//   plane = plane_from_polygon(xyzpath);
//   #stroke(xyzpath,closed=true,width=3);
//   cp = centroid(xyzpath);
//   move(cp) rot(from=UP,to=plane_normal(plane)) anchor_arrow(45);
function plane_from_polygon(poly, check_coplanar=true, eps=_EPSILON, fast) =
    assert( is_path(poly,dim=3), "\nInvalid polygon." )
    assert( is_finite(eps) && (eps>=0), "\nThe tolerance should be a non-negative value." )
    let(
        dep = is_def(fast) ? echo("In plane_from_polygon() the 'fast' parameter is deprecated; use 'check_coplanar' instead.") true : false,
        check = dep ? fast : check_coplanar,
        poly_normal = polygon_normal(poly)
    )
    is_undef(poly_normal) ? undef :
    let(
        plane = plane_from_normal(poly_normal, poly[0])
    )
    !check ? plane : are_points_on_plane(poly, plane, eps=eps) ? plane : undef;

// Function: plane_normal()
// Synopsis: Returns the normal vector to a plane. 
// Topics: Geometry, Planes
// See Also: plane3pt(), plane3pt_indexed(), plane_from_normal(), plane_from_points(), plane_from_polygon(), plane_normal(), plane_offset()
// Usage:
//   vec = plane_normal(plane);
// Description:
//   Returns the unit length normal vector for the given plane.
// Arguments:
//   plane = The `[A,B,C,D]` plane definition where `Ax+By+Cz=D` is the formula of the plane.
function plane_normal(plane) =
    assert( _valid_plane(plane), "\nInvalid input plane." )
    unit([plane.x, plane.y, plane.z]);

// Returns [POINT, U] if line intersects plane at one point, where U is zero at line[0] and 1 at line[1]
// Returns [LINE, undef] if the line is on the plane.
// Returns undef if line is parallel to, but not on the given plane.
function _general_plane_line_intersection(plane, line, eps=_EPSILON) =
    let(
        a = plane*[each line[0],-1],         //  evaluation of the plane expression at line[0]
        b = plane*[each(line[1]-line[0]),0]  // difference between the plane expression evaluation at line[1] and at line[0]
    )
    approx(b,0,eps)                          // is  (line[1]-line[0]) "parallel" to the plane ?
      ? approx(a,0,eps)                      // is line[0] on the plane ?
        ? [line,undef]                       // line is on the plane
        : undef                              // line is parallel but not on the plane
      : [ line[0]-a/b*(line[1]-line[0]), -a/b ];

/// Internal Function: normalize_plane()
/// Usage:
///   nplane = normalize_plane(plane);
/// Topics: Geometry, Planes
/// Description:
///   Returns a new representation [A,B,C,D] of `plane` where norm([A,B,C]) is equal to one.
function _normalize_plane(plane) =
    assert( _valid_plane(plane), str("\nInvalid plane ",plane, ".") )
    plane/norm(point3d(plane));

// Function: plane_line_intersection()
// Synopsis: Returns the intersection of a plane and 3d line, segment or ray.  
// Topics: Geometry, Planes, Lines, Intersection
// See Also: plane3pt(), plane_from_normal(), plane_from_points(), plane_from_polygon(), line_intersection()
// Usage:
//   pt = plane_line_intersection(plane, line, [bounded], [eps]);
// Description:
//   Takes a line, and a plane [A,B,C,D] where the equation of that plane is `Ax+By+Cz=D`.
//   If `line` intersects `plane` at one point, then that intersection point is returned.
//   If `line` lies on `plane`, then the original given `line` is returned.
//   If `line` is parallel to, but not on `plane`, then undef is returned.
// Arguments:
//   plane = The [A,B,C,D] values for the equation of the plane.
//   line = A list of two distinct 3D points that are on the line.
//   bounded = If false, the line is considered unbounded.  If true, it is treated as a bounded line segment.  If given as `[true, false]` or `[false, true]`, the boundedness of the points are specified individually, allowing the line to be treated as a half-bounded ray.  Default: false (unbounded)
//   eps = Tolerance in geometric comparisons.  Default: 1e-9
function plane_line_intersection(plane, line, bounded=false, eps=_EPSILON) =
    assert( is_finite(eps) && eps>=0, "\nThe tolerance should be a positive number." )
    assert(_valid_plane(plane,eps=eps) && _valid_line(line,dim=3,eps=eps), "\nInvalid plane and/or 3d line.")
    assert(is_bool(bounded) || is_bool_list(bounded,2), "\nInvalid bound condition.")
    let(
        bounded = is_list(bounded)? bounded : [bounded, bounded],
        res = _general_plane_line_intersection(plane, line, eps=eps)
    ) is_undef(res) ? undef :
    is_undef(res[1]) ? res[0] :
    bounded[0] && res[1]<0 ? undef :
    bounded[1] && res[1]>1 ? undef :
    res[0];

// Function: plane_intersection()
// Synopsis: Returns the intersection of two or three planes.  
// Topics: Geometry, Planes, Intersection
// See Also: plane3pt(), plane_from_normal(), plane_from_points(), plane_from_polygon(), line_intersection()
// Usage:
//   line = plane_intersection(plane1, plane2)
//   pt = plane_intersection(plane1, plane2, plane3)
// Description:
//   Compute the point that is the intersection of the three planes, or the line intersection of two planes.
//   If you give three planes the intersection is returned as a point.  If you give two planes the intersection
//   is returned as a list of two points on the line of intersection.  If any two input planes are parallel
//   or coincident then returns undef.
// Arguments:
//   plane1 = The [A,B,C,D] coefficients for the first plane equation `Ax+By+Cz=D`.
//   plane2 = The [A,B,C,D] coefficients for the second plane equation `Ax+By+Cz=D`.
//   plane3 = The [A,B,C,D] coefficients for the third plane equation `Ax+By+Cz=D`.
function plane_intersection(plane1,plane2,plane3) =
    assert( _valid_plane(plane1) && _valid_plane(plane2) && (is_undef(plane3) ||_valid_plane(plane3)),
                "\nThe input must be 2 or 3 planes." )
    is_def(plane3)
      ? let(
            matrix = [for(p=[plane1,plane2,plane3]) point3d(p)],
            rhs = [for(p=[plane1,plane2,plane3]) p[3]]
        )
        linear_solve(matrix,rhs)
      : let( normal = cross(plane_normal(plane1), plane_normal(plane2)) )
        approx(norm(normal),0) ? undef :
        let(
            matrix = [for(p=[plane1,plane2]) point3d(p)],
            rhs = [plane1[3], plane2[3]],
            point = linear_solve(matrix,rhs)
        )
        point==[]? undef:
        [point, point+normal];

// Function: point_plane_distance()
// Synopsis: Determine distance between a point and plane. 
// Topics: Geometry, Planes, Distance
// See Also: plane3pt(), line_closest_point(), plane_closest_point()
// Usage:
//   dist = point_plane_distance(plane, point)
// Description:
//   Given a plane as [A,B,C,D] where the cartesian equation for that plane
//   is Ax+By+Cz=D, determines how far from that plane the given point is.
//   The returned distance is positive if the point is above the
//   plane, meaning on the side where the plane normal points.  
//   If the point is below the plane, then the distance returned
//   is negative.  The normal of the plane is [A,B,C].
// Arguments:
//   plane = The `[A,B,C,D]` plane definition where `Ax+By+Cz=D` is the formula of the plane.
//   point = The distance evaluation point.
function point_plane_distance(plane, point) =
    assert( _valid_plane(plane), "\nInvalid input plane." )
    assert( is_vector(point,3), "\nThe point should be a 3D point." )
    let( plane = _normalize_plane(plane) )
    point3d(plane)* point - plane[3];

// the maximum distance from points to the plane
function _pointlist_greatest_distance(points,plane) =
    let(
        normal = [plane[0],plane[1],plane[2]],
        pt_nrm = points*normal
    )
    max( max(pt_nrm) - plane[3], -min(pt_nrm) + plane[3]) / norm(normal);

// Function: are_points_on_plane()
// Synopsis: Determine if all of the listed points are on a plane. 
// Topics: Geometry, Planes, Points
// See Also: plane3pt(), line_closest_point(), plane_closest_point(), is_coplanar()
// Usage:
//   bool = are_points_on_plane(points, plane, [eps]);
// Description:
//   Returns true if the given 3D points are on the given plane.
// Arguments:
//   plane = The plane to test the points on.
//   points = The list of 3D points to test.
//   eps = Tolerance in geometric comparisons.  Default: 1e-9
function are_points_on_plane(points, plane, eps=_EPSILON) =
    assert( _valid_plane(plane), "\nInvalid plane." )
    assert( is_matrix(points,undef,3) && len(points)>0, "\nInvalid pointlist." ) // using is_matrix it accepts len(points)==1
    assert( is_finite(eps) && eps>=0, "\nThe tolerance should be a positive number." )
    _pointlist_greatest_distance(points,plane) < eps;

/// Internal Function: is_point_above_plane()
/// Usage:
///   bool = _is_point_above_plane(plane, point);
/// Topics: Geometry, Planes
/// Description:
///   Given a plane as [A,B,C,D] where the cartesian equation for that plane
///   is Ax+By+Cz=D, determines if the given 3D point is on the side of that
///   plane that the normal points toward.  The normal of the plane is the
///   same as [A,B,C].
/// Arguments:
///   plane = The [A,B,C,D] coefficients for the first plane equation `Ax+By+Cz=D`.
///   point = The 3D point to test.
function _is_point_above_plane(plane, point) =
    point_plane_distance(plane, point) > _EPSILON;

// Function: circle_2tangents()
// Synopsis: Given two 2d or 3d rays, find a circle tangent to both.  
// Topics: Geometry, Circles, Tangents
// See Also: circle_line_intersection(), circle_circle_intersection(), circle_2tangents(), circle_3points(), circle_point_tangents(), circle_circle_tangents()
// Usage:
//   circ = circle_2tangents(r|d=, pt1, pt2, pt3, [tangents=]);
//   circ = circle_2tangents(r|d=, [PT1, PT2, PT3], [tangents=]);
// Description:
//   Given a pair of 2d or 3d rays with a common origin, and a known circle radius/diameter, finds
//   the centerpoint for the circle of that size that touches both rays tangentally.
//   Both rays start at `pt2`, one passing through `pt1`, and the other through `pt3`.
//   .
//   When called with collinear rays, returns `undef`.
//   Otherwise, when called with `tangents=false`, returns `[CP,NORMAL]`.
//   Otherwise, when called with `tangents=true`, returns `[CP,NORMAL,TANPT1,TANPT2]`.
//   - CP is the centerpoint of the circle.
//   - NORMAL is the normal vector of the plane that the circle is on (UP or DOWN if the points are 2D).
//   - TANPT1 is the point where the circle is tangent to the ray `[pt2,pt1]`.
//   - TANPT2 is the point where the circle is tangent to the ray `[pt2,pt3]`.
// Figure(3D,Med,NoAxes,VPD=130,VPT=[29,19,3],VPR=[55,0,25]):
//   pts = [[45,10,-5], [10,5,10], [15,40,5]];
//   rad = 15;
//   circ = circle_2tangents(r=rad, pt1=pts[0], pt2=pts[1], pt3=pts[2], tangents=true);
//   cp = circ[0]; n = circ[1]; tp1 = circ[2]; tp2 = circ[3];
//   color("yellow") stroke(pts, endcaps="arrow2");
//   color("purple") move_copies([cp,tp1,tp2]) sphere(d=2, $fn=12);
//   color("lightgray") stroke([cp,tp2], width=0.5);
//   stroke([cp,cp+n*20], endcap2="arrow2");
//   labels = [
//       ["pt1",    "blue",  2.5, [ 4, 0, 1], pts[0]],
//       ["pt2",    "blue",  2.5, [-4, 0,-3], pts[1]],
//       ["pt3",    "blue",  2.5, [ 4, 0, 1], pts[2]],
//       ["r",      "blue",  2.5, [ 0,-2, 2], (cp+tp2)/2],
//       ["CP",     "brown", 2.5, [ 6,-4, 3], cp],
//       ["Normal", "brown", 2.0, [ 5, 2, 1], cp+20*n],
//       ["TanPt1", "brown", 2.0, [-5,-4, 0], tp1],
//       ["TanPt2", "brown", 2.0, [-5, 0, 2], tp2],
//   ];
//   for(l=labels)
//       color(l[1]) move(l[4]+l[3]) rot([55,0,25])
//           linear_extrude(height=0.1)
//               text(text=l[0], size=l[2], halign="center", valign="center");
//   color("green",0.5) move(cp) cyl(h=0.1, r=rad, orient=n, $fn=36);
// Arguments:
//   r = The radius of the circle to find.
//   pt1 = A point that the first ray passes though.
//   pt2 = The starting point of both rays.
//   pt3 = A point that the second ray passes though.
//   ---
//   d = The diameter of the circle to find.
//   tangents = If true, extended information about the tangent points is calculated and returned.  Default: false
// Example(2D):
//   pts = [[40,40], [10,10], [55,5]];  rad = 10;
//   circ = circle_2tangents(r=rad, pt1=pts[0], pt2=pts[1], pt3=pts[2]);
//   stroke(pts, endcaps="arrow2");
//   color("red") move(circ[0]) circle(r=rad);
// Example(2D):
//   pts = [[20,40], [10,10], [55,20]];  rad = 10;
//   circ = circle_2tangents(r=rad, pt1=pts[0], pt2=pts[1], pt3=pts[2], tangents=true);
//   stroke(pts, endcaps="arrow2");
//   color("red") move(circ[0]) circle(r=rad);
//   color("blue") move_copies(select(circ,2,3)) circle(d=2);
// Example(3D): Fit into 3D path corner.
//   pts = [[45,5,10], [10,10,15], [30,40,30]];  rad = 10;
//   circ = circle_2tangents(rad, [pts[0], pts[1], pts[2]]);
//   stroke(pts, endcaps="arrow2");
//   color("red") move(circ[0]) cyl(h=10, r=rad, orient=circ[1]);
// Example(3D):
//   path = yrot(20, p=path3d(star(d=100, n=5, step=2)));
//   stroke(path, closed=true);
//   for (i = [0:1:5]) {
//       crn = select(path, i*2-1, i*2+1);
//       ci = circle_2tangents(5, crn[0], crn[1], crn[2]);
//       move(ci[0]) cyl(h=10,r=5,orient=ci[1]);
//   }
function circle_2tangents(r, pt1, pt2, pt3, tangents=false, d) =
    let(r = get_radius(r=r, d=d, dflt=undef))
    assert(r!=undef, "\nMust specify either r or d.")
    assert( ( is_path(pt1) && len(pt1)==3 && is_undef(pt2) && is_undef(pt3))
            || (is_matrix([pt1,pt2,pt3]) && (len(pt1)==2 || len(pt1)==3) ),
            str("\nInvalid input points. pt1=",pt1,", pt2=",pt2,", pt3=",pt3))
    is_undef(pt2)
    ? circle_2tangents(r, pt1[0], pt1[1], pt1[2], tangents=tangents)
    : is_collinear(pt1, pt2, pt3)? undef :
        let(
            v1 = unit(pt1 - pt2),
            v2 = unit(pt3 - pt2),
            vmid = unit(mean([v1, v2])),
            n = vector_axis(v1, v2),
            a = vector_angle(v1, v2),
            hyp = r / sin(a/2),
            cp = pt2 + hyp * vmid
        )
        !tangents ? [cp, n] :
        let(
            x = hyp * cos(a/2),
            tp1 = pt2 + x * v1,
            tp2 = pt2 + x * v2
        )
        [cp, n, tp1, tp2];

// Function: circle_3points()
// Synopsis: Find a circle passing through three 2d or 3d points. 
// Topics: Geometry, Circles
// See Also: circle_line_intersection(), circle_circle_intersection(), circle_2tangents(), circle_3points(), circle_point_tangents(), circle_circle_tangents()
// Usage:
//   circ = circle_3points(pt1, pt2, pt3);
//   circ = circle_3points([PT1, PT2, PT3]);
// Description:
//   Returns the [CENTERPOINT, RADIUS, NORMAL] of the circle that passes through three non-collinear
//   points where NORMAL is the normal vector of the plane that the circle is on (UP or DOWN if the points are 2D).
//   The centerpoint is a 2D or 3D vector, depending on the points input.  If all three
//   points are 2D, then the resulting centerpoint will be 2D, and the normal is UP ([0,0,1]).
//   If any of the points are 3D, then the resulting centerpoint will be 3D.  If the three points are
//   collinear, then `[undef,undef,undef]` is returned.  The normal is a normalized 3D
//   vector with a non-negative Z axis.  Instead of 3 arguments, it is acceptable to input the 3 points
//   as a list given in `pt1`, leaving `pt2`and `pt3` as undef.
// Arguments:
//   pt1 = The first point.
//   pt2 = The second point.
//   pt3 = The third point.
// Example(2D):
//   pts = [[60,40], [10,10], [65,5]];
//   circ = circle_3points(pts[0], pts[1], pts[2]);
//   translate(circ[0]) color("green") stroke(circle(r=circ[1]),closed=true,$fn=72);
//   translate(circ[0]) color("red") circle(d=3, $fn=12);
//   move_copies(pts) color("blue") circle(d=3, $fn=12);
function circle_3points(pt1, pt2, pt3) =
    (is_undef(pt2) && is_undef(pt3) && is_list(pt1))
      ? circle_3points(pt1[0], pt1[1], pt1[2])
      : assert( is_vector(pt1) && is_vector(pt2) && is_vector(pt3)
                && max(len(pt1),len(pt2),len(pt3))<=3 && min(len(pt1),len(pt2),len(pt3))>=2,
                "\nInvalid point(s)." )
        is_collinear(pt1,pt2,pt3)? [undef,undef,undef] :
        let(
            v  = [ point3d(pt1), point3d(pt2), point3d(pt3) ], // triangle vertices
            ed = [for(i=[0:2]) v[(i+1)%3]-v[i] ],    // triangle edge vectors
            pm = [for(i=[0:2]) v[(i+1)%3]+v[i] ]/2,  // edge mean points
            es = sortidx( [for(di=ed) norm(di) ] ),
            e1 = ed[es[1]],                          // take the 2 longest edges
            e2 = ed[es[2]],
            n0 = vector_axis(e1,e2),                 // normal standardization
            n  = n0.z<0? -n0 : n0,
            sc = plane_intersection(
                    [ each e1, e1*pm[es[1]] ],       // planes orthogonal to 2 edges
                    [ each e2, e2*pm[es[2]] ],
                    [ each n,  n*v[0] ]
                ),  // triangle plane
            cp = len(pt1)+len(pt2)+len(pt3)>6 ? sc : [sc.x, sc.y],
            r  = norm(sc-v[0])
        ) [ cp, r, n ];

/// Internal Function: _noncollinear_triple()
/// Usage:
///   bool = _noncollinear_triple(points);
/// Topics: Geometry, Noncollinearity
/// Description:
///   Finds the indices of three non-collinear points from the pointlist `points`.
///   It selects two well separated points to define a line and chooses the third point
///   to be the point farthest off the line.  The points do not necessarily having the
///   same winding direction as the polygon so they cannot be used to determine the
///   winding direction or the direction of the normal.  
///   If all points are collinear returns [] when `error=true` or an error otherwise .
/// Arguments:
///   points = List of input points.
///   error = Defines the behaviour for collinear input points. When `true`, produces an error, otherwise returns []. Default: `true`.
///   eps = Tolerance for collinearity test. Default: 1e-9.
function _noncollinear_triple(points,error=true,eps=_EPSILON) =
    assert( is_path(points), "\nInvalid input points." )
    assert( is_finite(eps) && (eps>=0), "The tolerance should be a non-negative value." )
    len(points)<3 ? [] :
    let(
        pa = points[0],
        b  = furthest_point(pa, points),
        pb = points[b],
        nrm = norm(pa-pb)
    )
    nrm <= eps ?
        assert(!error, "\nCannot find three noncollinear points in pointlist.") [] :
    let(
        n = (pb-pa)/nrm,
        distlist = [for(i=[0:len(points)-1]) _dist2line(points[i]-pa, n)]
    )
    max(distlist) < eps*nrm ?
        assert(!error, "\nCannot find three noncollinear points in pointlist.") [] :
    [0, b, max_index(distlist)];

// Section: Polygons

// Function: polygon_area()
// Synopsis: Calculate area of a 2d or 3d polygon. 
// Topics: Geometry, Polygons, Area
// See Also: polygon_area(), centroid(), polygon_normal(), point_in_polygon(), polygon_line_intersection()
// Usage:
//   area = polygon_area(poly, [signed]);
// Description:
//   Given a 2D or 3D simple planar polygon, returns the area of that polygon.
//   If the polygon is non-planar the result is `undef.`  If the polygon is self-intersecting
//   then the returned area is a meaningless number.  
//   When `signed` is true and the polygon is 2d, a signed area is returned: a positive area indicates a counter-clockwise polygon.
//   The area of 3d polygons is always nonnegative.  
// Arguments:
//   poly = Polygon to compute the area of.
//   signed = If true, a signed area is returned. Default: false.
function polygon_area(poly, signed=false) =
    assert(is_path(poly), "\nInvalid polygon." )
    len(poly)<3 ? 0 :
    len(poly)==3 ?
        let( total= len(poly[0])==2 ? 0.5*cross(poly[2]-poly[0],poly[2]-poly[1]) : 0.5*norm(cross(poly[2]-poly[0],poly[2]-poly[1])))
        signed ? total : abs(total) :
    len(poly[0])==2
      ? let( total = sum([for(i=[1:1:len(poly)-2]) cross(poly[i]-poly[0],poly[i+1]-poly[0]) ])/2 )
        signed ? total : abs(total)
      : let( plane = plane_from_polygon(poly) )
        is_undef(plane) ? undef :
        let( 
            n = plane_normal(plane),  
            total = 
                -sum([ for(i=[1:1:len(poly)-2])
                        cross(poly[i]-poly[0], poly[i+1]-poly[0]) 
                    ]) * n/2
        ) 
        signed ? total : abs(total);

// Function: centroid()
// Synopsis: Compute centroid of a 2d or 3d polygon or a VNF. 
// Topics: Geometry, Polygons, Centroid
// See Also: polygon_area(), centroid(), polygon_normal(), point_in_polygon(), polygon_line_intersection()
// Usage:
//   c = centroid(object, [eps]);
// Description:
//   Given a simple 2D polygon, returns the 2D coordinates of the polygon's centroid.
//   Given a simple 3D planar polygon, returns the 3D coordinates of the polygon's centroid.
//   Providing a non-planar or collinear polygon results in an error.  For self-intersecting
//   polygons you may get an error or you may get meaningless results.
//   .
//   Given a [region](regions.scad), returns the 2D coordinates of the region's centroid.
//   .
//   Given a manifold [VNF](vnf.scad) then returns the 3D centroid of the polyhedron.  The VNF must
//   describe a valid polyhedron with consistent face direction and no holes in the mesh; otherwise
//   the results are undefined.
// Arguments:
//   object = object to compute the centroid of
//   eps = epsilon value for identifying degenerate cases
// Example(2D):
//   path = [
//       [-10,10], [-5,15], [15,15], [20,0],
//       [15,-5], [25,-20], [25,-27], [15,-20],
//       [0,-30], [-15,-25], [-5,-5]
//   ];
//   linear_extrude(height=0.01) polygon(path);
//   cp = centroid(path);
//   color("red") move(cp) sphere(d=2);
function centroid(object,eps=_EPSILON) =
    assert(is_finite(eps) && (eps>=0), "\nThe tolerance should a non-negative value." )
    is_vnf(object) ? _vnf_centroid(object,eps)
  : is_path(object,[2,3]) ? _polygon_centroid(object,eps)
  : is_region(object) ? (len(object)==1 ? _polygon_centroid(object[0],eps) : _region_centroid(object,eps))
  : assert(false, "\nInput must be a VNF, a region, or a 2D or 3D polygon");

/// Internal Function: _region_centroid()
/// Compute centroid of region
function _region_centroid(region,eps=_EPSILON) =
   let(
       region=force_region(region),
       parts = region_parts(region),
       // Rely on region_parts returning all outside polygons clockwise
       // and inside (hole) polygons counterclockwise, so areas have reversed sign
       cent_area = [for(R=parts, p=R)
                       let(A=polygon_area(p,signed=true))
                       [A*_polygon_centroid(p),A]],
       total = sum(cent_area)
   )
   total[0]/total[1];

/// Internal Function: _polygon_centroid()
/// Usage:
///   cpt = _polygon_centroid(poly);
/// Topics: Geometry, Polygons, Centroid
/// Description:
///   Given a simple 2D polygon, returns the 2D coordinates of the polygon's centroid.
///   Given a simple 3D planar polygon, returns the 3D coordinates of the polygon's centroid.
///   Collinear points produce an error.  The results are meaningless for self-intersecting
///   polygons or an error is produced.
/// Arguments:
///   poly = Points of the polygon from which the centroid is calculated.
///   eps = Tolerance in geometric comparisons.  Default: 1e-9
function _polygon_centroid(poly, eps=_EPSILON) =
    assert( is_path(poly,dim=[2,3]), "\nThe input must be a 2D or 3D polygon." )
    let(
        n = len(poly[0])==2 ? 1 :
            let( plane = plane_from_points(poly, check_coplanar=true))
            assert(!is_undef(plane), "\nThe polygon must be planar." )
            plane_normal(plane),
        v0 = poly[0] ,
        val = sum([
            for(i=[1:len(poly)-2])
            let(
                v1 = poly[i],
                v2 = poly[i+1],
                area = cross(v2-v0,v1-v0)*n
            ) [ area, (v0+v1+v2)*area ]
        ])
    )
    assert(!approx(val[0],0, eps), "\nThe polygon is self-intersecting or its points are collinear.")
    val[1]/val[0]/3;

// Function: polygon_normal()
// Synopsis: Return normal to a polygon.  
// Topics: Geometry, Polygons
// See Also: polygon_area(), centroid(), polygon_normal(), point_in_polygon(), polygon_line_intersection()
// Usage:
//   vec = polygon_normal(poly);
// Description:
//   Given a 3D simple planar polygon, returns a unit normal vector for the polygon.  The vector
//   is oriented so that if the normal points toward the viewer, the polygon winds in the clockwise
//   direction.  If the polygon has zero area, returns `undef`.  If the polygon is self-intersecting
//   the the result is undefined.  It doesn't check for coplanarity.
// Arguments:
//   poly = The list of 3D path points for the perimeter of the polygon.
// Example(3D):
//   path = rot([0,30,15], p=path3d(star(n=5, d=100, step=2)));
//   stroke(path, closed=true);
//   n = polygon_normal(path);
//   rot(from=UP, to=n)
//       color("red")
//           stroke([[0,0,0], [0,0,20]], endcap2="arrow2");
function polygon_normal(poly) =
    assert(is_path(poly,dim=3), "\nInvalid 3D polygon." )
    let(
        area_vec = sum([for(i=[1:len(poly)-2])
                           cross(poly[i]-poly[0],
                                 poly[i+1]-poly[i])])
    )
    unit(-area_vec, error=undef);

function point_in_polygon(point, poly, nonzero=false, eps=_EPSILON) =
    // Original algorithms from http://geomalgorithms.com/a03-_inclusion.html
    assert( is_vector(point,2) && is_path(poly,dim=2) && len(poly)>2,
            "\nThe point and polygon should be in 2D. The polygon should have more that 2 points." )
    assert( is_finite(eps) && (eps>=0), "\nThe tolerance should be a non-negative value." )
    // Check bounding box
    let(
        box = pointlist_bounds(poly)
    )
    point.x<box[0].x-eps || point.x>box[1].x+eps
        || point.y<box[0].y-eps || point.y>box[1].y+eps  ? -1
    :
    // Does the point lie on any edges?  If so return 0.
    let(
        segs = pair(poly,true),
        on_border = [for (seg=segs)
                       if (norm(seg[0]-seg[1])>eps && _is_point_on_line(point, seg, SEGMENT, eps=eps)) 1]
    )
    on_border != [] ? 0 :
    nonzero    // Compute winding number and return 1 for interior, -1 for exterior
      ? let(
            winding = [
                       for(seg=segs)
                         let(
                             p0=seg[0]-point,
                             p1=seg[1]-point
                         )
                         if (norm(p0-p1)>eps)
                             p0.y <=0
                                ? p1.y > 0 && cross(p0,p1-p0)>0 ? 1 : 0
                                : p1.y <=0 && cross(p0,p1-p0)<0 ? -1: 0
            ]
        )
        sum(winding) != 0 ? 1 : -1
      : // or compute the crossings with the ray [point, point+[1,0]]
        let(
            cross = [
                     for(seg=segs)
                       let(
                           p0 = seg[0]-point,
                           p1 = seg[1]-point
                       )
                       if (
                           ( (p1.y>eps && p0.y<=eps) || (p1.y<=eps && p0.y>eps) )
                           &&  -eps < p0.x - p0.y *(p1.x - p0.x)/(p1.y - p0.y)
                       )
                       1
            ]
        )
        2*(len(cross)%2)-1;

// Function: polygon_line_intersection()
// Synopsis: Find intersection between 2d or 3d polygon and a line, segment or ray.  
// Topics: Geometry, Polygons, Lines, Intersection
// See Also: polygon_area(), centroid(), polygon_normal(), point_in_polygon(), polygon_line_intersection()
// Usage:
//   pt_or_segments = polygon_line_intersection(poly, line, [bounded], [nonzero], [eps]);
// Description:
//   Takes a possibly bounded line, and a 2D or 3D planar polygon, and finds their intersection.  The polygon is
//   treated as its boundary and interior, so the intersection may include both points and line segments.
//   Returns:
//     * If the line does not intersect the polygon: `undef`.
//     * In 3D if the line is not coplanar with the polygon but intersects it: the intersection point as a 3-vector, `[x,y,z]`.
//     * In the 2D case or the 3D case when the line is coplanar with the polygon: list of segments or degenerate single point "segments".
//   .
//   In 3D, you can distinguish output cases using {{is_vector()}}.  When run on the output it returns `true` when the output is a single
//   intersection point from a non-coplanar line.
//   .
//   In the 2D or coplanar case, the result is a **list** of segments, so the common case of a single segment will be a
//   singleton list of the form `[[p1,p2]]`.  A single point appears on the segment list as a degenerate segment or the form `[p]`,
//   so this means in 3D a single point will appears as `[[[x,y,z]]]` in the coplanar case.  This makes it possible to distinguish
//   the coplanar and non-coplanar cases.  An intersection featuring two segments and a point could look like `[[p1,p2], [q], [r1,r2]]`.
//   To determine if an entry in the segment list is a true segment, check its length, which is 2 for a segment and 1 for a point. 
// Arguments:
//   poly = The 3D planar polygon to find the intersection with.
//   line = A list of two distinct 3D points on the line.
//   bounded = If false, the line is considered unbounded.  If true, it is treated as a bounded line segment.  If given as `[true, false]` or `[false, true]`, the boundedness of the points are specified individually, allowing the line to be treated as a half-bounded ray.  Default: false (unbounded)
//   nonzero = set to true to use the nonzero rule for determining it points are in a polygon.  See {{point_in_polygon()}}.  Default: false.
//   eps = Tolerance in geometric comparisons.  Default: 1e-9
// Example(3D): The line intersects the 3d hexagon in a single point. 
//   hex = zrot(140,p=rot([-45,40,20],p=path3d(hexagon(r=15))));
//   line = [[5,0,-13],[-3,-5,13]];
//   isect = polygon_line_intersection(hex,line);
//   stroke(hex,closed=true);
//   stroke(line);
//   color("red")move(isect)sphere(r=1,$fn=12);
// Example(2D): In 2D things are more complicated.  The output is a list of intersection parts, in the simplest case a single segment.
//   hex = hexagon(r=15);
//   line = [[-20,10],[25,-7]];
//   isect = polygon_line_intersection(hex,line);
//   stroke(hex,closed=true);
//   stroke(line,endcaps="arrow2");
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) sphere(r=1);
//        else
//          stroke(part);
// Example(2D): Here the line is treated as a ray. 
//   hex = hexagon(r=15);
//   line = [[0,0],[25,-7]];
//   isect = polygon_line_intersection(hex,line,RAY);
//   stroke(hex,closed=true);
//   stroke(line,endcap2="arrow2");
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) circle(r=1,$fn=12);
//        else
//          stroke(part);
// Example(2D): Here the intersection is a single point, which is returned as a single point "path" on the path list.
//   hex = hexagon(r=15);
//   line = [[15,-10],[15,13]];
//   isect = polygon_line_intersection(hex,line,RAY);
//   stroke(hex,closed=true);
//   stroke(line,endcap2="arrow2");
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) circle(r=1,$fn=12);
//        else
//          stroke(part);
// Example(2D): Another way to get a single segment
//   hex = hexagon(r=15);
//   line = rot(30,p=[[15,-10],[15,25]],cp=[15,0]);
//   isect = polygon_line_intersection(hex,line,RAY);
//   stroke(hex,closed=true);
//   stroke(line,endcap2="arrow2");
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) circle(r=1,$fn=12);
//        else
//          stroke(part);
// Example(2D): Single segment again
//   star = star(r=15,n=8,step=2);
//   line = [[20,-5],[-5,20]];
//   isect = polygon_line_intersection(star,line,RAY);
//   stroke(star,closed=true);
//   stroke(line,endcap2="arrow2");
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) circle(r=1,$fn=12);
//        else
//          stroke(part);
// Example(2D): Solution is two points
//   star = star(r=15,n=8,step=3);
//   line = rot(22.5,p=[[15,-10],[15,20]],cp=[15,0]);
//   isect = polygon_line_intersection(star,line,SEGMENT);
//   stroke(star,closed=true);
//   stroke(line);
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) circle(r=1,$fn=12);
//        else
//          stroke(part);
// Example(2D): Solution is list of three segments
//   star = star(r=25,ir=9,n=8);
//   line = [[-25,12],[25,12]];
//   isect = polygon_line_intersection(star,line);
//   stroke(star,closed=true);
//   stroke(line,endcaps="arrow2");
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) circle(r=1,$fn=12);
//        else
//          stroke(part);
// Example(2D): Solution is a mixture of segments and points
//   star = star(r=25,ir=9,n=7);
//   line = [left(10,p=star[8]), right(50,p=star[8])];
//   isect = polygon_line_intersection(star,line);
//   stroke(star,closed=true);
//   stroke(line,endcaps="arrow2");
//   color("red")
//     for(part=isect)
//        if(len(part)==1)
//          move(part[0]) circle(r=1,$fn=12);
//        else
//          stroke(part);
function polygon_line_intersection(poly, line, bounded=false, nonzero=false, eps=_EPSILON) =
    assert( is_finite(eps) && eps>=0, "\nThe tolerance should be a positive number." )
    assert(is_path(poly,dim=[2,3]), "\nInvalid polygon." )
    assert(is_bool(bounded) || is_bool_list(bounded,2), "\nInvalid bound condition.")
    assert(_valid_line(line,dim=len(poly[0]),eps=eps), "\nLine invalid or does not match polygon dimension." )
    let(
        bounded = force_list(bounded,2),
        poly = deduplicate(poly)
    )
    len(poly[0])==2 ?  // planar case
       let( 
            linevec = unit(line[1] - line[0]),
            bound = 100*max(v_abs(flatten(pointlist_bounds(poly)))),
            boundedline = [line[0] + (bounded[0]? 0 : -bound) * linevec,
                           line[1] + (bounded[1]? 0 :  bound) * linevec],
            parts = split_region_at_region_crossings(boundedline, [poly], closed1=false)[0][0],
            inside = [
                      if(point_in_polygon(parts[0][0], poly, nonzero=nonzero, eps=eps) == 0)
                         [parts[0][0]],   // Add starting point if it is on the polygon
                      for(part = parts)
                         if (point_in_polygon(mean(part), poly, nonzero=nonzero, eps=eps) >=0 )
                             part
                         else if(len(part)==2 && point_in_polygon(part[1], poly, nonzero=nonzero, eps=eps) == 0)
                             [part[1]]   // Add segment end if it is on the polygon
                     ]
        )
        (len(inside)==0 ? undef : _merge_segments(inside, [inside[0]], eps))
    : // 3d case
       let(indices = _noncollinear_triple(poly))
       indices==[] ? undef :   // Polygon is collinear
       let(
           plane = plane3pt(poly[indices[0]], poly[indices[1]], poly[indices[2]]),
           plane_isect = plane_line_intersection(plane, line, bounded, eps)
       )
       is_undef(plane_isect) ? undef :  
       is_vector(plane_isect,3) ?  
           let(
               poly2d = project_plane(plane,poly),
               pt2d = project_plane(plane, plane_isect)
           )
           (point_in_polygon(pt2d, poly2d, nonzero=nonzero, eps=eps) < 0 ? undef : plane_isect)
       : // Case where line is on the polygon plane
           let(
               poly2d = project_plane(plane, poly),
               line2d = project_plane(plane, line),
               segments = polygon_line_intersection(poly2d, line2d, bounded=bounded, nonzero=nonzero, eps=eps)
           )
           segments==undef ? undef
         : [for(seg=segments) len(seg)==2 ? lift_plane(plane,seg) : [lift_plane(plane,seg[0])]];

function _merge_segments(insegs,outsegs, eps, i=1) = 
    i==len(insegs) ? outsegs : 
    approx(last(last(outsegs)), insegs[i][0], eps) 
        ? _merge_segments(insegs, [each list_head(outsegs),[last(outsegs)[0],last(insegs[i])]], eps, i+1)
        : _merge_segments(insegs, [each outsegs, insegs[i]], eps, i+1);

// Function: polygon_triangulate()
// Synopsis: Divide a polygon into triangles. 
// Topics: Geometry, Triangulation
// See Also: vnf_triangulate()
// Usage:
//   triangles = polygon_triangulate(poly, [ind], [error], [eps])
// Description:
//   Given a simple polygon in 2D or 3D, triangulates it and returns a list 
//   of triples indexing into the polygon vertices. When the optional argument `ind` is 
//   given, it is used as an index list into `poly` to define the polygon vertices. In that case, 
//   `poly` may have a length greater than `ind`. When `ind` is undefined, all points in `poly` 
//   are considered as vertices of the polygon.
//   .
//   For 2d polygons, the output triangleshave the same winding (CW or CCW) of
//   the input polygon. For 3d polygons, the triangle windings induce a normal
//   vector with the same direction of the polygon normal.
//   .
//   The function produces correct triangulations for some non-twisted non-simple polygons. 
//   A polygon is non-twisted if it is simple or it has a partition in
//   simple polygons with the same winding such that the intersection of any two partitions is
//   made of full edges and/or vertices of both partitions. These polygons may have "touching" vertices 
//   (two vertices having the same coordinates, but distinct adjacencies) and "contact" edges 
//   (edges whose vertex pairs have the same pairwise coordinates but are in reversed order) but has 
//   no self-crossing. See examples bellow. If all polygon edges are contact edges (polygons with 
//   zero area), it returns an empty list for 2d polygons and reports an error for 3d polygons. 
//   Triangulation errors are reported either by an assert error (when `error=true`) or by returning 
//   `undef` (when `error=false`). Invalid arguments always produce an assert error.
//   .
//   Twisted polygons have no consistent winding and when input to this function usually reports 
//   an error but when an error is not reported the outputs are not correct triangulations. The function
//   can work for 3d non-planar polygons if they are close enough to planar but may otherwise 
//   report an error for this case. 
// Arguments:
//   poly = Array of the polygon vertices.
//   ind = If given, a list of indices indexing the vertices of the polygon in `poly`.  Default: use all the points of poly
//   error = If false, returns `undef` when the polygon cannot be triangulated; otherwise, issues an assert error. Default: true.
//   eps = A maximum tolerance in geometrical tests. Default: 1e-9
// Example(2D,NoAxes): a simple polygon; see from above
//   poly = star(id=10, od=15,n=11);
//   tris =  polygon_triangulate(poly);
//   color("lightblue") for(tri=tris) polygon(select(poly,tri));
//   color("blue")    up(1) for(tri=tris) { stroke(select(poly,tri),.15,closed=true); }
//   color("magenta") up(2) stroke(poly,.25,closed=true); 
//   color("black")   up(3) debug_vnf([path3d(poly),[]],faces=false,size=1);
// Example(2D,NoAxes): a polygon with a hole and one "contact" edge; see from above
//   poly = [ [-10,0], [10,0], [0,10], [-10,0], [-4,4], [4,4], [0,2], [-4,4] ];
//   tris =  polygon_triangulate(poly);
//   color("lightblue") for(tri=tris) polygon(select(poly,tri));
//   color("blue")    up(1) for(tri=tris) { stroke(select(poly,tri),.15,closed=true); }
//   color("magenta") up(2) stroke(poly,.25,closed=true); 
//   color("black")   up(3) debug_vnf([path3d(poly),[]],faces=false,size=1);
// Example(2D,NoAxes): a polygon with "touching" vertices and no holes; see from above
//   poly = [ [0,0], [5,5], [-5,5], [0,0], [-5,-5], [5,-5] ];
//   tris =  polygon_triangulate(poly);
//   color("lightblue") for(tri=tris) polygon(select(poly,tri));
//   color("blue")    up(1) for(tri=tris) { stroke(select(poly,tri),.15,closed=true); }
//   color("magenta") up(2) stroke(poly,.25,closed=true); 
//   color("black")   up(3) debug_vnf([path3d(poly),[]],faces=false,size=1);
// Example(2D,NoAxes): a polygon with "contact" edges and no holes; see from above
//   poly = [ [0,0], [10,0], [10,10], [0,10], [0,0], [3,3], [7,3], 
//            [7,7], [7,3], [3,3] ];
//   tris =  polygon_triangulate(poly);
//   color("lightblue") for(tri=tris) polygon(select(poly,tri));
//   color("blue")    up(1) for(tri=tris) { stroke(select(poly,tri),.15,closed=true); }
//   color("magenta") up(2) stroke(poly,.25,closed=true); 
//   color("black")   up(3) debug_vnf([path3d(poly),[]],faces=false,size=1);
// Example(3D): 
//   include <BOSL2/polyhedra.scad>
//   vnf = regular_polyhedron_info(name="dodecahedron",side=5,info="vnf");
//   vnf_polyhedron(vnf);
//   vnf_tri = [vnf[0], [for(face=vnf[1]) each polygon_triangulate(vnf[0], face) ] ];
//   color("blue")
//   vnf_wireframe(vnf_tri, width=.15);
function polygon_triangulate(poly, ind, error=true, eps=_EPSILON) =
    assert(is_path(poly) && len(poly)>=3, "\nPolygon `poly` should be a list of at least three 2d or 3d points")
    assert(is_undef(ind) || (is_vector(ind) && min(ind)>=0 && max(ind)<len(poly) ),
           "Improper or out of bounds list of indices")
    let( ind = is_undef(ind) ? count(len(poly)) : ind )
    len(ind) <=2 ? [] :
    len(ind) == 3 
      ? _degenerate_tri([poly[ind[0]], poly[ind[1]], poly[ind[2]]], eps) ? [] : 
        // non zero area
        let(
            cp = cross(poly[ind[1]]-poly[ind[0]], poly[ind[2]]-poly[ind[0]]), 
            degen = is_num(cp) ? abs(cp) < 2*eps
                               : norm(cp) < 2*eps
        )
        assert( ! error || ! degen, "\nThe polygon vertices are collinear.") 
        degen ? undef : [ind]
      : len(poly[ind[0]]) == 3 
          ? // find a representation of the polygon as a 2d polygon by projecting it on its own plane
            let( 
                ind = deduplicate_indexed(poly, ind, eps) 
            )
            len(ind)<3 ? [] :
            let(
                pts = select(poly,ind),
                nrm = -polygon_normal(pts)
            )
            assert( ! error || (nrm != undef), 
                    "\nThe polygon has self-intersections or zero area or its vertices are collinear or non coplanar.") 
            nrm == undef ? undef :
            let(
                imax  = max_index([for(p=pts) norm(p-pts[0]) ]),
                v1    = unit( pts[imax] - pts[0] ),
                v2    = cross(v1,nrm),
                prpts = pts*transpose([v1,v2]) // the 2d projection of pts on the polygon plane
            )
            let( tris = _triangulate(prpts, count(len(ind)), error, eps) )
            tris == undef ? undef :
            [for(tri=tris) select(ind,tri) ]
          : is_polygon_clockwise(select(poly, ind)) 
              ? _triangulate( poly, ind, error, eps )
              : let( tris = _triangulate( poly, reverse(ind), error, eps ) )
                tris == undef ? undef :
                [for(tri=tris) reverse(tri) ];

// poly is supposed to be a 2d cw polygon
// implements a modified version of ear cut method for non-twisted polygons
// the polygons accepted by this function are those decomposable in simple
// CW polygons.
function _triangulate(poly, ind,  error, eps=_EPSILON, tris=[]) =
    len(ind)==3 
    ?   _degenerate_tri(select(poly,ind),eps) 
        ?   tris // if last 3 pts perform a degenerate triangle, ignore it
        :   concat(tris,[ind]) // otherwise, include it
    :   let( ear = _get_ear(poly,ind,eps) )
        assert( ! error || (ear != undef), 
            "\nThe polygon has twists or all its vertices are collinear or non coplanar.") 
        ear == undef ? undef :
        is_list(ear) // is it a degenerate ear ?
        ?   len(ind) <= 4 ? tris :
            _triangulate(poly, select(ind,ear[0]+3, ear[0]), error, eps, tris) // discard it
        :   let(
                ear_tri = select(ind,ear,ear+2),
                indr    = select(ind,ear+2, ear) //  indices of the remaining path
            )
            _triangulate(poly, indr, error, eps, concat(tris,[ear_tri]));

/// a returned ear will be:
/// 1. a CW non-reflex triangle, made of subsequent poly vertices, without any other 
///    poly points inside except possibly at its own vertices
/// 2. or a degenerate triangle where two vertices are coincident
/// the returned ear is specified by the index of `ind` of its first vertex
function _get_ear(poly, ind,  eps, _i=0) =
    let( lind = len(ind) )
    lind==3 ? 0 :
    let( // the _i-th ear candidate
        p0 = poly[ind[_i]],
        p1 = poly[ind[(_i+1)%lind]],
        p2 = poly[ind[(_i+2)%lind]]
    )
    // if vertex p1 is a convex candidate to be an ear,
    // check if the triangle [p0,p1,p2] contains any other point
    // except possibly p0 and p2
    // exclude the ear candidate central vertex p1 from the verts to check 
    _tri_class([p0,p1,p2],eps) > 0  
    &&  _none_inside(select(ind,_i+2, _i),poly,p0,p1,p2,eps) ? _i : // found an ear
    // otherwise check the next ear candidate 
    _i<lind-1 ?  _get_ear(poly, ind,  eps, _i=_i+1) :
    // poly has no ears, look for wiskers
    let( wiskers = [for(j=idx(ind)) if(norm(poly[ind[j]]-poly[ind[(j+2)%lind]])<eps) j ] )
    wiskers==[] ? undef : [wiskers[0]];

/// returns false ASA it finds some reflex vertex of poly[idxs[.]] 
/// inside the triangle different from p0 and p2
/// note: to simplify the expressions it is assumed that the input polygon has no twists
function _none_inside(idxs,poly,p0,p1,p2,eps,i=0) =
    i>=len(idxs) ? true :
    let( 
        vert      = poly[idxs[i]], 
        prev_vert = poly[select(idxs,i-1)], 
        next_vert = poly[select(idxs,i+1)]
    )
    // check if vert prevent [p0,p1,p2] to be an ear
    // this conditions might have a simpler expression
    _tri_class([prev_vert, vert, next_vert],eps) <= 0  // reflex condition
    &&  (  // vert is a cw reflex poly vertex inside the triangle [p0,p1,p2]
          ( _tri_class([p0,p1,vert],eps)>0 && 
            _tri_class([p1,p2,vert],eps)>0 && 
            _tri_class([p2,p0,vert],eps)>=0  )
          // or it is equal to p1 and some of its adjacent edges cross the open segment (p0,p2)
          ||  ( norm(vert-p1) < eps 
                && _is_at_left(p0,[prev_vert,p1],eps) && _is_at_left(p2,[p1,prev_vert],eps) 
                && _is_at_left(p2,[p1,next_vert],eps) && _is_at_left(p0,[next_vert,p1],eps) 
              ) 
        )
    ?   false
    :   _none_inside(idxs,poly,p0,p1,p2,eps,i=i+1);

// Function: is_polygon_clockwise()
// Synopsis: Determine if a 2d polygon winds clockwise.  
// Topics: Geometry, Polygons, Clockwise
// See Also: clockwise_polygon(), ccw_polygon(), reverse_polygon()
// Usage:
//   bool = is_polygon_clockwise(poly);
// Description:
//   Return true if the given 2D simple polygon is in clockwise order, false otherwise.
//   Results for complex (self-intersecting) polygon are indeterminate.
// Arguments:
//   poly = The list of 2D path points for the perimeter of the polygon.

// For algorithm see 2.07 here: http://www.faqs.org/faqs/graphics/algorithms-faq/
function is_polygon_clockwise(poly) =
    assert(is_path(poly,dim=2), "\nInput should be a 2d path.")
    let(
        minx = min(poly*[1,0]),
        lowind = search(minx, poly, 0, 0),
        lowpts = select(poly,lowind),
        miny = min(lowpts*[0,1]),
        extreme_sub = search(miny, lowpts, 1, 1)[0],
        extreme = lowind[extreme_sub]
    )
    cross(select(poly,extreme+1)-poly[extreme],
          select(poly,extreme-1)-poly[extreme])<0;

// Function: clockwise_polygon()
// Synopsis: Return clockwise version of a polygon. 
// Topics: Geometry, Polygons, Clockwise
// See Also: is_polygon_clockwise(), ccw_polygon(), reverse_polygon()
// Usage:
//   newpoly = clockwise_polygon(poly);
// Description:
//   Given a 2D polygon path, returns the clockwise winding version of that path.
// Arguments:
//   poly = The list of 2D path points for the perimeter of the polygon.
function clockwise_polygon(poly) =
    assert(is_path(poly,dim=2), "\nInput should be a 2d polygon.")
    is_polygon_clockwise(poly) ? poly : reverse_polygon(poly);

// Function: ccw_polygon()
// Synopsis: Return counter-clockwise version of a polygon. 
// Topics: Geometry, Polygons, Clockwise
// See Also: is_polygon_clockwise(), clockwise_polygon(), reverse_polygon()
// Usage:
//   newpoly = ccw_polygon(poly);
// Description:
//   Given a 2D polygon poly, returns the counter-clockwise winding version of that poly.
// Arguments:
//   poly = The list of 2D path points for the perimeter of the polygon.
function ccw_polygon(poly) =
    assert(is_path(poly,dim=2), "\nInput should be a 2d polygon.")
    is_polygon_clockwise(poly) ? reverse_polygon(poly) : poly;

// Function: reverse_polygon()
// Synopsis: Reverse winding direction of polygon. 
// Topics: Geometry, Polygons, Clockwise
// See Also: is_polygon_clockwise(), ccw_polygon(), clockwise_polygon()
// Usage:
//   newpoly = reverse_polygon(poly)
// Description:
//   Reverses a polygon's winding direction, while still using the same start point.
// Arguments:
//   poly = The list of the path points for the perimeter of the polygon.
function reverse_polygon(poly) =
    let(poly=force_path(poly,"poly"))
    assert(is_path(poly), "\nInput should be a polygon.")
    [ poly[0], for(i=[len(poly)-1:-1:1]) poly[i] ];

// Section: Convex Hull

// This section originally based on Oskar Linde's Hull:
//   - https://github.com/openscad/scad-utils


// Function: hull()
// Synopsis: Convex hull of a list of 2d or 3d points.
// SynTags: Ext
// Topics: Geometry, Hulling
// See Also: hull_points(), hull2d_path(), hull3d_faces()
// Usage:
//   face_list_or_index_list = hull(points);
// Description:
//   This is documentation for the BOSL2 function form of `hull()`.  [Click Here for documentation for the builtin module.](https://github.com/BelfrySCAD/BelfrySCAD/wiki/Language-Other-Modules#hull)
//   .
//   Takes a list of 2D or 3D points (but not both in the same list) and returns either the list of
//   indexes into `points` that forms the 2D convex hull perimeter path, or the list of faces that
//   form the 3d convex hull surface.  Each face is a list of indexes into `points`.  If the input
//   points are collinear, the indexes of the two extrema points are returned.  If the input
//   points are coplanar, then a simple list of vertex indices forming a planar perimeter is
//   returned. Otherwise a list of faces is returned, where each face is a simple list of
//   vertex indices for the perimeter of the face.
// Arguments:
//   points = The set of 2D or 3D points to find the hull of.
function hull(points) =
    assert(is_path(points),"\nInvalid input to hull.")
    len(points[0]) == 2
      ? hull2d_path(points)
      : hull3d_faces(points);

// Module: hull_points()
// Synopsis: Convex hull of a list of 2d or 3d points.  
// Topics: Geometry, Hulling
// See Also: hull(), hull_points(), hull2d_path(), hull3d_faces()
// Usage:
//   hull_points(points, [fast]);
// Description:
//   If given a list of 2D points, creates a 2D convex hull polygon that encloses all those points.
//   If given a list of 3D points, creates a 3D polyhedron that encloses all the points.  This should
//   handle about 4000 points in slow mode.  If `fast` is set to true, this should be able to handle
//   far more.  When fast mode is off, 3d hulls that lie in a plane produce a single face of a polyhedron, which can be viewed in preview but will not render.
// Arguments:
//   points = The list of points to form a hull around.
//   fast = If true for 3d case, uses a faster cheat that may handle more points, but also may emit warnings that can stop your script if you have "Halt on first warning" enabled.  Ignored for the 2d case.  Default: false
// Example(2D):
//   pts = [[-10,-10], [0,10], [10,10], [12,-10]];
//   hull_points(pts);
// Example(3D):
//   pts = [for (phi = [30:60:150], theta = [0:60:359]) spherical_to_xyz(10, theta, phi)];
//   hull_points(pts);
module hull_points(points, fast=false) {
    no_children($children);
    check = assert(is_path(points))
            assert(len(points)>=3, "\nPoint list must contain 3 points");
    attachable(){
      if (len(points[0])==2)
         hull() polygon(points=points);
      else if (len(points)==3)
         polyhedron(points=points, faces=[[0,1,2]]);
      else {
        if (fast) {
           extra = len(points)%3;
           faces = [
                     [for(i=[0:1:extra+2])i], // If vertex count not divisible by 3, combine extras with first 3
                     for(i=[extra+3:3:len(points)-3])[i,i+1,i+2]
                   ];
           hull() polyhedron(points=points, faces=faces);
        } else {
          faces = hull(points);
          if (is_num(faces[0])){
            if (len(faces)<=2) echo("Hull contains only two points");
            else polyhedron(points=points, faces=[faces]);
          }
          else polyhedron(points=points, faces=faces);
        }
      }
      union();
    }
}

function _backtracking(i,points,h,t,m,all) =
    m<t || _is_cw(points[i], points[h[m-1]], points[h[m-2]],all) ? m :
    _backtracking(i,points,h,t,m-1,all) ;

// clockwise check (2d)
function _is_cw(a,b,c,all) = 
    all ? cross(a-c,b-c)<=_EPSILON*norm(a-c)*norm(b-c) :
    cross(a-c,b-c)<-_EPSILON*norm(a-c)*norm(b-c);

// Function: hull2d_path()
// Synopsis: Convex hull of a list of 2d points. 
// Topics: Geometry, Hulling
// See Also: hull(), hull_points(), hull2d_path(), hull3d_faces()
// Usage:
//   index_list = hull2d_path(points,all)
// Description:
//   Takes a list of arbitrary 2D points, and finds the convex hull polygon to enclose them.
//   Returns a path as a list of indices into `points`. 
//   When all==true, returns extra points that are on edges of the hull.
// Arguments:
//   points = list of 2d points to get the hull of.
//   all = when true, includes all points on the edges of the convex hull. Default: false.
// Example(2D):
//   pts = [[-10,-10], [0,10], [10,10], [12,-10]];
//   path = hull2d_path(pts);
//   move_copies(pts) color("red") circle(1,$fn=12);
//   polygon(points=pts, paths=[path]);
//
// Code based on this method:
// https://www.hackerearth.com/practice/math/geometry/line-sweep-technique/tutorial/
//
function hull2d_path(points, all=false) =
    assert(is_path(points,2),"\nInvalid input to hull2d_path.")
    len(points) < 2 ? [] :
    let( n  = len(points), 
         ip = sortidx(points) )
    // lower hull points
    let( lh = 
            [ for(   i = 2,
                    k = 2, 
                    h = [ip[0],ip[1]]; // current list of hull point indices 
                  i <= n;
                    k = i<n ? _backtracking(ip[i],points,h,2,k,all)+1 : k,
                    h = i<n ? [for(j=[0:1:k-2]) h[j], ip[i]] : [], 
                    i = i+1
                 ) if( i==n ) h ][0] )
    // concat lower hull points with upper hull ones
    [ for(   i = n-2,
            k = len(lh), 
            t = k+1,
            h = lh; // current list of hull point indices 
          i >= -1;
            k = i>=0 ? _backtracking(ip[i],points,h,t,k,all)+1 : k,
            h = [for(j=[0:1:k-2]) h[j], if(i>0) ip[i]],
            i = i-1
         ) if( i==-1 ) h ][0] ;

function _hull_collinear(points) =
    let(
        a = points[0],
        i = max_index([for(pt=points) norm(pt-a)]),
        n = points[i] - a
    )
    norm(n)==0 ? [0]
    :
    let(
        points1d = [ for(p = points) (p-a)*n ],
        min_i = min_index(points1d),
        max_i = max_index(points1d)
    ) [min_i, max_i];

// Function: hull3d_faces()
// Synopsis: Convex hull of a list of 3d points. 
// Topics: Geometry, Hulling
// See Also: hull(), hull_points(), hull2d_path(), hull3d_faces()
// Usage:
//   faces = hull3d_faces(points)
// Description:
//   Takes a list of arbitrary 3D points, and finds the convex hull polyhedron to enclose
//   them.  Returns a list of triangular faces, where each face is a list of indexes into the given `points`
//   list.  The output is valid for use with the `polyhedron()` command, but may include vertices that are in the interior of a face of the hull, so it is not
//   necessarily the minimal representation of the hull.  
//   If all points passed to it are coplanar, then the return is the list of indices of points
//   forming the convex hull polygon.
// Example(3D):
//   pts = [[-20,-20,0], [20,-20,0], [0,20,5], [0,0,20]];
//   faces = hull3d_faces(pts);
//   move_copies(pts) color("red") sphere(1);
//   %polyhedron(points=pts, faces=faces);
function hull3d_faces(points) =
    assert(is_path(points,3),"\nInvalid input to hull3d_faces.")
    len(points) < 3 ? count(len(points))
  : let ( // start with a single non-collinear triangle
          tri = _noncollinear_triple(points, error=false)
        )
    tri==[] ? _hull_collinear(points)
  : let(
        a = tri[0],
        b = tri[1],
        c = tri[2],
        plane = plane3pt_indexed(points, a, b, c),
        d = _find_first_noncoplanar(plane, points)
    )
    d == len(points)
  ? /* all coplanar*/
    let (
        pts2d =  project_plane([points[a], points[b], points[c]],points),
        hull2d = hull2d_path(pts2d)
    ) hull2d
  : let(
        remaining = [for (i = [0:1:len(points)-1]) if (i!=a && i!=b && i!=c && i!=d) i],
        // Build an initial tetrahedron.
        // Swap b, c if d is in front of triangle t.
        ifop = _is_point_above_plane(plane, points[d]),
        bc = ifop? [c,b] : [b,c],
        b = bc[0],
        c = bc[1],
        triangles = [
            [a,b,c],
            [d,b,a],
            [c,d,a],
            [b,d,c]
        ],
        // calculate the plane equations
        planes = [ for (t = triangles) plane3pt_indexed(points, t[0], t[1], t[2]) ]
    ) _hull3d_iterative(points, triangles, planes, remaining);

// Adds the remaining points one by one to the convex hull
function _hull3d_iterative(points, triangles, planes, remaining, _i=0) = //let( _EPSILON=1e-12 )
    _i >= len(remaining) ? triangles : 
    let (
        // pick a point
        i = remaining[_i],
        // evaluate the triangle plane equations at point i
        planeq_val = planes*[each points[i], -1],
        // find the triangles that are in conflict with the point (point not inside)
        conflicts = [for (i = [0:1:len(planeq_val)-1]) if (planeq_val[i]>_EPSILON) i ],
        // collect the halfedges of all triangles that are in conflict 
        halfedges = [ 
            for(c = conflicts, i = [0:2])
                [triangles[c][i], triangles[c][(i+1)%3]]
        ],
        // find the outer perimeter of the set of conflicting triangles
        horizon = _remove_internal_edges(halfedges),
        // generate new triangles connecting point i to each horizon halfedge vertices
        tri2add = [ for (h = horizon) concat(h,i) ],
        // add tria2add and remove conflict triangles
        new_triangles = 
            concat( tri2add,
                    [ for (i = [0:1:len(planes)-1]) if (planeq_val[i]<=_EPSILON) triangles[i] ] 
                  ),
        // add the plane equations of new added triangles and remove the plane equations of the conflict ones
        new_planes = 
            [ for (t = tri2add) plane3pt_indexed(points, t[0], t[1], t[2]) ,
              for (i = [0:1:len(planes)-1]) if (planeq_val[i]<=_EPSILON) planes[i] ] 
    ) _hull3d_iterative(
        points,
        new_triangles,
        new_planes,
        remaining,
        _i+1
    );

function _remove_internal_edges(halfedges) = [
    for (h = halfedges)  
        if (!in_list(reverse(h), halfedges))
            h
];

function _find_first_noncoplanar(plane, points, i=0) = 
    (i >= len(points) || !are_points_on_plane([points[i]],plane))? i :
    _find_first_noncoplanar(plane, points, i+1);

// Section: Rotation Decoding

// Function: rot_decode()
// Synopsis: Extract axis and rotation angle from a rotation matrix. 
// Topics: Affine, Matrices, Transforms
// Usage:
//   info = rot_decode(rotation,[long]); // Returns: [angle,axis,cp,translation]
// Description:
//   Given an input 3D rigid transformation operator (one composed of just rotations and translations) represented
//   as a 4x4 matrix, compute the rotation and translation parameters of the operator.  Returns a list of the
//   four parameters, the angle, in the interval [0,180], the rotation axis as a unit vector, a centerpoint for
//   the rotation, and a translation.  If you set `parms = rot_decode(rotation)` then the transformation can be
//   reconstructed from parms as `move(parms[3]) * rot(a=parms[0],v=parms[1],cp=parms[2])`.  This decomposition
//   makes it possible to perform interpolation.  If you construct a transformation using `rot` the decoding
//   may flip the axis (if you gave an angle outside of [0,180]).  The returned axis is a unit vector, and
//   the centerpoint lies on the plane through the origin that is perpendicular to the axis.  It may be different
//   than the centerpoint you used to construct the transformation.
//   .
//   If you set `long` to true then return the reversed rotation, with the angle in [180,360].
// Arguments:
//   rotation = rigid transformation to decode
//   long = if true return the "long way" around, with the angle in [180,360].  Default: false
// Example:
//   info = rot_decode(rot(45));
//          // Returns: [45, [0,0,1], [0,0,0], [0,0,0]]
//   info = rot_decode(rot(a=37, v=[1,2,3], cp=[4,3,-7])));
//          // Returns: [37, [0.26, 0.53, 0.80], [4.8, 4.6, -4.6], [0,0,0]]
//   info = rot_decode(left(12)*xrot(-33));
//          // Returns: [33, [-1,0,0], [0,0,0], [-12,0,0]]
//   info = rot_decode(translate([3,4,5]));
//          // Returns: [0, [0,0,1], [0,0,0], [3,4,5]]
function rot_decode(M,long=false) =
    assert(is_matrix(M,4,4) && approx(M[3],[0,0,0,1]), "\nInput matrix must be a 4×4 matrix representing a 3d transformation.")
    let(R = submatrix(M,[0:2],[0:2]))
    assert(approx(det3(R),1) && approx(norm_fro(R * transpose(R)-ident(3)),0),"\nInput matrix is not a rotation.")
    let(
        translation = [for(row=[0:2]) M[row][3]],   // translation vector
        largest  = max_index([R[0][0], R[1][1], R[2][2]]),
        axis_matrix = R + transpose(R) - (matrix_trace(R)-1)*ident(3),   // Each row is on the rotational axis
            // Construct quaternion q = c * [x sin(theta/2), y sin(theta/2), z sin(theta/2), cos(theta/2)]
        q_im = axis_matrix[largest],
        q_re = R[(largest+2)%3][(largest+1)%3] - R[(largest+1)%3][(largest+2)%3],
        c_sin = norm(q_im),              // c * sin(theta/2) for some c
        c_cos = abs(q_re)                // c * cos(theta/2)
    )
    approx(c_sin,0) ? [0,[0,0,1],[0,0,0],translation] :
    let(
        angle = 2*atan2(c_sin, c_cos),    // This is supposed to be more accurate than acos or asin
        axis  = (q_re>=0 ? 1:-1)*q_im/c_sin,
        tproj = translation - (translation*axis)*axis,    // Translation perpendicular to axis determines centerpoint
        cp    = (tproj + cross(axis,tproj)*c_cos/c_sin)/2
    )
    [long ? 360-angle:angle,
     long? -axis : axis,
     cp,
     (translation*axis)*axis];

// onescad: BOSL2/regions.scad
//////////////////////////////////////////////////////////////////////
// LibFile: regions.scad
//   This file provides 2D Boolean set operations on polygons, where you can
//   compute, for example, the intersection or union of the shape defined by point lists, producing
//   a new point list.  Of course, such operations may produce shapes with multiple
//   components.  To handle that, we use "regions", which are lists of paths representing the polygons.
//   In addition to set operations, you can calculate offsets, determine whether a point is in a
//   region and you can decompose a region into parts.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Advanced Modeling
// FileSummary: Offsets and Boolean geometry of 2D paths and regions.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Regions
//   A {{region}} is a list of polygons meeting these conditions:
//   .
//   - Every polygon on the list is simple, meaning it does not intersect itself
//   - Two polygons on the list do not cross each other
//   - A vertex of one polygon never meets the edge of another one except at a vertex
//   .
//   This means vertex-vertex touching between two polygons is acceptable
//   to define a region.  Note, however, that regions with vertex-vertex contact usually
//   cannot be rendered with CGAL.  See {{is_valid_region()}} for examples of valid regions and
//   lists of polygons that are not regions. Note that {{is_region_simple()}} identifies
//   regions with no polygon intersections at all, which should render successfully witih CGAL.  
//   .
//   The actual geometry of the region is defined by XORing together
//   all of the polygons in the list.  This may sound obscure, but it simply means that nested
//   boundaries make rings in the obvious fashion, and non-nested shapes simply union together.
//   Checking that a list of polygons is a valid region, meaning that it satisfies all of the conditions
//   above, can be a time consuming test, so it is not done automatically.  It is your responsibility to ensure that your regions are
//   compliant.  You can construct regions by making a suitable list of polygons, or by using
//   set operation function such as {{union()}} or {{difference()}}, which all acccept polygons, as
//   well as regions, as their inputs. If you must, you can clean up an ill-formed region using
//   {{make_region()}}, which breaks up self-intersecting polygons and polygons that cross each other.
//
// Figure(2D): An Sample {{Region}}
//   path1 = union([
//       circle(d=100),
//       translate([50,20], p=circle(d=40))
//   ])[0];
//   rgn = [
//       // Main shape
//       select(path1, hull(path1)),
//       translate([50,20], p=circle(d=20)),
//       rot(-8, p=hexagon(d=60, rounding=10)),
//       // Inner disjointed shape
//       circle(d=25),
//       rot(30-8, p=rect(10)),
//       // External disjoined shape
//       each translate([60,-25], p=rot(55, p=[
//           rect([20,15], rounding=5),
//           ellipse([6,3])
//       ])),
//   ];
//   region(rgn);
//

// Definitions:
//   Region|Regions = A list of one or more non-intersecting {{polygons}} representing a union of one or more disconnected polygons that may have internal holes.

// Function: is_region()
// Synopsis: Returns true if the input appears to be a {{region}}.
// Topics: Regions, Paths, Polygons, List Handling
// See Also: is_valid_region(), is_1region(), is_region_simple()
// Usage:
//   bool = is_region(x);
// Description:
//   Returns true if the given item looks like a {{region}}.  A region is a list of non-crossing simple {{polygons}}.  This test just checks
//   that the argument is a list whose first entry is a path.
function is_region(x) = is_list(x) && is_path(x.x);

// Function: force_region()
// Synopsis: Given a polygon returns a region.
// SynTags: Region
// Topics: Regions, Paths, Polygons, List Handling
// See Also: make_region(), region()
// Usage:
//   region = force_region(poly)
// Description:
//   If the input is a polygon then return it as a region.  Otherwise return it unaltered.
// Arguments:
//   poly = polygon to turn into a region
function force_region(poly) = is_path(poly) ? [poly] : poly;

// Section: Geometrical calculations with regions

// Function: point_in_region()
// Synopsis: Tests if a point is inside, outside, or on the border of a {{region}}. 
// Topics: Regions, Points, Comparison
// See Also: region_area(), are_regions_equal()
// Usage:
//   check = point_in_region(point, region, [eps]);
// Description:
//   Tests if a point is inside, outside, or on the border of a {{region}}.  
//   Returns -1 if the point is outside the region.
//   Returns 0 if the point is on the boundary.
//   Returns 1 if the point lies inside the region.
// Arguments:
//   point = The point to test.
//   region = The region to test against, as a list of polygon paths.
//   eps = Acceptable variance.  Default: 1e-9
// Example(2D,Med):  Red points are in the region.
//   region = [for(i=[2:4:10]) hexagon(r=i)];
//   color("#ff7") region(region);
//   for(x=[-10:10], y=[-10:10])
//     if (point_in_region([x,y], region)>=0)
//       move([x,y]) color("red") circle(0.15, $fn=12);
//     else
//       move([x,y]) color("#ddf") circle(0.1, $fn=12);
function point_in_region(point, region, eps=_EPSILON) =
    let(region=force_region(region))
    assert(is_region(region), "\nRegion given to point_in_region is not a region.")
    assert(is_vector(point,2), "\nPoint must be a 2D point in point_in_region.")
    _point_in_region(point, region, eps);

function _point_in_region(point, region, eps=_EPSILON, i=0, cnt=0) =
      i >= len(region) ? ((cnt%2==1)? 1 : -1)
    : let(
          pip = point_in_polygon(point, region[i], eps=eps)
      )
      pip == 0 ? 0
   : _point_in_region(point, region, eps=eps, i=i+1, cnt = cnt + (pip>0? 1 : 0));

/// Internal Function: _region_region_intersections()
/// Usage:
///    risect = _region_region_intersections(region1, region2, [closed1], [closed2], [eps]
/// Description:
///    Returns a pair of sorted lists such that risect[0] is a list of intersection
///    points for every path in region1, and similarly risect[1] is a list of intersection
///    points for the paths in region2.  For each path the intersection list is
///    a sorted list of the form [PATHIND, SEGMENT, U].  You can specify that the paths in either
///    region be regarded as open paths if desired.  Default is to treat them as
///    regions and hence the paths as closed polygons.
///    .
///    Included as intersection points are points where region1 touches itself at a vertex or
///    region2 touches itself at a vertex.  (The paths are assumed to have no self crossings.
///    Self crossings of the paths in the regions are not returned.)
function _region_region_intersections(region1, region2, closed1=true,closed2=true, eps=_EPSILON) =
   let(
       intersections =   [
           for(p1=idx(region1))
              let(
                  path = closed1?list_wrap(region1[p1]):region1[p1]
              )
              for(i = [0:1:len(path)-2])
                  let(
                      a1 = path[i],
                      a2 = path[i+1],
                      nrm = norm(a1-a2)
                  )
                  if( nrm>eps )  // ignore zero-length path edges
                       let( 
                           seg_normal = [-(a2-a1).y, (a2-a1).x]/nrm,
                           ref = a1*seg_normal
                       )
                           // `signs[j]` is the sign of the signed distance from
                           // poly vertex j to the line [a1,a2] where near zero
                           // distances are snapped to zero;  poly edges 
                           //  with equal signs at its vertices cannot intersect
                           // the path edge [a1,a2] or they are collinear and 
                           // further tests can be discarded.
                       for(p2=idx(region2))
                           let(
                               poly  = closed2?list_wrap(region2[p2]):region2[p2],
                               signs = [for(v=poly*seg_normal) abs(v-ref) < eps ? 0 : sign(v-ref) ]
                           ) 
                           if(max(signs)>=0 && min(signs)<=0) // some edge intersects line [a1,a2]
                               for(j=[0:1:len(poly)-2]) 
                                   if(signs[j]!=signs[j+1])
                                        let( // exclude non-crossing and collinear segments
                                            b1 = poly[j],
                                            b2 = poly[j+1],
                                            isect = _general_line_intersection([a1,a2],[b1,b2],eps=eps) 
                                        )
                                        if (isect 
                                            && isect[1]>= -eps 
                                            && isect[1]<= 1+eps 
                                            && isect[2]>= -eps
                                            && isect[2]<= 1+eps)       
                                         [[p1,i,isect[1]], [p2,j,isect[2]]]
         ],
         regions=[region1,region2],
         // Create a flattened index list corresponding to the points in region1 and region2
         // that gives each point as an intersection point
         ptind = [for(i=[0:1])   
                    [for(p=idx(regions[i]))
                       for(j=idx(regions[i][p])) [p,j,0]]],
         points = [for(i=[0:1]) flatten(regions[i])],
         // Corner points are those points where the region touches itself, hence duplicate
         // points in the region's point set
         cornerpts = [for(i=[0:1])
                         [for(k=vector_search(points[i],eps,points[i]))
                             each if (len(k)>1) select(ptind[i],k)]],
         risect = [for(i=[0:1]) concat(column(intersections,i), cornerpts[i])],
         counts = [count(len(region1)), count(len(region2))],
         pathind = [for(i=[0:1]) search(counts[i], risect[i], 0)]
       )
       [for(i=[0:1]) [for(j=counts[i]) _sort_vectors(select(risect[i],pathind[i][j]))]];

// Section: Breaking up regions into subregions


// Function: split_region_at_region_crossings()
// Synopsis: Splits {{regions}} where {{polygons}} touch and at intersections.
// Topics: Regions, Polygons, List Handling
// See Also: region_parts()
// 
// Usage:
//   split_region = split_region_at_region_crossings(region1, region2, [closed1], [closed2], [eps])
// Description:
//   Splits the {{region} `region1` at the places where its {{polygons}} touches each other at corners and at locations
//   where `region1` intersects `region2`.  Split `region2` similarly with respect to `region1`.
//   The return is a pair of results of the form [split1, split2] where split1=[frags1,frags2,...]
//   and frags1 is a list of paths that when placed end to end (in the given order), give the first polygon of region1.
//   Each path in the list is either entirely inside or entirely outside region2.  
//   Then frags2 is the decomposition of the second polygon into path pieces, and so on.  Finally split2 is
//   the same list, but for the polygons in region2.  
//   You can pass a single polygon in for either region, but the output will be a singleton list, as if
//   you passed in a singleton region.  If you set the closed parameters to false then the region components
//   are treated as open paths instead of polygons.  
// Arguments:
//   region1 = first region
//   region2 = second region
//   closed1 = if false then treat region1 as list of open paths.  Default: true
//   closed2 = if false then treat region2 as list of open paths.  Default: true
//   eps = Acceptable variance.  Default: 1e-9
// Example(2D): 
//   path = square(50,center=false);
//   region = [circle(d=80), circle(d=40)];
//   paths = split_region_at_region_crossings(path, region);
//   color("#aaa") region(region);
//   rainbow(paths[0][0]) stroke($item, width=2);
//   right(110){
//     color("#aaa") region([path]);
//     rainbow(flatten(paths[1])) stroke($item, width=2);
//   }
function split_region_at_region_crossings(region1, region2, closed1=true, closed2=true, eps=_EPSILON) = 
    let(
        region1=force_region(region1),
        region2=force_region(region2)
    )
    assert(is_region(region1) && is_region(region2),"\nOne of the inputs is not a region.")
    let(
        xings = _region_region_intersections(region1, region2, closed1, closed2, eps),
        regions = [region1,region2],
        closed = [closed1,closed2]
    )
    [for(i=[0:1])
      [for(p=idx(xings[i]))
        let(
            crossings = deduplicate([
                                     [p,0,0],
                                     each xings[i][p],
                                     [p,len(regions[i][p])-(closed[i]?1:2), 1],
                                    ],eps=eps),
            subpaths = [
                for (frag = pair(crossings)) 
                    deduplicate(
                        _path_select(regions[i][p], frag[0][1], frag[0][2], frag[1][1], frag[1][2], closed=closed[i]),
                        eps=eps
                    )
            ]
        )
        [for(s=subpaths) if (len(s)>1) s]
       ]
    ];

// Function: region_parts()
// Synopsis: Splits a {{region}} into a list of connected regions.
// SynTags: RegList
// Topics: Regions, List Handling
// See Also: split_region_at_region_crossings()
// Usage:
//   rgns = region_parts(region);
// Description:
//   Divides a {{region}} into a list of connected regions.  Each connected region has exactly one clockwise outside boundary
//   and zero or more counter-clockwise outlines defining internal holes. Behavior is undefined on invalid regions whose
//   components cross each other.
// Example(2D,NoAxes):
//   R = [for(i=[1:7]) square(i,center=true)];
//   region_list = region_parts(R);
//   rainbow(region_list) region($item);
// Example(2D,NoAxes):
//   R = [back(7,square(3,center=true)),
//        square([20,10],center=true),
//        left(5,square(8,center=true)),
//        for(i=[4:2:8])
//          right(5,square(i,center=true))];
//   region_list = region_parts(R);
//   rainbow(region_list) region($item);
function region_parts(region) =
   let(
       region = force_region(region)
   )
   assert(is_region(region), "\nInput is not a region.")
   let(
       inside = [for(i=idx(region))
                    let(pt = mean([region[i][0], region[i][1]]))
                    [for(j=idx(region))  i==j ? 0
                                       : point_in_polygon(pt,region[j]) >=0 ? 1 : 0]
                ],
       level = inside*repeat(1,len(region))
   )
   [ for(i=idx(region))
      if(level[i]%2==0)
         let(
             possible_children = search([level[i]+1],level,0)[0],
             keep=search([1], select(inside,possible_children), 0, i)[0]
         )
         [
           clockwise_polygon(region[i]),
           for(good=keep)
              ccw_polygon(region[possible_children[good]])
         ]
    ];

// Section: Offset and 2D Boolean Set Operations
function _offset_chamfer(center, points, delta) =
    is_undef(points[1])?
        let( points = select(points,[0,2]),
             center = mean(points),
             dir = sign(delta)*line_normal(points),
             halfside = tan(22.5)*abs(delta)
        )
        [ points[0]+dir*halfside,
          center + dir*abs(delta) + unit(points[0]-center)*halfside,
          center + dir*abs(delta) + unit(points[1]-center)*halfside, 
          points[1]+dir*halfside
        ]
    :
    let(
        dist = sign(delta)*norm(center-line_intersection(select(points,[0,2]), [center, points[1]])),
        endline = _shift_segment(select(points,[0,2]), delta-dist)
    ) [
        line_intersection(endline, select(points,[0,1])),
        line_intersection(endline, select(points,[1,2]))
    ];

function _shift_segment(segment, d) =
    assert(!approx(segment[0],segment[1]),"\nPath has repeated points.")
    move(d*line_normal(segment),segment);

// Extend to segments to their intersection point.  First check if the segments already have a point in common,
// which can happen if two colinear segments are input to the path variant of `offset()`
function _segment_extension(s1,s2) =
    norm(s1[1]-s2[0])<1e-6 ? s1[1] : line_intersection(s1,s2,LINE,LINE);

function _makefaces(direction, startind, good, pointcount, closed) =
    let(
        lenlist = list_bset(good, pointcount),
        numfirst = len(lenlist),
        numsecond = sum(lenlist),
        prelim_faces = _makefaces_recurse(startind, startind+len(lenlist), numfirst, numsecond, lenlist, closed)
    )
    direction? [for(entry=prelim_faces) reverse(entry)] : prelim_faces;

function _makefaces_recurse(startind1, startind2, numfirst, numsecond, lenlist, closed, firstind=0, secondind=0, faces=[]) =
    // We are done if *both* firstind and secondind reach their max value, which is the last point if !closed or one past
    // the last point if closed (wrapping around).  If you don't check both you can leave a triangular gap in the output.
    ((firstind == numfirst - (closed?0:1)) && (secondind == numsecond - (closed?0:1)))? faces :
    _makefaces_recurse(
        startind1, startind2, numfirst, numsecond, lenlist, closed, firstind+1, secondind+lenlist[firstind],
        lenlist[firstind]==0? (
            // point in original path has been deleted in offset path, so it has no match.  We therefore
            // make a triangular face using the current point from the offset (second) path
            // (The current point in the second path can be equal to numsecond if firstind is the last point)
            concat(faces,[[secondind%numsecond+startind2, firstind+startind1, (firstind+1)%numfirst+startind1]])
            // in this case a point or points exist in the offset path corresponding to the original path
        ) : (
            concat(faces,
                // First generate triangular faces for all of the extra points (if there are any---loop may be empty)
                [for(i=[0:1:lenlist[firstind]-2]) [firstind+startind1, secondind+i+1+startind2, secondind+i+startind2]],
                // Finish (unconditionally) with a quadrilateral face
                [
                    [
                        firstind+startind1,
                        (firstind+1)%numfirst+startind1,
                        (secondind+lenlist[firstind])%numsecond+startind2,
                        (secondind+lenlist[firstind]-1)%numsecond+startind2
                    ]
                ]
            )
        )
    );

// Determine which of the shifted segments are good
function _good_segments(path, d, shiftsegs, closed, quality) =
    let(
        maxind = len(path)-(closed ? 1 : 2),
        pathseg = [for(i=[0:maxind]) select(path,i+1)-path[i]],
        pathseg_len =  [for(seg=pathseg) norm(seg)],
        pathseg_unit = [for(i=[0:maxind]) pathseg[i]/pathseg_len[i]],
        // Order matters because as soon as a valid point is found, the test stops
        // This order works better for circular paths because they succeed in the center
        alpha = concat([for(i=[1:1:quality]) i/(quality+1)],[0,1])
    ) [
        for (i=[0:len(shiftsegs)-1])
            (i>maxind)? true :
            _segment_good(path,pathseg_unit,pathseg_len, d - 1e-7, shiftsegs[i], alpha)
    ];

// Determine if a segment is good (approximately)
// Input is the path, the path segments normalized to unit length, the length of each path segment
// the distance threshold, the segment to test, and the locations on the segment to test (normalized to [0,1])
// The last parameter, index, gives the current alpha index.
//
// A segment is good if any part of it is farther than distance d from the path.  The test is expensive, so
// we want to quit as soon as we find a point with distance > d, hence the recursive code structure.
//
// This test is approximate because it only samples the points listed in alpha.  Listing more points
// makes the test more accurate, but slower.
function _segment_good(path,pathseg_unit,pathseg_len, d, seg,alpha ,index=0) =
    index == len(alpha) ? false :
    _point_dist(path,pathseg_unit,pathseg_len, alpha[index]*seg[0]+(1-alpha[index])*seg[1]) > d ? true :
    _segment_good(path,pathseg_unit,pathseg_len,d,seg,alpha,index+1);

// Input is the path, the path segments normalized to unit length, the length of each path segment
// and a test point.  Computes the (minimum) distance from the path to the point, taking into
// account that the minimal distance may be anywhere along a path segment, not just at the ends.
function _point_dist(path,pathseg_unit,pathseg_len,pt) =
    min([
        for(i=[0:len(pathseg_unit)-1]) let(
            v = pt-path[i],
            projection = v*pathseg_unit[i],
            segdist = projection < 0? norm(pt-path[i]) :
                projection > pathseg_len[i]? norm(pt-select(path,i+1)) :
                norm(v-projection*pathseg_unit[i])
        ) segdist
    ]);

// Function: offset()
// Synopsis: Takes a 2D {{path}}, {{polygon}} or {{region}} and returns a path offset by an amount.
// SynTags: Path, Region, Ext
// Topics: Paths, Polygons, Regions
// Usage:
//   offsetpath = offset(path, [r=|delta=], [chamfer=], [closed=], [check_valid=], [quality=], [error=], [same_length=])
//   path_faces = offset(path, return_faces=true, [r=|delta=], [chamfer=], [closed=], [check_valid=], [quality=], [error=], [firstface_index=], [flip_faces=])
// Description:
//   This is documentation for the BOSL2 function form of `offset()`.  [Click Here for documentation for the builtin module.](https://github.com/BelfrySCAD/BelfrySCAD/wiki/Language-Transformations#offset)
//   .
//   Takes a 2D input {{path}}, {{polygon}} or {{region}} and returns a path offset by the specified amount.  As with the built-in
//   offset() module, you can use `r` to specify rounded offset and `delta` to specify offset with
//   corners.  If you used `delta` you can set `chamfer` to true to get chamfers.
//   When `closed=true` (the default), the input is treated as a polygon.  If the input is a region it is treated as a collection
//   of polygons.  In this case, positive offset values make the shape larger.  If you set `closed=false` then the input is treated as a path
//   with distinct start and end points.  For paths, positive offsets shifts the path to the left, relative to the direction of the path.
//   Note that a path that happens to end at its starting point is not the same as a polygon, and the offset result may differ at the ends.  
//   .
//   If you use `delta` without chamfers, the path must not include any 180 degree turns, where the path
//   reverses direction.  Such reversals result in an offset with two parallel segments, so they cannot be
//   extended to an intersection point.  If you select chamfering, the reversals are permitted and result
//   in a single segment connecting the parallel segments. With rounding, a semi-circle connects the two offset segments.
//   Note also that repeated points are always illegal in the input; remove them first with {{deduplicate()}}.  
//   .
//   When offsets shrink the path, segments cross and become invalid.  By default `offset()` checks
//   for this situation.  To test validity the code checks that segments have distance larger than (r
//   or delta) from the input path.  This check takes O(N^2) time and may mistakenly eliminate
//   segments you wanted included in various situations, so you can disable it if you wish by setting
//   check_valid=false.  When segments are mistakenly removed, you may get the wrong offset output, or you may
//   get an error, depending on the effect of removing the segment.  
//   The erroneous removal of segments is more common when your input
//   contains very small segments and in this case can result in an invalid situation where the remaining
//   valid segments are parallel and cannot be connected to form an offset curve.  If this happens, you
//   get an error message to this effect.  The only solutions are either to remove small segments with {{resample_path()}} or
//   generate your data with fewer points (e.g. by using a smaller `$fn` or larger `$fa` and `$fs` when constructing your input).
//   Be aware that chamfer and rounding increase the length of the path, so iterated offsets can lead to exponential
//   growth in the path length. 
//   .
//   Another situation that can arise with validity testing is that the test is not sufficiently thorough and some
//   segments persist that should be eliminated.  In this case, increase `quality` from its default of 1 to a value of 2 or 3.
//   This increases the number of samples on the segment that are checked, so it also increase run time.  In
//   some situations you may be able to decrease run time by setting quality to 0, which causes only
//   segment ends to be checked.  
//   .
//   When invalid segments are eliminated, the path length decreases, and multiple points on the input path map to the same point
//   on the offset path.  If you use chamfering or rounding, then
//   the chamfers and roundings increase the length of the output path.  Hence points in the output may be 
//   difficult to associate with the input.  If you want to maintain alignment between the points you
//   can use the `same_length` option.  This option requires that you use `delta=` with `chamfer=false` to ensure
//   that no points are added.  with `same_length`, when points collapse to a single point in the offset, the output includes
//   that point repeated to preserve the correct length.  Generally, repeated points do not appear in the offset output
//   unless you set `same_length=true`, but in some rare circumstances involving short segments, it is possible for the
//   repeated points to occur in the output, even when `same_length=false`.  
//   .
//   Another way to obtain alignment information is to use the return_faces option, which can
//   provide alignment information for all offset parameters: it returns a face list that lists faces between
//   the original path and the offset path where the vertices are ordered with the original path
//   first, starting at `firstface_index` and the offset path vertices appearing afterwords.  The
//   direction of the faces can be flipped using `flip_faces`.  When you request faces the return
//   value is a list: [offset_path, face_list].
// Arguments:
//   path = the path to process.  A list of 2d points.
//   ---
//   r = offset radius.  Distance to offset, rounds over corners.
//   delta = Distance to offset with pointed corners.
//   chamfer = Chamfer corners when you specify `delta`.  Default: false
//   closed = If true, path is treated as a polygon. Default: true
//   check_valid = Perform segment validity check.  Default: true
//   quality = Validity check quality parameter, a small integer.  Default: 1
//   error = If true, assert an error if offset path is degenerate. If false, return an empty list `[]` for a degenerate path. You must check the result yourself before passing it into another function. Default: true
//   same_length = Return a path with the same length as the input.  Only compatible with `delta=`.  Default: false
//   return_faces = Return face list.  Default: false
//   firstface_index = Starting index for face list.  Default: 0
//   flip_faces = Flip face direction.  Default: false
// Example(2D,NoAxes): Offset the red star out by 10 units.
//   star = star(5, r=100, ir=30);
//   stroke(closed=true, star, width=3, color="red");
//   stroke(closed=true, width=3,
//       offset(star, delta=10, closed=true));
// Example(2D,NoAxes):  Offset the star with chamfering
//   star = star(5, r=100, ir=30);
//   stroke(closed=true, star, width=3, color="red");
//   stroke(closed=true, width=3,
//          offset(star, delta=10, chamfer=true, closed=true));
// Example(2D,NoAxes):  Offset the star with rounding
//   star = star(5, r=100, ir=30);
//   stroke(closed=true, star, width=3, color="red");
//   stroke(closed=true, width=3,
//          offset(star, r=10, closed=true));
// Example(2D,NoAxes): Offset inward 
//   star = star(7, r=120, ir=50);
//   stroke(closed=true, width=3, star, color="red");
//   stroke(closed=true, width=3,
//          offset(star, delta=-15, closed=true));
// Example(2D,NoAxes): Inward offset with chamfers
//   star = star(7, r=120, ir=50);
//   stroke(closed=true, width=3, star, color="red");
//   stroke(closed=true, width=3,
//          offset(star, delta=-15, chamfer=true, closed=true));
// Example(2D,NoAxes):  Inward offset with rounding
//   star = star(7, r=120, ir=50);
//   stroke(closed=true, width=3, star, color="red");
//   stroke(closed=true, width=3,
//          offset(star, r=-15, closed=true, $fn=20));
// Example(2D): Open path.  The red path moves from left to right as shown by the arrow and the positive offset shifts to the left of the initial red path.
//   sinpath = 2*[for(theta=[-180:5:180]) [theta/4,45*sin(theta)]];
//   stroke(sinpath, width=2, color="red", endcap2="arrow2");
//   stroke(offset(sinpath, r=17.5,closed=false),width=2);
// Example(2D,NoAxes): An open path in red with with its positive offset in yellow and its negative offset in blue. 
//   seg = [[0,0],[0,50]];
//   stroke(seg,color="red",endcap2="arrow2"); 
//   stroke(offset(seg,r=15,closed=false));
//   stroke(offset(seg,r=-15,closed=false),color="blue");
// Example(2D,NoAxes): Offsetting the same line segment closed=true.  On the left, we use delta with chamfer=false, in the middle, chamfer=true, and on the right, rounding with r=.  A "closed" path here means that the path backtracks over itself.  When this happens, a flat end occurs in the first case, an end with chamfered corners if chamfering is on, or a semicircular rounding in the rounded case.  
//   seg = [[0,0],[0,50]];
//   stroke(seg,color="red"); 
//   stroke([offset(seg,delta=15,closed=true)]);
//   right(45){
//     stroke(seg,color="red");
//     stroke([offset(seg,delta=15,chamfer=true,closed=true)]);
//   }
//   right(90){
//     stroke(seg,color="red");
//     stroke([offset(seg,r=15,closed=true)]);
//   }
// Example(2D,NoAxes): Cutting a notch out of a square with a path reversal
//   path = [[-10,-10],[-10,10],[0,10],[0,0],[0,10],[10,10],[10,-10]];
//   stroke([path],width=.25,color="red");
//   stroke([offset(path, r=-2,$fn=32,closed=true)],width=.25);
// Example(2D,NoAxes): A more complex example where the path turns back on itself several times.  
//   $fn=32;
//   path = [
//           [0,0], [5,5],
//           [10,0],[5,5],
//           [11,8],[5,5],
//           [5,10],[5,5],
//           [-1,4],[5,5]
//           ];
//   op=offset(path, r=1.5,closed=true);
//   stroke([path],width=.1,color="red");
//   stroke([op],width=.1);
// Example(2D,NoAxes):  With the default quality value, this case produces the wrong answer.  This happens because the offset edge corresponding to the long left edge (shown in green) is erroneously flagged as invalid.  If you use `r=` instead of `delta=` then this fails with an error.  
//   test = [[0,0],[10,0],[10,7],[0,7], [-1,-3]];
//   polygon(offset(test,delta=-1.9, closed=true)); 
//   stroke([test],width=.1,color="red");
//   stroke(select(test,-2,-1), width=.1, color="green");
// Example(2D,NoAxes):  Using `quality=2` produces the correct result
//   test = [[0,0],[10,0],[10,7],[0,7], [-1,-3]];
//   polygon(offset(test,r=-1.9, closed=true, quality=2));   
//   stroke([test],width=.1,color="red");
// Example(2D,NoAxes): This case fails if `check_valid=true` when delta is large enough because segments are too close to the opposite side of the curve so they all get flagged as invalid and deleted from the output.  
//   star = star(5, r=22, ir=13);
//   stroke(star,width=.3,closed=true);                                                           
//   color("green")
//     stroke(offset(star, delta=-9, closed=true),width=.3,closed=true); // Works with check_valid=true (the default)
//   color("red")
//     stroke(offset(star, delta=-10, closed=true, check_valid=false),   // Fails if check_valid=true 
//            width=.3,closed=true); 
// Example(2D): But if you use rounding with offset then you need `check_valid=true` when `r` is big enough.  It works without the validity check as long as the offset shape retains a some of the straight edges at the star tip, but once the shape shrinks smaller than that, it fails.  There is no simple way to get a correct result for the case with `r=10`, because as in the previous example, it fails if you turn on validity checks.  
//   star = star(5, r=22, ir=13);
//   color("green")
//     stroke(offset(star, r=-8, closed=true,check_valid=false), width=.1, closed=true);
//   color("red")
//     stroke(offset(star, r=-10, closed=true,check_valid=false), width=.1, closed=true);
// Example(2D,NoAxes): The extra triangles in this example show that the validity check cannot be skipped
//   ellipse = scale([20,4], p=circle(r=1,$fn=64));
//   stroke(ellipse, closed=true, width=0.3);
//   stroke(offset(ellipse, r=-3, check_valid=false, closed=true),
//          width=0.3, closed=true);
// Example(2D,NoAxes): The triangles are removed by the validity check
//   ellipse = scale([20,4], p=circle(r=1,$fn=64));
//   stroke(ellipse, closed=true, width=0.3);
//   stroke(offset(ellipse, r=-3, check_valid=true, closed=true),
//          width=0.3, closed=true);
// Example(2D,NoAxes): The region shown in red has the yellow offset region. 
//   rgn = difference(circle(d=100),
//                    union(square([20,40], center=true),
//                          square([40,20], center=true)));
//   stroke(rgn, width=1, color="red");
//   region(offset(rgn, r=-5));
// Example(2D,NoAxes): Using `same_length=true` to align the original curve to the offset. Many points map to the corner at the top.
//   closed=false;
//   path = [for(angle=[0:5:180]) 10*[angle/100,2*sin(angle)]];
//   opath = offset(path,delta=-3,same_length=true,closed=closed);
//   stroke(path,closed=closed,width=.3);
//   stroke(opath,closed=closed,width=.3);
//   for(i=idx(path))
//       stroke([path[i],opath[i]],width=.3,color="red");
function offset(
    path, r=undef, delta=undef, chamfer=false,
    closed=true, check_valid=true,
    quality=1, error=true, return_faces=false, firstface_index=0,
    flip_faces=false, same_length=false, _reduce_output_count=false
) =
    assert(!(same_length && return_faces), "\nCannot combine return_faces with same_length.")
    is_region(path)?
        assert(closed, "\nCannot set closed=false for a region.")
        assert(!return_faces, "\nParameter return_faces is not supported for regions.")
        let(
            ofsregs = [for(R=region_parts(path))
                difference([for(i=idx(R)) offset(R[i], r=u_mul(i>0?-1:1,r), delta=u_mul(i>0?-1:1,delta),
                                      chamfer=chamfer, check_valid=check_valid, quality=quality,same_length=same_length,closed=true)])]
        )
        union(ofsregs)
    :
    let(rcount = num_defined([r,delta]))
    assert(rcount==1,"\nMust define exactly one of 'delta' and 'r'.")
    assert(!same_length || (is_def(delta) && !chamfer), "\nMust specify delta with chamfer=false, when same_length=true.")
    assert(is_path(path), "\nInput must be a path or region.")
    let(
        chamfer = is_def(r) ? false : chamfer,
        quality = max(0,round(quality)),
        flip_dir = closed && !is_polygon_clockwise(path)? -1 : 1,
        d = flip_dir * (is_def(r) ? r : delta)
    )
    d==0 && !return_faces ? path :
    let(
        shiftsegs = [for(i=[0:len(path)-2]) _shift_segment([path[i],path[i+1]], d),
                     if (closed) _shift_segment([last(path),path[0]],d)
                     else [path[0],path[1]]  // dummy segment, not used
                    ],
        // good segments are ones where no point on the segment is less than distance d from any point on the path
        good = check_valid ? _good_segments(path, abs(d), shiftsegs, closed, quality)
                           : repeat(true,len(shiftsegs)),
        goodsegs = bselect(shiftsegs, good),
        goodpath = bselect(path,good),
        degenerate = (len(goodsegs)-(!closed && select(good,-1)?1:0) <= 0)
    )
    assert(!(degenerate && error), "\nOffset of path is degenerate.")
    degenerate ? [] // return empty path
    : let(
        // Extend the shifted segments to their intersection points.  For open curves the endpoints
        // are simply the endpoints of the shifted segments.  If segments are parallel then the intersection
        // points will be undef
        sharpcorners = [for(i=[0:len(goodsegs)-1])
                             !closed && i==0 ? goodsegs[0][0]
                           : !closed && i==len(goodsegs)-1 ? goodsegs[len(goodsegs)-2][1]
                           : _segment_extension(select(goodsegs,i-1), select(goodsegs,i))],

        // true if sharpcorner has two parallel segments that go in the same direction 
        cornercheck = [for(i=idx(goodsegs)) (!closed && (i==0 || i==len(goodsegs)-1))
                                          || is_def(sharpcorners[i])
                                          || approx(unit(deltas(select(goodsegs,i-1))[0]) * unit(deltas(goodsegs[i])[0]),-1)],
        dummyA = assert(len(sharpcorners)==2 || all(cornercheck),
                    str("\nUnable to compute offset due to segments that are very close to parallel but not exactly parallel. \n",
                        "This is usually caused by too many points or points that are too close together. \n",
                        "Use fewer points (lower $fn, larger $fa/$fs) or use resample_path(). \n",
                        "If you get this error from offset_sweep() using offset=\"delta\" may help")),
        reversecheck = 
            !same_length 
              || !(is_def(delta) && !chamfer)            // Reversals only a problem in delta mode without chamfers
              || all_defined(sharpcorners),
        dummyB = assert(reversecheck, "\nEither validity check failed and removed a valid segment or the input 'path' contains a segment that reverses direction (180 deg turn). Path reversals are not allowed when same_length is true because they increase path length."),
        // This is a Boolean array that indicates whether a corner is an outside or inside corner
        // For outside corners, the new corner is an extension (angle 0), for inside corners, it turns backward (angle 180)
        // If either side turns back it is an inside corner---must check both.
        // Outside corners can get rounded (if r is specified and there is space to round them)
        // We flag endpoints of open paths as inside corners so that we don't try to round
        outsidecorner =
            len(sharpcorners)==2 ? [closed,closed]
          : [for(i=idx(goodsegs))
                !closed && (i==0 || i==len(goodsegs)-1) ? false  // endpoints of open path never get rounded
              : is_undef(sharpcorners[i]) ? true
              : let(prevseg=select(goodsegs,i-1))
                (goodsegs[i][1]-goodsegs[i][0]) * (goodsegs[i][0]-sharpcorners[i]) > 0
                  && (prevseg[1]-prevseg[0]) * (sharpcorners[i]-prevseg[1]) > 0
            ],
        steps = is_def(delta) ? undef
              : [
                 for(i=[0:len(goodsegs)-1])  
                    r==0 ? 0
                  : !closed && (i==0 || i==len(goodsegs)-1) ? 0    // We don't round ends of open paths
                     // floor is important here to ensure we don't generate extra segments when nearly straight paths expand outward
                  : let(vang = vector_angle(select(goodsegs,i-1)[1]-goodpath[i],
                                            goodsegs[i][0]-goodpath[i]))
                    assert(!outsidecorner[i] || vang!=0,    // If outsidecorner[i] is true then vang>0 needed to give valid step count
                           "\nOffset computation failed, probably because validity check mistakenly removed a valid segment.  Increasing quality might fix this.")
                    segs(r,vang)+(_reduce_output_count ? 0 : 1)
                ],
        // newcorners is a list where each entry is a list of the points that correspond to a single point in the sharpcorners 
        // list: newcorners[i] is the point list that replaces goodpath[i].  Without rounding or chamfering (or reversals),
        // this means each entry of newcorners is a singleton list.  But in the other cases, multiple points may appear at
        // a given position; newcorners later gets flattened to produce the final list, but the structure is needed to
        // establish point alignment for creating faces, or for duplicating points if same_length is true.  
        newcorners =
            [for(i=idx(goodsegs))
                 let(
                     basepts = [ select(goodsegs,i-1)[1], goodsegs[i][0] ]
                 )
                 is_def(sharpcorners[i]) &&
                   ((is_def(steps) && steps[i] <=1)  // Don't round if steps is smaller than 2
                     || !outsidecorner[i])           // Don't round inside corners
                ? [sharpcorners[i]]
                : chamfer ? _offset_chamfer(
                                  goodpath[i], [
                                      select(goodsegs,i-1)[1],
                                      sharpcorners[i],
                                      goodsegs[i][0]
                                  ], d
                              )
                : is_def(delta) ?
                      (
                         is_def(sharpcorners[i]) ? [sharpcorners[i]]
                       : let(normal = d*line_normal(basepts))
                         basepts + [normal,normal]
                      )
                : // rounded case
                  let(
                      class =_tri_class( [ each select(goodsegs,i-1), goodsegs[i][0]]),
                      cw = class==1,
                      ccw = class==-1
                  )
                  arc(cp=goodpath[i], cw=cw, ccw=ccw,
                      points=basepts,
                      n=steps[i])
              ],
        pointcount = [for(entry=newcorners) len(entry)],
        edges = flatten(newcorners),
        faces = !return_faces? []
              : _makefaces(
                           flip_faces, firstface_index, good,
                           pointcount, closed
                          ),
        final_edges = same_length ? select(edges,
                                           [0,
                                            each list_head(cumsum([for(g=good) g?1:0]))
                                           ]
                                    )
                                  : edges
    ) return_faces? [edges,faces] : final_edges;

/// Internal Function: _filter_region_parts()
///
/// splits region1 into subpaths where either it touches itself or crosses region2.  Classifies all of the
/// subpaths as described below and keeps the ones listed in keep1.  A similar process is performed for region2.
/// All of the kept subpaths are assembled into polygons and returned as a lst.
/// .
/// The four types of subpath from the region are defined relative to the second region:
///    "O" - the subpath is outside the second region
///    "I" - the subpath is in the second region's interior
///    "S" - the subpath is on the 2nd region's border and the two regions interiors are on the same side of the subpath
///    "U" - the subpath is on the 2nd region's border and the two regions meet at the subpath from opposite sides
/// You specify which type of subpaths to keep with a string of the desired types such as "OS".
function _filter_region_parts(region1, region2, keep, eps=_EPSILON) = 
    // We have to compute common vertices between paths in the region because
    // they can be places where the path must be cut, even though they aren't
    // found my the split_path function.  
    let(
        subpaths = split_region_at_region_crossings(region1,region2,eps=eps),
        regions=[force_region(region1),
                 force_region(region2)]
    )        
    _assemble_path_fragments(
        [for(i=[0:1])
           let(
               keepS = search("S",keep[i])!=[],
               keepU = search("U",keep[i])!=[],        
               keepoutside = search("O",keep[i]) !=[],
               keepinside = search("I",keep[i]) !=[],
               all_subpaths = flatten(subpaths[i])
           )
           for (subpath = all_subpaths)
               let(
                   midpt = mean([subpath[0], subpath[1]]),
                   rel = point_in_region(midpt,regions[1-i],eps=eps),
                   keepthis = rel<0 ? keepoutside
                            : rel>0 ? keepinside
                            : !(keepS || keepU) ? false
                            : let(
                                  sidept = midpt + 0.01*line_normal(subpath[0],subpath[1]),
                                  rel1 = point_in_region(sidept,regions[0],eps=eps)>0,
                                  rel2 = point_in_region(sidept,regions[1],eps=eps)>0
                              )
                              rel1==rel2 ? keepS : keepU
               )
               if (keepthis) subpath
        ]
    );

function _list_three(a,b,c) =
   is_undef(b) ? a : 
   [
     a,
     if (is_def(b)) b,
     if (is_def(c)) c
   ];

// Function&Module: union()
// Synopsis: Performs a Boolean union operation.
// SynTags: Geom, Region
// Topics: Boolean Operations, Regions, Polygons, Shapes2D, Shapes3D
// See Also: difference(), intersection(), diff(), intersect(), exclusive_or()
// Usage:
//   union() CHILDREN;
//   region = union(regions);
//   region = union(REGION1,REGION2);
//   region = union(REGION1,REGION2,REGION3);
// Description:
//   When called as a function and given a list of {{regions}} or 2D {{polygons}},
//   returns the union of all given regions and polygons.  Result is a single region.
//   When called as the built-in module, makes the union of the given children.
//   This function is **much** slower than the native union module acting on geometry,
//   so you should only use it when you need a point list for further processing.  
// Arguments:
//   regions = List of regions to union.
// Example(2D):
//   shape1 = move([-8,-8,0], p=circle(d=50));
//   shape2 = move([ 8, 8,0], p=circle(d=50));
//   color("green") region(union(shape1,shape2));
//   for (shape = [shape1,shape2])
//       stroke(shape, width=0.5, closed=true, color="red");
function union(regions=[],b=undef,c=undef,eps=_EPSILON) =
    let(regions=_list_three(regions,b,c))
    len(regions)==0? [] :
    len(regions)==1? regions[0] :
    let(regions=[for (r=regions) is_path(r)? [r] : r])
    union([
           _filter_region_parts(regions[0],regions[1],["OS", "O"], eps=eps),           
           for (i=[2:1:len(regions)-1]) regions[i]
          ],
          eps=eps
    );

// Function&Module: difference()
// Synopsis: Performs a Boolean difference operation.
// SynTags: Geom, Region
// Topics: Boolean Operations, Regions, Polygons, Shapes2D, Shapes3D
// See Also: union(), intersection(), diff(), intersect(), exclusive_or()
// Usage:
//   difference() CHILDREN;
//   region = difference(regions);
//   region = difference(REGION1,REGION2);
//   region = difference(REGION1,REGION2,REGION3);
// Description:
//   When called as a function, and given a list of {{regions}} or 2D {{polygons}}, 
//   takes the first region or polygon and differences away all other regions/polygons from it.  The resulting
//   region is returned.
//   When called as the built-in module, makes the set difference of the given children.
//   This function is **much** slower than the native difference module acting on geometry,
//   so you should only use it when you need a point list for further processing.  
// Arguments:
//   regions = List of regions or polygons to difference.
// Example(2D):
//   shape1 = move([-8,-8,0], p=circle(d=50));
//   shape2 = move([ 8, 8,0], p=circle(d=50));
//   for (shape = [shape1,shape2])
//       stroke(shape, width=0.5, color="red", closed=true);
//   color("green") region(difference(shape1,shape2));
function difference(regions=[],b=undef,c=undef,eps=_EPSILON) =
     let(regions = _list_three(regions,b,c))
     len(regions)==0? []
   : len(regions)==1? regions[0]
   : regions[0]==[] ? []
   : let(regions=[for (r=regions) is_path(r)? [r] : r])
     difference([
                 _filter_region_parts(regions[0],regions[1],["OU", "I"], eps=eps),                
                 for (i=[2:1:len(regions)-1]) regions[i]
                ],
                eps=eps
     );

// onescad: BOSL2/strings.scad
//////////////////////////////////////////////////////////////////////
// LibFile: strings.scad
//   String manipulation and formatting functions.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Data Management
// FileSummary: String manipulation functions.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

function _is_liststr(s) = is_list(s) || is_str(s);

// Section: Extracting substrings

// Function: substr()
// Synopsis: Returns a substring from a string.
// Topics: Strings
// See Also: suffix(), str_find(), substr_match(), starts_with(), ends_with(), str_split(), str_join(), str_strip()
// Usage:
//   newstr = substr(str, [pos], [len]);
// Description:
//   Returns a substring from a string start at position `pos` with length `len`, or
//   if `len` isn't given, the rest of the string.
// Arguments:
//   str = string to operate on
//   pos = starting index of substring, or vector of first and last position.  Default: 0
//   len = length of substring, or omit it to get the rest of the string.  If len is zero or less then the emptry string is returned.
// Example:
//   s1=substr("abcdefg",3,3);     // Returns "def"
//   s2=substr("abcdefg",2);       // Returns "cdefg"
//   s3=substr("abcdefg",len=3);   // Returns "abc"
//   s4=substr("abcdefg",[2,4]);   // Returns "cde"
//   s5=substr("abcdefg",len=-2);  // Returns ""
function substr(str, pos=0, len=undef) =
    assert(is_string(str))
    is_list(pos) ? _substr(str, pos[0], pos[1]-pos[0]+1) 
  : len == undef ? _substr(str, pos, len(str)-pos) 
                 : _substr(str,pos,len);

function _substr(str,pos,len) =
    assert(pos>=0,"\npos value for substr() must be nonnegative.")
    len <= 0 || pos>=len(str) ? ""
  :
    chr([for(i=[pos:pos+len-1]) ord(str[i])]);

// Section: String Searching


// Function: str_find()
// Synopsis: Finds a substring in a string.
// Topics: Strings
// See Also: suffix(), str_find(), substr_match(), starts_with(), ends_with(), str_split(), str_join(), str_strip()
// Usage:
//   ind = str_find(str,pattern,[last=],[all=],[start=]);
// Description:
//   Searches input string `str` for the string `pattern` and returns the index or indices of the matches in `str`.
//   By default `str_find()` returns the index of the first match in `str`.  If `last` is true then it returns the index of the last match.
//   If the pattern is the empty string the first match is at zero and the last match is the last character of the `str`.
//   If `start` is set then the search begins at index start, working either forward and backward from that position.  If you set `start`
//   and `last` is true then the search finds the pattern if it begins at index `start`. If no match exists, returns `undef`.
//   If you set `all` to true then `str_find()` returns all of the matches as a list, or an empty list if there are no matches.
// Arguments:
//   str = String to search.
//   pattern = string pattern to search for
//   ---
//   last = set to true to return the last match. Default: false
//   all = set to true to return all matches as a list.  Overrides last.  Default: false
//   start = index where the search starts
// Example:
//   a=str_find("abc123def123abc","123");   // Returns 3
//   b=str_find("abc123def123abc","b");     // Returns 1
//   c=str_find("abc123def123abc","1234");  // Returns undef
//   d=str_find("abc","");                  // Returns 0
//   e=str_find("abc123def123", "123", start=4);     // Returns 9
//   f=str_find("abc123def123abc","123",last=true);  // Returns 9
//   g=str_find("abc123def123abc","b",last=true);    // Returns 13
//   h=str_find("abc123def123abc","1234",last=true); // Returns undef
//   i=str_find("abc","",last=true);                 // Returns 3
//   j=str_find("abc123def123", "123", start=8, last=true);  // Returns 3
//   k=str_find("abc123def123abc","123",all=true);   // Returns [3,9]
//   l=str_find("abc123def123abc","b",all=true);     // Returns [1,13]
//   m=str_find("abc123def123abc","1234",all=true);  // Returns []
//   n=str_find("abc","",all=true);                  // Returns [0,1,2]
//   o=str_find("abd{{bz}}fij", "{{b}}", all=true);  // returns []
function str_find(str,pattern,start=undef,last=false,all=false) =
    assert(_is_liststr(str), "\nstr must be a string or list.")
    assert(_is_liststr(pattern), "\npattern must be a string or list.")
    all? _str_find_all(str,pattern) :
    let( start = first_defined([start,last?len(str)-len(pattern):0]) )
    pattern==""? start :
    last? _str_find_last(str,pattern,start) :
    _str_find_first(str,pattern,len(str)-len(pattern),start);

function _str_find_first(str,pattern,max_sindex,sindex) =
    sindex<=max_sindex && !substr_match(str,sindex, pattern)?
        _str_find_first(str,pattern,max_sindex,sindex+1) :
        (sindex <= max_sindex ? sindex : undef);

function _str_find_last(str,pattern,sindex) =
    sindex>=0 && !substr_match(str,sindex, pattern)?
        _str_find_last(str,pattern,sindex-1) :
        (sindex >=0 ? sindex : undef);

/*
function _str_find_all(str,pattern) =
    pattern == "" ? count(len(str)) :
    [for(i=[0:1:len(str)-len(pattern)]) if (substr_match(str,i,pattern)) i];
*/
/// More efficient _str_find_all, tested about 4X-7X faster than the version prior to September 2026.
/// Improves with less occurrences of pattern in str, or if first char of pattern is sparse in str.
function _str_find_all(str, pattern) =
    let(n = len(str), m = len(pattern))
    m == 0 ? count(n)
    : m > n ? [] : let( // get candidate test positions based on OpenSCAD search()
        candidates = search(pattern[0], str, num_returns_per_match=0)[0]
    ) is_undef(candidates) ? []
    : m==1 ? candidates
    : let(m1=m-1) [ for(p = candidates)
        if (str[p+m1] == pattern[m1]) // test last char in pattern before rest of pattern
            if(m==2 || _substr_match_recurse(str,p+1,pattern,m1,1)) p ];

// Function: substr_match()
// Synopsis: Returns true if the string `pattern` matches the string `str`.
// Topics: Strings
// See Also: suffix(), str_find(), substr_match(), starts_with(), ends_with(), str_split(), str_join(), str_strip()
// Usage
//   bool = substr_match(str,start,pattern);
// Description:
//   Returns true if the string `pattern` matches the string `str` starting
//   at `str[start]`.  If the string is too short for the pattern, or
//   `start` is out of bounds – either negative or beyond the end of the
//   string – then substr_match returns false.
// Arguments:
//   str = String to search
//   start = Starting index for search in str
//   pattern = String pattern to search for
// Example:
//   a=substr_match("abcde",2,"cd");   // Returns true
//   b=substr_match("abcde",2,"cx");   // Returns false
//   c=substr_match("abcde",2,"cdef"); // Returns false
//   d=substr_match("abcde",-2,"cd");  // Returns false
//   e=substr_match("abcde",19,"cd");  // Returns false
//   f=substr_match("abc",1,"");       // Returns true

//    This is carefully optimized for speed.  Precomputing the length
//    cuts run time in half when the string is long.  Two other string
//    comparison methods were slower.
function substr_match(str,start,pattern) =
     assert(_is_liststr(str), "\nstr must be a string or list.")
     assert(_is_liststr(pattern), "\npattern must be a string or list.")
     len(str)-start <len(pattern)? false
   : _substr_match_recurse(str,start,pattern,len(pattern));

function _substr_match_recurse(str,sindex,pattern,plen,pindex=0,) =
    pindex < plen && pattern[pindex]==str[sindex]
       ? _substr_match_recurse(str,sindex+1,pattern,plen,pindex+1)
       : (pindex==plen);

// Function: str_split()
// Synopsis: Splits a longer string wherever a given substring occurs.
// Topics: Strings
// See Also: suffix(), str_find(), substr_match(), starts_with(), ends_with(), str_split(), str_join(), str_strip()
// Usage:
//   string_list = str_split(str, sep, [keep_nulls]);
// Description:
//   Breaks an input string into substrings using a separator or list of separators.  If keep_nulls is true
//   then two sequential separator characters produce an empty string in the output list.  If keep_nulls is false
//   then no empty strings are included in the output list.
//   .
//   If sep is a single string then each character in sep is treated as a delimiting character and the input string is
//   split at every delimiting character.  Empty strings can occur whenever two delimiting characters are sequential.
//   If sep is a list of strings then the input string is split sequentially using each string from the list in order.
//   If keep_nulls is true then the output length is equal to `len(sep)+1`, possibly with trailing null strings
//   if the string runs out before the separator list.
// Arguments:
//   str = String to split.
//   sep = a string or list of strings to use for the separator
//   keep_nulls = boolean value indicating whether to keep null strings in the output list.  Default: true
// Example:
//   s1=str_split("abc+def-qrs*iop","*-+");     // Returns ["abc", "def", "qrs", "iop"]
//   s2=str_split("abc+*def---qrs**iop+","*-+");// Returns ["abc", "", "def", "", "", "qrs", "", "iop", ""]
//   s3=str_split("abc      def"," ");          // Returns ["abc", "", "", "", "", "", "def"]
//   s4=str_split("abc      def"," ",keep_nulls=false); // Returns ["abc", "def"]
//   s5=str_split("abc+def-qrs*iop",["+","-","*"]);     // Returns ["abc", "def", "qrs", "iop"]
//   s6=str_split("abc+def-qrs*iop",["-","+","*"]);     // Returns ["abc+def", "qrs*iop", "", ""]
function str_split(str,sep,keep_nulls=true) =
    !keep_nulls ? _remove_empty_strs(str_split(str,sep,keep_nulls=true)) :
    is_list(sep) ? _str_split_recurse(str,sep,i=0,result=[]) :
    let( cutpts = concat([-1],sort(flatten(search(sep, str,0))),[len(str)]))
    [for(i=[0:len(cutpts)-2]) substr(str,cutpts[i]+1,cutpts[i+1]-cutpts[i]-1)];

function _str_split_recurse(str,sep,i,result) =
    i == len(sep) ? concat(result,[str]) :
    let(
        pos = search(sep[i], str),
        end = pos==[] ? len(str) : pos[0]
    )
    _str_split_recurse(
        substr(str,end+1),
        sep, i+1,
        concat(result, [substr(str,0,end)])
    );

function _remove_empty_strs(list) =
    list_remove(list, search([""], list,0)[0]);

// Section: String modification


// Function: str_join()
// Synopsis: Joints a list of strings into a single string.
// Topics: Strings
// See Also: suffix(), str_find(), substr_match(), starts_with(), ends_with(), str_split(), str_join(), str_strip()
// Usage:
//   str = str_join(list, [sep]);
// Description:
//   Returns the concatenation of a list of strings, optionally with a
//   separator string inserted between each string on the list.
// Arguments:
//   list = list of strings to concatenate
//   sep = separator string to insert.  Default: ""
// Example:
//   s1=str_join(["abc","def","ghi"]);         // Returns "abcdefghi"
//   s2=str_join(["abc","def","ghi"], " + ");  // Returns "abc + def + ghi"
function str_join(list,sep="",_i=0, _result="") =
    assert(is_list(list))
    _i >= len(list)-1 ? (_i==len(list) ? _result : str(_result,list[_i])) :
    str_join(list,sep,_i+1,str(_result,list[_i],sep));

// onescad: BOSL2/vnf.scad
//////////////////////////////////////////////////////////////////////
// LibFile: vnf.scad
//   The Vertices'N'Faces structure (VNF) holds the data used by polyhedron() to construct objects: a vertex
//   list and a list of faces.  This library makes it easier to construct polyhedra by providing
//   functions to construct, merge, and modify VNF data, while avoiding common pitfalls such as
//   reversed faces.  It can find faults in your polyhedrons.  This file is for low level manipulation
//   of lists of vertices and faces: it can perform some simple transformations on VNF structures
//   but *cannot* perform boolean operations on the polyhedrons represented by VNFs.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Advanced Modeling
// FileSummary: Vertices 'n' Faces structure.  Makes polyhedron() easier to use.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: Creating Polyhedrons with VNF Structures
//   VNF stands for "Vertices'N'Faces".  VNF structures are 2-item lists, `[VERTICES,FACES]` where the
//   first item is a list of vertex points, and the second is a list of face indices into the vertex
//   list.  Each VNF is self contained, with face indices referring only to its own vertex list.
//   You can construct a `polyhedron()` in parts by describing each part in a self-contained VNF, then
//   merge the various VNFs to get the completed polyhedron vertex list and faces.

/// Constant: EMPTY_VNF
/// Description:
///   The empty VNF data structure.  Equal to `[[],[]]`.
EMPTY_VNF = [[],[]];

function vnf_vertex_array(
    points,
    caps, cap1, cap2,
    col_wrap=false,
    row_wrap=false,
    reverse=false,
    style="default",
    triangulate = false, return_edges=false, 
    texture, tex_reps, tex_size, tex_samples, tex_inset=false, tex_rot=0, tex_scaling="default",
    tex_depth=1, tex_extra, tex_skip, sidecaps,sidecap1,sidecap2, normals
) =
    assert(in_list(style,["default","alt","quincunx", "convex","concave", "max_edge", "min_edge","min_area","flip1","flip2","quad"]))
    assert(is_matrix(points[0], n=3),"\nPoint array has the wrong shape or points are not 3d.")
    assert(is_consistent(points), "\nNon-rectangular or invalid point array (vnf_tri_array() may work).")
    assert(is_bool(triangulate))
    is_def(texture) ?
          _textured_point_array(points=points, texture=texture, tex_reps=tex_reps, tex_size=tex_size,
                               tex_inset=tex_inset, tex_samples=tex_samples, tex_rot=tex_rot, tex_scaling=tex_scaling, return_edges=return_edges, 
                               col_wrap=col_wrap, row_wrap=row_wrap, tex_depth=tex_depth, caps=caps, cap1=cap1, cap2=cap2, reverse=reverse,
                               style=style, tex_extra=tex_extra, tex_skip=tex_skip, sidecaps=sidecaps, sidecap1=sidecap1, sidecap2=sidecap2,normals=normals,triangulate=triangulate)
  :
    assert(!(any([caps,cap1,cap2]) && !col_wrap), "\ncol_wrap must be true if caps are requested (without texture).")
    assert(!(any([caps,cap1,cap2]) && row_wrap), "\nCannot combine caps with row_wrap (without texture).")
    let(
        pts = flatten(points),
        pcnt = len(pts),
        rows = len(points),
        cols = len(points[0])
    )
    rows<=1 || cols<=1 ? EMPTY_VNF :
    let(
        cap1 = first_defined([cap1,caps,false]),
        cap2 = first_defined([cap2,caps,false]),
        colcnt = cols - (col_wrap?0:1),
        rowcnt = rows - (row_wrap?0:1),
        verts = [
            each pts,
            if (style=="quincunx")
                for (r = [0:1:rowcnt-1], c = [0:1:colcnt-1])
                   let(
                       i1 = ((r+0)%rows)*cols + ((c+0)%cols),
                       i2 = ((r+1)%rows)*cols + ((c+0)%cols),
                       i3 = ((r+1)%rows)*cols + ((c+1)%cols),
                       i4 = ((r+0)%rows)*cols + ((c+1)%cols)
                   )
                   mean([pts[i1], pts[i2], pts[i3], pts[i4]])
        ],
        allfaces = [
            if (cap1) count(cols,reverse=!reverse),
            if (cap2) count(cols,(rows-1)*cols, reverse=reverse),
            for (r = [0:1:rowcnt-1], c=[0:1:colcnt-1])
               each
               let(
                   i1 = ((r+0)%rows)*cols + ((c+0)%cols),
                   i2 = ((r+1)%rows)*cols + ((c+0)%cols),
                   i3 = ((r+1)%rows)*cols + ((c+1)%cols),
                   i4 = ((r+0)%rows)*cols + ((c+1)%cols),
                   faces =
                        style=="quincunx"?
                          let(i5 = pcnt + r*colcnt + c)
                          [[i1,i5,i2],[i2,i5,i3],[i3,i5,i4],[i4,i5,i1]]
                      : style=="min_area"?
                          let(
                               area42 = norm(cross(pts[i2]-pts[i1], pts[i4]-pts[i1]))+norm(cross(pts[i4]-pts[i3], pts[i2]-pts[i3])),
                               area13 = norm(cross(pts[i1]-pts[i4], pts[i3]-pts[i4]))+norm(cross(pts[i3]-pts[i2], pts[i1]-pts[i2])),
                               minarea_edge = area42 < area13 + _EPSILON
                                 ? [[i1,i4,i2],[i2,i4,i3]]
                                 : [[i1,i3,i2],[i1,i4,i3]]
                          )
                          minarea_edge
                      : style=="max_edge"?
                          let(
                               d42=norm(pts[i4]-pts[i2]),
                               d13=norm(pts[i1]-pts[i3]),
                               longedge = d42>d13-_EPSILON
                                 ? [[i1,i4,i2],[i2,i4,i3]]
                                 : [[i1,i3,i2],[i1,i4,i3]]
                          )
                          longedge
                      : style=="min_edge"?
                          let(
                               d42=norm(pts[i4]-pts[i2]),
                               d13=norm(pts[i1]-pts[i3]),
                               shortedge = d42<d13+_EPSILON
                                 ? [[i1,i4,i2],[i2,i4,i3]]
                                 : [[i1,i3,i2],[i1,i4,i3]]
                          )
                          shortedge
                      : style=="convex"?
                          let(   // Find normal for 3 of the points.  Is the other point above or below?
                              n = (reverse?-1:1)*cross(pts[i2]-pts[i1],pts[i3]-pts[i1]),
                              convexfaces = n==0
                                ? [[i1,i4,i3]]
                                : n*pts[i4] > n*pts[i1]
                                    ? [[i1,i4,i2],[i2,i4,i3]]
                                    : [[i1,i3,i2],[i1,i4,i3]]
                          )
                          convexfaces
                      : style=="concave"?
                          let(   // Find normal for 3 of the points.  Is the other point above or below?
                              n = (reverse?-1:1)*cross(pts[i2]-pts[i1],pts[i3]-pts[i1]),
                              concavefaces = n==0
                                ? [[i1,i4,i3]]
                                : n*pts[i4] <= n*pts[i1]
                                    ? [[i1,i4,i2],[i2,i4,i3]]
                                    : [[i1,i3,i2],[i1,i4,i3]]
                          )
                          concavefaces
                      : style=="quad" ? [[i1,i2,i3,i4]]
                      : style=="alt" || (style=="flip1" && ((r+c)%2==0)) || (style=="flip2" && ((r+c)%2==1)) || (style=="random" && rands(0,1,1)[0]<.5)?
                          [[i1,i4,i2],[i2,i4,i3]]
                      : [[i1,i3,i2],[i1,i4,i3]],
                   // remove degenerate faces
                   culled_faces= [for(face=faces)
                       if (norm(cross(verts[face[1]]-verts[face[0]],
                                      verts[face[2]]-verts[face[0]]))>_EPSILON)
                           face
                   ],
                   rfaces = reverse? [for (face=culled_faces) reverse(face)] : culled_faces
               )
               rfaces,
        ],
        vnf = [verts, allfaces],
        tvnf = triangulate? vnf_triangulate(vnf) : vnf
    )
    !return_edges ? tvnf
                  : [tvnf, [
                              if (!col_wrap) deduplicate(column(points,0)) else [],
                              if (!col_wrap) deduplicate(column(points, len(points[0])-1)) else [],
                              if (!cap1 && !row_wrap) deduplicate(points[0]) else [],
                              if (!cap2 && !row_wrap) deduplicate(last(points)) else []
                           ]
                    ];

function vnf_tri_array(
    points,
    caps, cap1, cap2,
    col_wrap=false,
    row_wrap=false,
    reverse=false,
    limit_bunching=true
) =
    assert(!(any([caps,cap1,cap2]) && row_wrap), "\nCannot combine caps with row_wrap.")
    let(
        plen = len(points),
        // append first vertex of each polygon to its end if wrapping columns
        st = col_wrap ? [
            for(i=[0:plen-1])
                points[i][0] != points[i][len(points[i])-1]
                    ? concat(points[i], [points[i][0]])
                    : points[i]
            ] : points,
        addcol = col_wrap ? len(st[0])-len(points[0]) : 0,
        rowstarts = [ for(i=[0:plen-1]) len(st[i]) ],
        capfirst = first_defined([cap1,caps,false]),
        caplast = first_defined([cap2,caps,false]),
        pcumlen = [0, each cumsum(rowstarts)],
        faces = [
            // close first end
            if (capfirst)
                if (reverse) [ for(i=[0:rowstarts[0]-1-addcol]) i ]
                else [ for(i=[rowstarts[0]-1-addcol:-1:0]) i ],
            // triangulate between the two polygons
            for(i = [0:plen-2+(row_wrap?1:0)])
                let(
                    j = (i+1)%plen,
                    max_extra_edges = limit_bunching ? max(1, abs(len(st[i])-len(st[j]))) : INF
                ) each _lofttri(st[i], st[j], pcumlen[i], pcumlen[j], rowstarts[i], rowstarts[j], reverse, trimax=max_extra_edges),
            // close up the last end
            if (caplast)
                if (reverse) [ for(i=[pcumlen[plen]-1-addcol:-1:pcumlen[plen-1]]) i ]
                else [ for(i=[pcumlen[plen-1]:pcumlen[plen]-1-addcol]) i ]
        ]
    ) [flatten(st), faces];

/*
Recursively triangulate between two 3D paths (which can be different
in length by any amount), starting at index 0 and generate a list of
triangles with minimum new-side length.
The first side of the first triangle always connects the two first
vertices of each path.
To triangulate between two closed paths, the first and last vertices
must be the same.
Parameters:
    p1 = first path, an array of [x,y,z] vertices
    p2 = second path, an array of [x,y,z] vertices
    i1offset = index offset of first vertex in the first path
        (sum of any prior path lengths)
    i2offset = index offset of first vertex in the second path
        (sum of any prior path lengths)
    n1 = number of vertices in first path
    n2 = number of vertices in second path
    reverse = if true, assume a polygon path goes around
        counterclockwise with respect to the direction from
        p1 to p2 (right hand rule), clockwise if false
Other parameters are for internal use:
    trilist[] = array of triangles to return
    i1 = vertex index on p1 of the next triangle
    i2 = vertex index on p2 of the next triangle
    tricount1 = number extra triangles generated on vertex i2 to row p1
    tricount2 = number extra triangles generated on vertex i1 to row p2
    trimax = max number of extra triangles that can be created on any point in a row
(next triangle vertex found can be on either p1 or p2, depending
on which triangle is smaller.)

Returns an array of triangles using vertex indices offset by
i1offset and i2offset
*/
function _lofttri(p1, p2, i1offset, i2offset, n1, n2, reverse=false, trilist=[], i1=0, i2=0, tricount1=0, tricount2=0, trimax=INF) = n1!=n2 ?
    // unequal row lengths
    let(
    t1 = i1 < n1 ? i1+1 : n1,   // test point 1
    t2 = i2 < n2 ? i2+1 : n2,   // test point 2
//dum=echo(str("i1=",i1,"  i2=",i2,"  t1=",t1,"  t2=",t2,"  n1=",n1,"  n2=",n2, "  p1[t1]=",p1[t1],"  p2[i2]=",p2[i2])),
    d12 = t2>=n2 ? 9e+9 : norm(p2[t2]-p1[i1]), // distance from i1 to t2
    d21 = t1>=n1 ? 9e+9 : norm(p1[t1]-p2[i2]), // distance from i2 to t1
//dum2=echo(str("  d12=",d12,"  d21=",d21,"  tricounts=",tricount1,",",tricount2)),
    userow = d12<d21 ? (tricount1<trimax ? 2 : 1) : (tricount2<trimax ? 1 : 2),
    newt = userow==1 ? (t1<n1?t1:i1) : (t2<n2?t2:i2),
    newofft = userow==2 ? i2offset+newt : i1offset+newt,
    tc1 = d12<d21 && tricount1<trimax ? tricount1+1 : 0,
    tc2 = d21<d12 && tricount2<trimax ? tricount2+1 : 0,
    triangle = reverse ?
        [i1offset+i1, i2offset+i2, newofft] :
        [i2offset+i2, i1offset+i1, newofft]
) t1>=n1 && t2>=n2 ? trilist :
    _lofttri(p1, p2, i1offset, i2offset, n1, n2, reverse, concat(trilist, [triangle]),
        userow==1 ? (t1>=n1?i1:t1) : i1, userow==2 ? (t2>=n2?i2:t2) : i2, tc1, tc2, trimax)

    : // equal row lengths
    let(n=n1, i=i1,
    t = i < n ? i+1 : n,   // test point
    d12 = t>=n ? 9e+9 : norm(p2[t]-p1[i]), // distance from p1 to new p2
    d21 = t>=n ? 9e+9 : norm(p1[t]-p2[i]), // distance from p2 to new p1
    triangle1 = reverse ?
        [i1offset+i, i2offset+i, d12<d21 ? i2offset+t : i1offset+t] :
        [i2offset+i, i1offset+i, d12<d21 ? i2offset+t : i1offset+t],
    triangle2 = reverse ?
        [i2offset+t, i1offset+t, d12<d21 ? i1offset+i : i2offset+i] :
        [i1offset+t, i2offset+t, d12<d21 ? i1offset+i : i2offset+i]
) t>=n ? trilist :
    _lofttri(p1, p2, i1offset, i2offset, n, n, reverse, concat(trilist, [triangle1, triangle2]), t, t, 0,0,trimax);

// Function: vnf_join()
// Synopsis: Returns a single VNF structure from a list of VNF structures.
// SynTags: VNF
// Topics: VNF Generators, Lists
// See Also: vnf_tri_array(), vnf_vertex_array(), vnf_from_polygons(), vnf_from_region()
// Usage:
//   vnf = vnf_join([VNF, VNF, VNF, ...]);
// Description:
//   Given a list of VNF structures, merges them all into a single VNF structure.
//   Combines all the points of the input VNFs and labels the faces appropriately.
//   All the points in the input VNFs appear in the output, even if they are
//   duplicated. It is valid to repeat points in a VNF, but if you
//   with to remove the duplicates that occur along joined edges, use {{vnf_merge_points()}}.
//   .
//   This is a tool for manipulating polyhedron data. It is for
//   building up a full polyhedron from partial polyhedra.
//   It is *not* a union operator for VNFs. The VNFs to be joined must not intersect each other,
//   except at edges, otherwise the result is an invalid polyhedron. Also, the
//   result must not have any other illegal polyhedron characteristics, such as creating
//   more than two faces sharing the same edge.
//   If you want a valid result it is your responsibility to ensure that the polyhedron
//   has no holes, no intersecting faces or edges, and obeys all the requirements
//   that CGAL expects.
//   .
//   For example, if you combine two pyramids to try to make an octahedron, the result is
//   invalid because of the two internal faces created by the pyramid bases.  A valid
//   use would be to build a cube missing one face and a pyramid missing its base and
//   then join them into a cube with a point.
// Arguments:
//   vnfs = a list of the VNFs to joint into one VNF.
// Example(3D,VPR=[60,0,26],VPD=55,VPT=[5.6,-5.3,9.8]): Here is a VNF where the top face is missing.  It is not a valid polyhedron like this, but we can use it as a building block to make a polyhedron.
//   bottom = vnf_vertex_array([path3d(rect(8)), path3d(rect(5),4)],col_wrap=true,cap1=true);
//   vnf_polyhedron(bottom);
// Example(3D,VPR=[60,0,26],VPD=55,VPT=[5.6,-5.3,9.8]): Here is a VNF that also has a missing face.
//   triangle = yrot(-90,path3d(regular_ngon(n=3,side=5,anchor=LEFT)));
//   top = up(4,vnf_vertex_array([list_set(right(2.5,triangle),0,[0,0,7]),
//                               right(6,triangle)
//                               ], col_wrap=true, cap2=true));
//   vnf_polyhedron(zrot(90,top));
// Example(3D,VPR=[60,0,26],VPD=55,VPT=[5.6,-5.3,9.8]): Using vnf_join combines the two VNFs into a single VNF.  Note that they share an edge.  But the result still isn't closed, so it is not yet a valid polyhedron.
//   bottom = vnf_vertex_array([path3d(rect(8)), path3d(rect(5),4)],col_wrap=true,cap1=true);
//   triangle = yrot(-90,path3d(regular_ngon(n=3,side=5,anchor=LEFT)));
//   top = up(4,vnf_vertex_array([list_set(right(2.5,triangle),0,[0,0,7]),
//                                right(6,triangle)
//                               ], col_wrap=true, cap2=true));
//   full = vnf_join([bottom,zrot(90,top)]);
//   vnf_polyhedron(full);
// Example(3D,VPR=[60,0,26],VPD=55,VPT=[5.6,-5.3,9.8]): If we add enough pieces, and the pieces are all consistent with each other, then we can arrive at a valid polyhedron like this one.  To be valid you need to meet all the CGAL requirements: every edge has exactly two faces, all faces are in clockwise order, no intersections of edges.
//   bottom = vnf_vertex_array([path3d(rect(8)), path3d(rect(5),4)],col_wrap=true,cap1=true);
//   triangle = yrot(-90,path3d(regular_ngon(n=3,side=5,anchor=LEFT)));
//   top = up(4,vnf_vertex_array([list_set(right(2.5,triangle),0,[0,0,7]),
//                                right(6,triangle)
//                               ], col_wrap=true, cap2=true));
//   full = vnf_join([bottom,
//                     for(theta=[0:90:359]) zrot(theta,top)
//                    ]);
//   vnf_polyhedron(full);
// Example(3D): The vnf_join function is not a union operator for polyhedra.  If any faces intersect, like they do in this example where we combine the faces of two cubes, the result is invalid and results in CGAL errors when you add more objects into the model.
//   cube1 = cube(5);
//   cube2 = move([2,2,2],cube1);
//   badvnf = vnf_join([cube1,cube2]);
//   vnf_polyhedron(badvnf);
//   right(2.5)up(3)color("red")
//         text3d("Invalid",size=1,anchor=CENTER,
//         orient=FRONT,h=.1);
function vnf_join(vnfs) =
    assert(is_vnf_list(vnfs) , "\nInput must be a list of VNFs.")
    len(vnfs)==1 ? vnfs[0]
    :
    let (
        offs  = cumsum([ 0, for (vnf = vnfs) len(vnf[0]) ]),
        verts = [for (vnf=vnfs) each vnf[0]],
        faces =
            [ for (i = idx(vnfs))
                let( faces = vnfs[i][1] )
                for (face = faces)
                    if ( len(face) >= 3 )
                        [ for (j = face)
                            assert( j>=0 && j<len(vnfs[i][0]),
                                    str("\nVNF number ", i, " has a face indexing an nonexistent vertex.") )
                            offs[i] + j ]
            ]
    )
    [verts,faces];

// Function: vnf_from_polygons()
// Synopsis: Returns a VNF from a list of 3D polygons.
// SynTags: VNF
// Topics: VNF Generators, Lists
// See Also: vnf_tri_array(), vnf_join(), vnf_vertex_array(), vnf_from_region()
// Usage:
//   vnf = vnf_from_polygons(polygons, [eps]);
// Description:
//   Given a list of 3D polygons, produces a VNF containing those polygons.
//   It is up to the caller to make sure that the points are in the correct order to make the face
//   normals point outward.  No checking for duplicate vertices is done.  If you want to
//   remove duplicate vertices use {{vnf_merge_points()}}.  Polygons with zero area are discarded from the face list by default.
//   If you give non-coplanar faces an error is displayed.  These checks increase run time by about 2x for triangular polygons, but
//   about 10x for pentagons; the checks can be disabled by setting fast=true.  
// Arguments:
//   polygons = The list of 3D polygons to turn into a VNF
//   fast = Set to true to skip area and coplanarity checks for increased speed.  Default: false
//   eps = Polygons with area smaller than this are discarded.  Default: 1e-9
// Example(3D,VPR=[60,0,40]): Construction of a dodecahedron from pentagon faces.
//   dihedral = 2*atan(PHI);   // dodecahedron face dihedral
//   rpenta = 10;              // pentagon face radius
//   edge = 2*rpenta*sin(36);  // edge length
//   inrad = 0.5*edge * PHI*PHI/sqrt(3-PHI);   // inner radius
//   face3d = path3d(pentagon(rpenta), inrad); // single face
//   facepoints = [
//       face3d,
//       for(a=[36:72:360]) zrot(a, yrot(180-dihedral, face3d)),
//       for(a=[36:72:360]) zrot(a, yrot(360-dihedral, face3d)),
//       yrot(180, face3d)
//   ];
//   vnf = vnf_from_polygons(facepoints, fast=true);
//   vnf_polyhedron(vnf);
function vnf_from_polygons(polygons,fast=false,eps=_EPSILON) =
   assert(is_list(polygons) && is_path(polygons[0]),"\nInput should be a list of polygons.")
   let(
       offs = cumsum([0, for(p=polygons) len(p)]),
       faces = [for(i=idx(polygons))
                  let(
                      area=fast ? 1 : polygon_area(polygons[i]),
                      dummy=assert(is_def(area) || is_collinear(polygons[i],eps=eps),str("\nPolygon ", i, " is not coplanar."))
                  )
                  if (is_def(area) && area > eps)
                    [for (j=idx(polygons[i])) offs[i]+j]
               ]
   )
   [flatten(polygons), faces];

/// Internal Function: _cleave_connected_region(region, eps)
/// Description:
///   Given a region that is connected and has its outer border in region[0],
///   produces a overlapping connected path to join internal holes to
///   the outer border without adding points. Output is a single non-simple polygon.
/// Requirements:
///   It expects that all region paths be simple closed paths, with region[0] CW and
///   the other paths CCW and encircled by region[0]. The input region paths are also
///   supposed to be disjoint except for common vertices and common edges but with
///   no crossings. It may return `undef` if these conditions are not met.
///   This function implements an extension of the algorithm discussed in:
///   https://www.geometrictools.com/Documentation/TriangulationByEarClipping.pdf
function _cleave_connected_region(region, eps=_EPSILON) =
    len(region)==1 ? region[0] :
    let(
        outer   = deduplicate(region[0]),             //
        holes   = [for(i=[1:1:len(region)-1])         // deduplication possibly unneeded
                      deduplicate( region[i] ) ],     //
        extridx = [for(li=holes) max_index(column(li,0)) ],
        // the right extreme vertex for each hole sorted by decreasing x values
        extremes = sort( [for(i=idx(holes)) [ i, extridx[i], -holes[i][extridx[i]].x] ], idx=2 )
    )
    _polyHoles(outer, holes, extremes, eps, 0);

// connect the hole paths one at a time to the outer path.
// 'extremes' is the list of the right extreme vertex of each hole sorted by decreasing abscissas
// see: _cleave_connected_region(region, eps)
function _polyHoles(outer, holes, extremes, eps=_EPSILON, n=0) =
    let(
        extr = extremes[n],    //
        hole = holes[extr[0]], // hole path to bridge to the outer path
        ipt  = extr[1],        // index of the hole point with maximum abscissa
        brdg = _bridge(hole[ipt], outer, eps)  // the index of a point in outer to bridge hole[ipt] to
    )
    brdg == undef ? undef :
    let(
        l  = len(outer),
        lh = len(hole),
        // the new outer polygon bridging the hole to the old outer
        npoly =
            approx(outer[brdg], hole[ipt], eps)
            ?   [ for(i=[brdg:  1: brdg+l])   outer[i%l] ,
                  for(i=[ipt+1: 1: ipt+lh-1]) hole[i%lh] ]
            :   [ for(i=[brdg:  1: brdg+l])   outer[i%l] ,
                  for(i=[ipt:   1: ipt+lh])   hole[i%lh] ]
    )
    n==len(holes)-1 ?  npoly :
    _polyHoles(npoly, holes, extremes, eps, n+1);

// find a point in outer to be connected to pt in the interior of outer
// by a segment that not cross or touch any non adjacente edge of outer.
// return the index of a vertex in the outer path where the bridge should end
// see _polyHoles(outer, holes, extremes, eps)
function _bridge(pt, outer,eps) =
    // find the intersection of a ray from pt to the right
    // with the boundary of the outer cycle
    let(
        l    = len(outer),
        crxs =
            let( edges = pair(outer,wrap=true) )
            [for( i = idx(edges) )
                let( edge = edges[i] )
                // consider just descending outer edges at right of pt crossing ordinate pt.y
                if(    (edge[0].y >  pt.y) //+eps)
                    && (edge[1].y <= pt.y)
                    && _is_at_left(pt, [edge[1], edge[0]], eps) )
                    [ i,
                      // the point of edge with ordinate pt.y
                      abs(pt.y-edge[1].y)<eps ? edge[1] :
                      let( u = (pt-edge[1]).y / (edge[0]-edge[1]).y )
                      (1-u)*edge[1] + u*edge[0]
                    ]
             ]
    )
    crxs == [] ? undef :
    let(
        // the intersection point of the nearest edge to pt with minimum slope
        minX    = min([for(p=crxs) p[1].x]),
        crxcand = [for(crx=crxs) if(crx[1].x < minX+eps) crx ], // nearest edges
        nearest = min_index([for(crx=crxcand)
                                (outer[crx[0]].x - pt.x) / (outer[crx[0]].y - pt.y) ]), // minimum slope
        proj    = crxcand[nearest],
        vert0   = outer[proj[0]],    // the two vertices of the nearest crossing edge
        vert1   = outer[(proj[0]+1)%l],
        isect   = proj[1]            // the intersection point
    )
    norm(pt-vert1) < eps ? (proj[0]+1)%l : // if pt touches an outer vertex, return its index
    // as vert0.y > pt.y then pt!=vert0
    norm(pt-isect) < eps ? undef :         // if pt touches the middle of an outer edge -> error
    let(
        // the edge [vert0, vert1] necessarily satisfies vert0.y > vert1.y
        // indices of candidates to an outer bridge point
        cand  =
            (vert0.x > pt.x)
            ?   [ proj[0],
                  // select reflex vertices inside of the triangle [pt, vert0, isect]
                  for(i=idx(outer))
                      if( _tri_class(select(outer,i-1,i+1),eps) <= 0
                          && _pt_in_tri(outer[i], [pt, vert0, isect], eps)>=0 )
                        i
                ]
            :   [ (proj[0]+1)%l,
                  // select reflex vertices inside of the triangle [pt, isect, vert1]
                  for(i=idx(outer))
                      if( _tri_class(select(outer,i-1,i+1),eps) <= 0
                          &&  _pt_in_tri(outer[i], [pt, isect, vert1], eps)>=0 )
                        i
                ],
        // choose the candidate outer[i] such that the line [pt, outer[i]] has minimum slope
        // among those with minimum slope choose the nearest to pt
        slopes  = [for(i=cand) 1-abs(outer[i].x-pt.x)/norm(outer[i]-pt) ],
        min_slp = min(slopes),
        cand2   = [for(i=idx(cand)) if(slopes[i]<=min_slp+eps) cand[i] ],
        nearest = min_index([for(i=cand2) norm(pt-outer[i]) ])
    )
    cand2[nearest];

// Function: vnf_from_region()
// Synopsis: Returns a 3D VNF given a 2D region.
// SynTags: VNF
// Topics: VNF Generators, Lists
// See Also: vnf_vertex_array(), vnf_tri_array(), vnf_join(), vnf_from_polygons()
// Usage:
//   vnf = vnf_from_region(region, [transform], [reverse]);
// Description:
//   Given a (two-dimensional) region, applies the given transformation matrix to it and makes a (three-dimensional) triangulated VNF of
//   faces for that region, reversed if desired.
// Arguments:
//   region = The region to convert to a VNF.
//   transform = If given, a transformation matrix to apply to the faces generated from the region. Default: No transformation applied.
//   reverse = If true, reverse the normals of the faces generated from the region. An untransformed region has face normals pointing `UP`. Default: false
// Example(3D):
//   region = [square([20,10],center=true),
//             right(5,square(4,center=true)),
//             left(5,square(6,center=true))];
//   vnf = vnf_from_region(region);
//   color("gray")down(.125)
//        linear_extrude(height=.125)region(region);
//   vnf_wireframe(vnf,width=.25);
function vnf_from_region(region, transform, reverse=false, triangulate=true) =
    let (
        region = [for (path = region) deduplicate(path, closed=true)],
        regions = region_parts(force_region(region)),
        vnfs =
            [
                for (rgn = regions)
                let(
                    cleaved = path3d(_cleave_connected_region(rgn))
                )
                assert( cleaved, "\nThe region is invalid.")
                let(
                    face = is_undef(transform)? cleaved : apply(transform,cleaved),
                    faceidxs = reverse? [for (i=[len(face)-1:-1:0]) i] : [for (i=[0:1:len(face)-1]) i]
                ) [face, [faceidxs]]
            ],
        outvnf = vnf_join(vnfs)
    )
    triangulate ? vnf_triangulate(outvnf) : outvnf;

// Section: VNF Testing and Access


// Function: is_vnf()
// Synopsis: Returns true given a VNF-like structure.
// Topics: VNF Manipulation
// See Also: is_vnf_list(), vnf_vertices(), vnf_faces()
// Usage:
//   bool = is_vnf(x);
// Description:
//   Returns true if the given value looks like a VNF structure.
function is_vnf(x) =
    is_list(x) &&
    len(x)==2 &&
    is_list(x[0]) &&
    is_list(x[1]) &&
    (x[0]==[] || (len(x[0])>=3 && is_vector(x[0][0],3))) &&
    (x[1]==[] || is_vector(x[1][0]));

// Function: is_vnf_list()
// Synopsis: Returns true given a list of VNF-like structures.
// Topics: VNF Manipulation
// See Also: is_vnf(), vnf_vertices(), vnf_faces()
//
// Description: Returns true if the given value looks passingly like a list of VNF structures.
function is_vnf_list(x) = is_list(x) && all([for (v=x) is_vnf(v)]);

// Section: Altering the VNF Internals


// Function: vnf_reverse_faces()
// Synopsis: Reverses the faces of a VNF.
// SynTags: VNF
// Topics: VNF Manipulation
// See Also: vnf_quantize(), vnf_merge_points(), vnf_drop_unused_points(), vnf_triangulate(), vnf_slice(), vnf_unify_faces() 
// Usage:
//   rvnf = vnf_reverse_faces(vnf);
// Description:
//   Reverses the orientation of all the faces in the given VNF.
function vnf_reverse_faces(vnf) =
    [vnf[0], [for (face=vnf[1]) reverse(face)]];

// Function: vnf_quantize()
// Synopsis: Quantizes the vertex coordinates of a VNF.
// SynTags: VNF
// Topics: VNF Manipulation
// See Also: vnf_reverse_faces(), vnf_merge_points(), vnf_drop_unused_points(), vnf_triangulate(), vnf_slice() 
// Usage:
//   vnf2 = vnf_quantize(vnf,[q]);
// Description:
//   Quantizes the vertex coordinates of the VNF to the given quanta `q`.
// Arguments:
//   vnf = The VNF to quantize.
//   q = The quanta to quantize the VNF coordinates to.
function vnf_quantize(vnf,q=pow(2,-12)) =
    [[for (pt = vnf[0]) quant(pt,q)], vnf[1]];

// Function: vnf_merge_points()
// Synopsis: Consolidates duplicate vertices of a VNF.
// SynTags: VNF
// Topics: VNF Manipulation
// See Also: vnf_reverse_faces(), vnf_quantize(), vnf_drop_unused_points(), vnf_triangulate(), vnf_slice(), vnf_unify_faces() 
// Usage:
//   new_vnf = vnf_merge_points(vnf, [eps]);
// Description:
//   Given a VNF, consolidates all duplicate vertices with a tolerance `eps`, relabeling the faces as necessary,
//   and eliminating any face with fewer than 3 vertices.  Unreferenced vertices of the input VNF are not dropped.
//   To remove such vertices uses {{vnf_drop_unused_points()}}.
// Arguments:
//   vnf = a VNF to consolidate
//   eps = the tolerance in finding duplicates. Default: 1e-9
function vnf_merge_points(vnf,eps=_EPSILON) =
    let(
        verts = vnf[0],
        dedup  = vector_search(verts,eps,verts),                 // collect vertex duplicates
        map    = [for(i=idx(verts)) min(dedup[i]) ],             // remap duplic vertices
        offset = cumsum([for(i=idx(verts)) map[i]==i ? 0 : 1 ]), // remaping face vertex offsets
        map2   = list(idx(verts))-offset,                        // map old vertex indices to new indices
        nverts = [for(i=idx(verts)) if(map[i]==i) verts[i] ],    // this doesn't eliminate unreferenced vertices
        nfaces =
            [ for(face=vnf[1])
                let(
                    nface = [ for(vi=face) map2[map[vi]] ],
                    dface = [for (i=idx(nface))
                                if( nface[i]!=nface[(i+1)%len(nface)])
                                    nface[i] ]
                )
                if(len(dface) >= 3) dface
            ]
    )
    [nverts, nfaces];

// Function: vnf_triangulate()
// Synopsis: Triangulates the faces of a VNF.
// SynTags: VNF
// Topics: VNF Manipulation
// See Also: vnf_reverse_faces(), vnf_quantize(), vnf_merge_points(), vnf_drop_unused_points(), vnf_slice(), vnf_unify_faces() 
// Usage:
//   vnf2 = vnf_triangulate(vnf);
// Description:
//   Triangulates faces in the VNF that have more than 3 vertices.
// Arguments:
//   vnf = VNF to triangulate
// Example(3D):
//   include <BOSL2/polyhedra.scad>
//   vnf = zrot(33,regular_polyhedron_info("vnf", "dodecahedron", side=12));
//   vnf_polyhedron(vnf);
//   triangulated = vnf_triangulate(vnf);
//   color("red")vnf_wireframe(triangulated,width=.3);
function vnf_triangulate(vnf) =
    let(
        verts = vnf[0],
        faces = [for (face=vnf[1])
                    each (len(face)==3 ? [face] :
                    let( tris = polygon_triangulate(verts, face) )
                    assert( tris!=undef, "\nSome VNF face cannot be triangulated.")
                    tris ) ]
    )
    [verts, faces];

// Function: vnf_slice()
// Synopsis: Slice the faces of a VNF along an axis.
// SynTags: VNF
// Topics: VNF Manipulation
// See Also: vnf_reverse_faces(), vnf_quantize(), vnf_merge_points(), vnf_drop_unused_points(), vnf_triangulate()
// Usage:
//   sliced = vnf_slice(vnf, dir, cuts);
// Description:
//   Slice the faces of a VNF along a specified axis direction at a given list of cut points.
//   The cut points can appear in any order.  You can use this to refine the faces of a VNF before
//   applying a nonlinear transformation to its vertex set.
// Arguments:
//   vnf = VNF to slice
//   dir = normal direction to the slices, either "X", "Y" or "Z"
//   cuts = X, Y or Z values where cuts occur
// Example(3D):
//   include <BOSL2/polyhedra.scad>
//   vnf = regular_polyhedron_info("vnf", "dodecahedron", side=12);
//   vnf_polyhedron(vnf);
//   sliced = vnf_slice(vnf, "X", [-6,-1,10]);
//   color("red")vnf_wireframe(sliced,width=.3);
function vnf_slice(vnf,dir,cuts) =
    let(
        //  Code below seems to be unnecessary
        //cuts = [for (cut=cuts) _shift_cut_plane(vnf,dir,cut)],
        vert = vnf[0],
        faces = [for(face=vnf[1]) select(vert,face)],
        poly_list = _slice_3dpolygons(faces, dir, cuts)
    )
    vnf_merge_points(vnf_from_polygons(poly_list));

function _split_polygon_at_x(poly, x) =
    let(
        xs = column(poly,0)
    ) (min(xs) >= x || max(xs) <= x)? [poly] :
    let(
        poly2 = [
            for (p = pair(poly,true)) each [
                p[0],
                if(
                    (p[0].x < x && p[1].x > x) ||
                    (p[1].x < x && p[0].x > x)
                ) let(
                    u = (x - p[0].x) / (p[1].x - p[0].x)
                ) [
                    x,  // Important for later exact match tests
                    u*(p[1].y-p[0].y)+p[0].y
                ]
            ]
        ],
        out1 = [for (p = poly2) if(p.x <= x) p],
        out2 = [for (p = poly2) if(p.x >= x) p],
        out3 = [
            if (len(out1)>=3 && polygon_area(out1)>_EPSILON) each split_path_at_self_crossings(out1),
            if (len(out2)>=3 && polygon_area(out2)>_EPSILON) each split_path_at_self_crossings(out2),
        ],
        out = [for (p=out3) if (len(p) > 2) list_unwrap(p)]
    ) out;

function _split_2dpolygons_at_each_x(polys, xs, _i=0) =
    _i>=len(xs)? polys :
    _split_2dpolygons_at_each_x(
        [
            for (poly = polys)
            each _split_polygon_at_x(poly, xs[_i])
        ], xs, _i=_i+1
    );

/// Internal Function: _slice_3dpolygons()
/// Usage:
///   splitpolys = _slice_3dpolygons(polys, dir, cuts);
/// Topics: Geometry, Polygons, Intersections
/// Description:
///   Given a list of 3D polygons, a choice of X, Y, or Z, and a cut list, `cuts`, splits all of the polygons where they cross
///   X/Y/Z at any value given in cuts.
/// Arguments:
///   polys = A list of 3D polygons to split.
///   dir_ind = slice direction, 0=X, 1=Y, or 2=Z
///   cuts = A list of scalar values for locating the cuts
function _slice_3dpolygons(polys, dir, cuts) =
    assert( [for (poly=polys) if (!is_path(poly,3)) 1] == [], "\nExpected list of 3D paths.")
    assert( is_vector(cuts), "\nThe split list must be a vector.")
    assert( in_list(dir, ["X", "Y", "Z"]))
    let(
        I = ident(3),
        dir_ind = ord(dir)-ord("X")
    )
    flatten([
        for (poly = polys)
            let(
                polyarea = polygon_area(poly),
                err=assert(!is_undef(polyarea), "\nvnf_slice encountered non-coplanar face.")
            )
            if (polyarea > _EPSILON)   // Discard zero area polygons
                let(
                    plane = plane_from_polygon(poly,1e-4),
                    err2 = assert(plane,"\nFound non-coplanar face."), // possibly redundant
                    normal = point3d(plane),
                    pnormal = normal - (normal*I[dir_ind])*I[dir_ind]
                )
                approx(pnormal,[0,0,0]) ? [poly]     // Polygons parallel to cut plane just pass through
                : let(
                    pind = max_index(v_abs(pnormal)),  // project along this direction
                    otherind = 3-pind-dir_ind,         // keep dir_ind and this direction
                    keep = [I[dir_ind], I[otherind]],  // dir ind becomes the x dir
                    poly2d = poly*transpose(keep),     // project to 2d, putting selected direction in the X position
                    poly_list = [
                        for(p=_split_2dpolygons_at_each_x([poly2d], cuts))
                            let(
                                a = p*keep,    // unproject, but pind dimension data is missing
                                ofs = outer_product((repeat(plane[3], len(a))-a*normal)/plane[pind],I[pind])
                            ) a+ofs
                    ]    // ofs computes the missing pind dimension data and adds it back in
                ) poly_list
    ]);

// Section: Turning a VNF into geometry


// Module: vnf_polyhedron()
// Synopsis: Returns a polyhedron from a VNF or list of VNFs.
// SynTags: Geom
// Topics: VNF Manipulation
// See Also: vnf_wireframe()
// Usage:
//   vnf_polyhedron(vnf) [ATTACHMENTS];
//   vnf_polyhedron([VNF, VNF, VNF, ...]) [ATTACHMENTS];
// Description:
//   Given a VNF structure, or a list of VNF structures, creates a polyhedron from them.
//   .
//   An arbitrary VNF may not have a geometry that matches well with the anchoring system.  The anchors are
//   automatically generated using one of two methods, the "hull" anchor type and the "intersect" anchor type.  
//   The "hull" method is the default.  It finds an anchor point on the convex hull of the shape.  It does this
//   by taking a plane normal to the anchor direction and and shifting it to the most distant point on the VNF.
//   This plane may intersect the VNF in one point, several points, or even a face.  If it intersects in a face
//   the anchor is the face centroid.  Otherwise the anchor is the mean of the vertices of VNF that intersect the
//   plane.  The anchor direction will be the direction you originally specified.  
//   .
//   The "intersect" method creates a ray based at the VNF center point that points in the anchor direction and
//   chooses the most distant intersection point as the anchor.  In this case, the anchor direction is
//   computed from the VNF geometry based on the face or edge where that intersection point lies.  
// Arguments:
//   vnf = A VNF structure, or list of VNF structures.
//   convexity = Max number of times a line could intersect a wall of the shape.
//   cp = Centerpoint for determining intersection anchors or centering the shape.  Determines the base of the anchor vector.  Can be "centroid", "mean", "box" or a 3D point.  Default: "centroid"
//   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `"origin"`
//   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
//   orient = Vector to rotate top toward, after spin. See [orient](attachments.scad#subsection-orient).  Default: `UP`
//   atype = Select "hull" or "intersect" anchor type.  Default: "hull"
// Anchor Types:
//   "hull" = Anchors to the virtual convex hull of the shape.
//   "intersect" = Anchors to the surface of the shape.
// Named Anchors:
//   "origin" = Anchor at the origin, oriented UP.
module vnf_polyhedron(vnf, convexity=2, cp="centroid", anchor="origin", spin=0, orient=UP, atype="hull") {
    vnf = is_vnf_list(vnf)? vnf_join(vnf) : vnf;
    assert(in_list(atype, _ANCHOR_TYPES), "\nAnchor type must be \"hull\" or \"intersect\".");
    attachable(anchor,spin,orient, vnf=vnf, extent=atype=="hull", cp=cp) {
        polyhedron(vnf[0], vnf[1], convexity=convexity);
        children();
    }
}

/// Internal Function: _vnf_centroid()
/// Usage:
///   vol = _vnf_centroid(vnf);
/// Description:
///   Returns the centroid of the given manifold VNF.  The VNF must describe a valid polyhedron with consistent face direction and
///   no holes; otherwise the results are undefined.

/// Divide the solid up into tetrahedra with the origin as one vertex.
/// The centroid of a tetrahedron is the average of its vertices.
/// The centroid of the total is the volume weighted average.
function _vnf_centroid(vnf,eps=_EPSILON) =
    assert(is_vnf(vnf) && len(vnf[0])!=0 && len(vnf[1])!=0,"\nInvalid or empty VNF given to centroid.")
    let(
        verts = vnf[0],
        pos = sum([
            for(face=vnf[1], j=[1:1:len(face)-2]) let(
                v0  = verts[face[0]],
                v1  = verts[face[j]],
                v2  = verts[face[j+1]],
                vol = cross(v2,v1)*v0
            )
            [ vol, (v0+v1+v2)*vol ]
        ])
    )
    assert(!approx(pos[0],0, eps), "\nThe vnf has self-intersections.")
    pos[1]/pos[0]/4;

// Given a single edge (pair of vertex indices) or list of them, find faces
// that contain that edge.  You must not supply two edges that could appear in
// the same face.  The use-case for more than one edge is when a single geometric edge
// has multiple representations in the VNF.  Return is a pair of face indices.
function _vnf_find_edge_faces(vnf,edge) =
  let(
      edge = unique(flatten(edge)),
      faces = vnf[1],
      goodind = [for(i=idx(faces))
                    let(result=flatten(search(edge,faces[i])))
                    if (result*0==[0,0] && 
                          (abs(result[0]-result[1])==1
                           || (min(result)==0 && max(result)==len(faces[i])-1)))
                       i
                ]
  )
  unique(goodind);

// Given a VNF and an index list of vertices, return all the
// faces (as indices into the face array) which include an item
// from the corner list.  The idea is that corner will hold all
// the indices that correspond to a single geometric point in
// the VNF and return just the faces for that single corner.
function _vnf_find_corner_faces(vnf,corner) =
  let(
      faces = vnf[1],
      corner = force_list(corner),
      nomatch = repeat([],len(corner))
  )
  unique([for(i=idx(faces))
     if (search(corner,faces[i])!=nomatch) i]);

// onescad: BOSL2/structs.scad
//////////////////////////////////////////////////////////////////////
// LibFile: structs.scad
//   This file provides manipulation of "structs".  A "struct" is a data structure that
//   associates arbitrary keys with values and allows you to get and set values
//   by key.
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Data Management
// FileSummary: Structure/Dictionary Manipulation
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Section: struct operations
//
// A struct is a data structure that associates keys with defined values.
// Structures are implemented as lists of [key, value] pairs.
//
// An empty list `[]` is an empty structure and can be used wherever a structure input is required.

// Function: struct_set()
// Synopsis: Sets one or more key-value pairs in a struct.
// Topics: Data Structures, Dictionaries
// See Also: struct_set(), struct_remove(), struct_val(), struct_keys(), echo_struct(), is_struct()
// Usage:
//   struct2 = struct_set(struct, key, value, [grow=]);
//   struct2 = struct_set(struct, [key1, value1, key2, value2, ...], [grow=]);
// Description:
//   Sets the key(s) in the structure to the specified value(s), returning a new updated structure.  If a
//   key exists its value is changed, otherwise the key is added to the structure.  If `grow=false` then
//   it is an error to set a key not already defined in the structure.  If you specify the same key twice
//   that is also an error.  Note that key order will change when you change a key's value.
// Arguments:
//   struct = input structure.
//   key = Key to set, or a flat alternating list `[key1,value1,key2,value2,...]`.
//   value = Value to store when giving a single key and value.
//   ---
//   grow = Set to true to allow structure to grow, or false for new keys to generate an error.  Default: true
// Example: Create a struct containing just one key-value pair
//   some_struct = struct_set([], "answer", 42);
//   // 'some_struct' now contains a single value, 42, under one key, "answer".
// Example: Create a struct containing more than one key-value pair. Note that keys and values need not be the same type.
//   some_struct = struct_set([], ["answer", 42, 2, "two", "quote", "What a nice day"]);
//   // 'some struct' now contains these key-value pairs:
//   // answer: 42
//   // 2: two
//   // quote: What a nice day
function struct_set(struct, key, value, grow=true) =
  is_def(value) ? struct_set(struct,[key,value],grow=grow)
  :
  assert(is_list(key) && len(key)%2==0, "[key,value] pair list is not a list or has an odd length")
  let(
      new_entries = [for(i=[0:1:len(key)/2-1]) [key[2*i], key[2*i+1]]],
      newkeys = column(new_entries,0),
      indlist = search(newkeys, struct,0,0),
      badkeys = grow ? (search([undef],new_entries,1,0)[0] != [] ? [undef] : [])
                     : [for(i=idx(indlist)) if (is_undef(newkeys[i]) || len(indlist[i])==0) newkeys[i]],
      ind = flatten(indlist),
      dupfind = search(newkeys, new_entries,0,0),
      dupkeys = [for(i=idx(dupfind)) if (len(dupfind[i])>1) newkeys[i]]
  )
  assert(badkeys==[], str("Unknown or bad key ",_format_key(badkeys[0])," in struct_set"))
  assert(dupkeys==[], str("Duplicate key ",_format_key(dupkeys[0])," for struct"))
  concat(list_remove(struct,ind), new_entries);

function _format_key(key) = is_string(key) ? str("\"",key,"\""): key;

// Function: struct_val()
// Synopsis: Returns the value for an key in a struct.
// Topics: Data Structures, Dictionaries
// See Also: struct_set(), struct_remove(), struct_val(), struct_keys(), echo_struct(), is_struct()
// Usage:
//   val = struct_val(struct, key, [default]);
// Description:
//   Returns the value for the specified key in the structure, or default value if the key is not present
// Arguments:
//   struct = input structure
//   key = key whose value to return
//   default = default value to return if key is not present.  Default: undef
function struct_val(struct, key, default=undef) =
    assert(is_def(key),"key is missing")
    let(ind = search([key],struct)[0])
    ind == [] ? default : struct[ind][1];

// onescad: BOSL2/rounding.scad
/////////////////////////////////////////////////////////////////////
// LibFile: rounding.scad
//   Routines to create rounded corners, with either circular rounding,
//   or continuous curvature rounding with no sudden curvature transitions.
//   Provides rounding of corners or rounding that preserves corner points and curves the edges.
//   Also provides some 3D rounding functions, and a powerful function for joining
//   two prisms together with a rounded fillet at the joint.  
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Advanced Modeling
// FileSummary: Round path corners, rounded prisms, rounded cutouts in tubes, filleted prism joints
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Computes the continuous curvature control points for a corner when given as
// input three points in a list defining the corner.  The points must be
// equidistant from each other to produce the continuous curvature result.
// The output control points include the 3 input points plus two
// interpolated points.
//
// k is the curvature parameter, ranging from 0 for slow transition
// up to 1 for a sharp transition that doesn't have continuous curvature any more
function _smooth_bez_fill(points,k) = [
        points[0],
        lerp(points[1],points[0],k),
        points[1],
        lerp(points[1],points[2],k),
        points[2],
];

// Computes the points of a continuous curvature roundover given as input
// the list of 3 points defining the corner and a parameter specification
//
// If parm is a scalar then it is treated as the curvature and the control
// points are calculated using _smooth_bez_fill.  Otherwise, parm is assumed
// to be a pair [d,k] where d is the length of the curve.  The length is
// calculated from the input point list and the control point list does not
// necessarily include points[0] or points[2] on its output.
//
// The number of points output is $fn if it is set.  Otherwise $fs is used
// to calculate the point count.
function _bezcorner(points, parm) =
        let(
                P = is_list(parm)?
                        let(
                                d = parm[0],
                                k = parm[1],
                                prev = unit(points[0]-points[1]),
                                next = unit(points[2]-points[1])
                        ) [
                                points[1]+d*prev,
                                points[1]+k*d*prev,
                                points[1],
                                points[1]+k*d*next,
                                points[1]+d*next
                        ] : _smooth_bez_fill(points,parm),
                N = max(3,$fn>0 ?$fn : ceil(bezier_length(P)/$fs))
        )
        bezier_curve(P,N,endpoint=true);

// Used by offset_sweep and convex_offset_extrude.
// Produce edge profile curve from the edge specification
// z_dir is the direction multiplier (1 to build up, -1 to build down)
function _rounding_offsets(edgespec,z_dir=1) =
        let(
                edgetype = struct_val(edgespec, "type"),
                extra = struct_val(edgespec,"extra"),
                N = struct_val(edgespec, "steps"),
                r = struct_val(edgespec,"r"),
                cut = struct_val(edgespec,"cut"),
                k = struct_val(edgespec,"k"),
                angle = struct_val(edgespec, "angle"), 
                radius = in_list(edgetype,["circle","teardrop"])
                            ? (is_def(cut) ? cut/(sqrt(2)-1) : r)
                         :edgetype=="chamfer"
                            ? (is_def(cut) ? sqrt(2)*cut : r)
                         : undef,
                chamf_angle = struct_val(edgespec, "angle"),
                cheight = struct_val(edgespec, "chamfer_height"),
                cwidth = struct_val(edgespec, "chamfer_width"),
                chamf_width = first_defined([!all_defined([cut,chamf_angle]) ? undef : cut/cos(chamf_angle),
                                             cwidth,
                                             !all_defined([cheight,chamf_angle]) ? undef : cheight*tan(chamf_angle)]),
                chamf_height = first_defined([
                                              !all_defined([cut,chamf_angle]) ? undef : cut/sin(chamf_angle),
                                              cheight,
                                              !all_defined([cwidth, chamf_angle]) ? undef : cwidth/tan(chamf_angle)]),
                joint = first_defined([
                        struct_val(edgespec,"joint"),
                        all_defined([cut,k]) ? 16*cut/sqrt(2)/(1+4*k) : undef
                ]),
                points = struct_val(edgespec, "points"),
                argsOK = in_list(edgetype,["circle","teardrop"])? is_def(radius) :
                        edgetype == "chamfer"? chamf_angle>0 && chamf_angle<90 && num_defined([chamf_height,chamf_width])==2 :
                        edgetype == "smooth"? num_defined([k,joint])==2 :
                        edgetype == "profile"? points[0]==[0,0] :
                        false
        )
        assert(argsOK,str("Invalid specification with type ",edgetype))
        let(
                offsets =
                        edgetype == "profile"? scale([-1,z_dir], p=list_tail(points)) :
                        edgetype == "chamfer"?  chamf_width==0 && chamf_height==0? [] : [[-chamf_width,z_dir*abs(chamf_height)]] :
                        edgetype == "teardrop"? (
                                radius==0? [] : concat(
                                        [for(i=[1:N]) [radius*(cos(i*45/N)-1),z_dir*abs(radius)* sin(i*45/N)]],
                                        [[-2*radius*(1-sqrt(2)/2), z_dir*abs(radius)]]
                                )
                        ) :
                        edgetype == "circle"? radius==0? [] : [for(i=[1:N]) [radius*(cos(i*angle/N)-1), z_dir*abs(radius)*sin(i*angle/N)]] :
                        /* smooth */ joint==0 ? [] :
                        list_tail(
                                _bezcorner([[0,0],[0,z_dir*abs(joint)],[-joint,z_dir*abs(joint)]], k, $fn=N+2)
                        )
        )
        quant(extra > 0 && len(offsets)>0 ? concat(offsets, [last(offsets)+[0,z_dir*extra]]) : offsets, 1/1024);

// This function does the actual work of repeatedly calling offset() and concatenating the resulting face and vertex lists to produce
// the inputs for the polyhedron module.
function _make_offset_polyhedron(path,offsets, offset_type, flip_faces, quality, check_valid, cap=true,
                                 offsetind=0, vertexcount=0, vertices=[], faces=[] )=
    offsetind==len(offsets)? 
        let(
            bottom = count(len(path),vertexcount),
            oriented_bottom = !flip_faces? bottom : reverse(bottom)
        )
        [
         vertices,
         [each faces,
          if (cap) oriented_bottom]
        ]
  :
        let(
            this_offset = offsetind==0? offsets[0][0] : offsets[offsetind][0] - offsets[offsetind-1][0],
            delta = offset_type=="delta" || offset_type=="chamfer" ? this_offset : undef,
            r = offset_type=="round"? this_offset : undef,
            do_chamfer = offset_type == "chamfer",
            vertices_faces = offset(
                    path, r=r, delta=delta, chamfer = do_chamfer, closed=true,
                    check_valid=check_valid, quality=quality,
                    return_faces=true,
                    firstface_index=vertexcount,
                    flip_faces=flip_faces, _reduce_output_count=true
            )
        )
        _make_offset_polyhedron(
                vertices_faces[0], offsets, offset_type,
                flip_faces, quality, check_valid, cap, 
                offsetind+1, vertexcount+len(path),
                vertices=concat(
                        vertices,
                        path3d(vertices_faces[0],offsets[offsetind][1])
                ),
                faces=concat(faces, vertices_faces[1])
        );

function _struct_valid(spec, func, name) =
        spec==[] ? true :
        assert(is_list(spec) && len(spec)>=2 && spec[0]=="for",str("Specification for \"", name, "\" is an invalid structure"))
        assert(spec[1]==func, str("Specification for \"",name,"\" is for a different function (",func,")"));

function offset_sweep(
                       path, height, 
                       bottom, top, 
                       h, l, length,
                       ends,bot,
                       offset="round", r=0, steps=16,
                       quality=1, check_valid=true,
                       extra=0, caps=true, 
                       cut=undef, chamfer_width=undef, chamfer_height=undef,
                       joint=undef, k=0.75, angle=45, anchor="base", orient=UP, spin=0,atype="hull", cp="centroid",
                       _return_height=false, _flipdir=false
                      ) =
    let(
        argspec = [
                   ["for",""],
                   ["r",r],
                   ["extra",extra],
                   ["type","circle"],
                   ["check_valid",check_valid],
                   ["quality",quality],
                   ["steps",steps],
                   ["offset",offset],
                   ["chamfer_width",chamfer_width],
                   ["chamfer_height",chamfer_height],
                   ["angle",angle],
                   ["cut",cut],
                   ["joint",joint],
                   ["k", k],
                   ["points", []],
        ],
        path = force_path(path)
    )
    assert(is_path(path,2), "Input path must be a 2D path")
    assert(is_bool(caps) || is_bool_list(caps,2), "caps must be boolean or a list of two booleans")
    let(
        caps = is_bool(caps) ? [caps,caps] : caps, 
        clockwise = is_polygon_clockwise(path),
        top_temp = one_defined([ends,top],"ends,top",dflt=[]),
        bottom_temp = one_defined([ends,bottom,bot],"ends,bottom,bot",dflt=[]),
        dummy1 = _struct_valid(top_temp,"offset_sweep","top"),
        dummy2 = _struct_valid(bottom_temp,"offset_sweep","bottom"),
        top = struct_set(argspec, top_temp, grow=false),
        bottom = struct_set(argspec, bottom_temp, grow=false),
        offsetsok = in_list(struct_val(top, "offset"),["round","delta","chamfer"])
                    && in_list(struct_val(bottom, "offset"),["round","delta","chamfer"])
    )
    assert(offsetsok,"Offsets must be one of \"round\", \"delta\", or \"chamfer\"")
    let(
        do_flip = _flipdir ? function(x) xflip(x) : function(x) x , 
        offsets_bot = do_flip(_rounding_offsets(bottom, -1)),
        offsets_top = do_flip(_rounding_offsets(top, 1)),
        dummy = (struct_val(top,"offset")=="chamfer" && len(offsets_top)>5)
                        || (struct_val(bottom,"offset")=="chamfer" && len(offsets_bot)>5)
                ? echo("WARNING: You have selected offset=\"chamfer\", which leads to exponential growth in the vertex count and requested more than 5 layers.  This can be slow or run out of recursion depth.")
                : 0,

        // "Extra" height enlarges the result beyond the requested height, so subtract it
        bottom_height = len(offsets_bot)==0 ? 0 : abs(last(offsets_bot)[1]) - struct_val(bottom,"extra"),
        top_height = len(offsets_top)==0 ? 0 : abs(last(offsets_top)[1]) - struct_val(top,"extra"),

        height = one_defined([l,h,height,length], "l,h,height,length", dflt=u_add(bottom_height,top_height)),
        dummy1 = assert(is_finite(height) && height>0, "Height must be positive"),
        middle = height-bottom_height-top_height,
        dummy2= assert(middle>=0, str("Specified end treatments (bottom height = ",bottom_height,
                                      " top_height = ",top_height,") are too large for extrusion height (",height,")")),
        initial_vertices_bot = path3d(path),

        vertices_faces_bot = _make_offset_polyhedron(
                path, offsets_bot, struct_val(bottom,"offset"), clockwise,
                struct_val(bottom,"quality"),
                struct_val(bottom,"check_valid"),
                caps[0], 
                vertices=initial_vertices_bot
        ),

        top_start_ind = len(vertices_faces_bot[0]),
        initial_vertices_top = path3d(path, middle),
        vertices_faces_top = _make_offset_polyhedron(
                path, move(p=offsets_top,[0,middle]),
                struct_val(top,"offset"), !clockwise,
                struct_val(top,"quality"),
                struct_val(top,"check_valid"),
                caps[1],
                vertexcount=top_start_ind,
                vertices=initial_vertices_top
        ),
        middle_faces = middle==0 ? [] : [
                for(i=[0:len(path)-1]) let(
                        oneface=[i, (i+1)%len(path), top_start_ind+(i+1)%len(path), top_start_ind+i]
                ) !clockwise ? reverse(oneface) : oneface
        ],
        vnf = [up(bottom_height-height/2, concat(vertices_faces_bot[0],vertices_faces_top[0])),  // Vertices
               concat(vertices_faces_bot[1], vertices_faces_top[1], middle_faces)],     // Faces
        anchors = [
          named_anchor("zcenter", [0,0,0], UP),
          named_anchor("base", [0,0,-height/2], UP),
          named_anchor("top", [0,0,height/2], UP)          
        ],
        final_vnf = in_list(atype,["hull","intersect"])
                  ? reorient(anchor,spin,orient, path=path, h=height, extent=atype=="hull", cp=cp, p=vnf, anchors=anchors)
                  : reorient(anchor,spin,orient, vnf=vnf, p=vnf, extent=atype=="surf_hull", cp=cp, anchors=anchors)
     ) _return_height ? [final_vnf,height] : final_vnf;

function os_circle(r,cut,h,height,clip_angle,extra,check_valid, quality,steps, offset) =
        assert(is_undef(clip_angle) || is_finite(clip_angle) && clip_angle>0 && clip_angle<=90, "clip angle must a number be in the interval (0,90]")
        let(
             h = one_defined([h,height],"h,height",dflt=undef),
             r_ang = is_def(clip_angle) ?
                         assert(num_defined([r,h,cut])==1, "When clip_angle is given must give exactly one of r, h/height, or cut")
                           is_def(r) ? [r,clip_angle]
                         : is_def(cut) ? [cut/(sqrt(2)-1),clip_angle]
                         : [h / sin(clip_angle),clip_angle]
                   :
                         assert(num_defined([r,cut])<=1, "Cannot give both r and cut")
                         let(
                              r = is_def(r) ? r
                                : is_def(cut) ?  cut/(sqrt(2)-1)
                                : undef
                         )
                         is_def(r) ? [r, is_def(h) ? assert(h<=r, "height cannot be larger than radius") asin(h/r) : 90]
                                   : [h, 90]
        )
        _remove_undefined_vals([
                "for", "offset_sweep",
                "type", "circle",
                "r",r_ang[0],
                "angle",r_ang[1],
                "extra",extra,
                "check_valid",check_valid,
                "quality", quality,
                "steps", steps,
                "offset", offset
        ]);

function _remove_undefined_vals(list) =
        let(ind=search([undef],list,0)[0])
        list_remove(list, concat(ind, add_scalar(ind,-1)));

// onescad: BOSL2/skin.scad
//////////////////////////////////////////////////////////////////////
// LibFile: skin.scad
//   This file provides functions and modules that construct shapes from a list of cross sections.
//   In the case of skin() you specify each cross sectional shape yourself, and the number of
//   points can vary.  The various forms of sweep use a fixed shape, which may follow a path, or
//   be transformed in other ways to produce the list of cross sections.  In all cases it is the
//   user's responsibility to avoid creating a self-intersecting shape, which will produce
//   cryptic CGAL errors.  This file was inspired by list-comprehension-demos skin():
//   - https://github.com/openscad/list-comprehension-demos/blob/master/skin.scad
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Advanced Modeling
// FileSummary: Construct 3D shapes from 2D cross sections of the desired shape.
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

__vnf_no_n_mesg=" texture is a VNF so it does not accept n. Set sample rate for VNF textures using the tex_samples parameter to cyl(), linear_sweep(), or rotate_sweep().";

// Function&Module: rotate_sweep()
// Synopsis: Create a surface of revolution from a path with optional texturing. 
// SynTags: VNF, Geom
// Topics: Extrusion, Sweep, Revolution, Textures
// See Also: linear_sweep(), sweep(), spiral_sweep(), path_sweep(), offset_sweep()
// Usage: As Function
//   vnf = rotate_sweep(shape, [angle], ...);
// Usage: As Module
//   rotate_sweep(shape, [angle], ...) [ATTACHMENTS];
// Usage: With Texturing
//   rotate_sweep(shape, texture=, [tex_size=]|[tex_reps=], [tex_depth=], [tex_samples=], [tex_rot=], [tex_inset=], ...) [ATTACHMENTS];
// Description:
//   Takes a path or [region](regions.scad) and sweeps it in a rotation around the Z axis, with optional texturing.
//   When called as a function, returns a [VNF](vnf.scad).
//   When called as a module, creates the sweep as geometry.  By default the sweep starts on the X+ axis.  For 360 degree sweeps this
//   may be inconsistent with the native rotate_extrude(), which historically started on the X- axis.  The `start` parameter changes where
//   the sweep starts; set it to 180 to get the historical rotate_extrude() behavior.  
//   .
//   The region or path that you provide to sweep is defined in the XY plane and cannot have any negative x values.  By default a path is treated as a closed shape.
//   (Regions are always composed of closed polygons.)  When you apply a texture, no path in your region can have more than one edge on the Y axis.  
//   If you give a path whose endpoints are not on the Y axis and specify `caps=true` then the path
//   endpoints are connected to the Y axis by a horizontal segment at each end, and the corresponding top and bottom surfaces in the revolution do not receive texture.
//   You can terminate just one end of the path on the Y axis and in this case, you get a single untextured cap.  If your texture is not zero at the
//   edges, the endcaps may appear textured rather than flat, because the top perimeter follows the texture.  
//   .
//   When `caps=true` you can use `tex_taper` to change the depth of the texture along the length of the path given in `shape`.  This
//   can be useful for forcing flat caps on a textured object by forcing the texture depth to zero at the ends.  
//   The simplest option is to set `tex_taper` to a value between 0 and 0.5.  In this case, the texture depth linearly falls to zero
//   at both ends, starting at the specified fraction from the end.  For example, if `tex_taper=1/3` then the center third of the object
//   will have the normal texture depth, and the texture falls to zero over the top and bottom thirds.  For more control over the texture
//   tapering you can also set `tex_taper` to a lookup table suited to the `lookup()` function.  The lookup table is evaluated at 0 to
//   determine the texture depth multiplier at the bottom and at 1 to determine the texture depth multiplier at the top.  The final option is
//   to set `tex_taper` to a function that takes one parameter and is defined on [0,1].  Using these more sophisticated methods you can actually
//   change the shape of the object.  If you want to ensure flat caps, simply make sure that your lookup table or function maps both zero and one to zero.
//   Texture multipliers can be any number.  If the multiplier is negative it inverts the texture, and if the multiplier exceeds one, the texture
//   scales to larger than your specified `tex_depth` value.  
//   .
//   If you want to place just one or a few copies of a texture onto an object rather than texturing the entire object you can do that by using
//   and angle smaller than 360.  However, if you want to control the aspect ratio of the resulting texture you must carefully calculate the proper
//   angle to use to ensure that the arc length in the horizontal direction is the proper length compared to the arc length in the vertical direction.
//   To simplify this process you can use `pixel_aspect` or `tex_aspect`.  You can set `tex_aspect` for any type of tile and it specifies
//   the desired aspect ratio (width/height) for the tiles.  You must specify `tex_reps` in order to use this feature.  For heightfields you can instead provide
//   a pixel aspect ratio, which is suited to the case where your texture is a non-square image that you want to place on a curved object.  For a simple cylinder
//   it is obvious what the horizontal arc length is; for other objects this is computed based on the average radius of the longest path in `shape`.  
// Arguments:
//   shape = The polygon or [region](regions.scad) to sweep around the Z axis.
//   angle = If given, specifies the number of degrees to sweep the region around the Z axis, counterclockwise from the X+ axis.  Default: 360 (full rotation)
//   ---
//   start = Start extrusion at this angle counterclockwise from the X+ axis.  Default:0
//   texture = A texture name string, or a rectangular array of scalar height values (0.0 to 1.0), or a VNF tile that defines the texture to apply to vertical surfaces.  See {{texture()}} for what named textures are supported.
//   tex_size = An optional 2D target size (2-vector or scalar) for the textures.  Actual texture sizes are scaled somewhat to evenly fit the available surface. Default: `[5,5]`
//   tex_reps = If given instead of tex_size, a scalar or 2-vector giving the integer number of texture tile repetitions in the horizontal and vertical directions.
//   tex_inset = If numeric, lowers the texture into the surface by the specified proportion, e.g. 0.5 would lower it half way into the surface.  If `true`, insets by exactly its full depth.  Default: `false`
//   tex_rot = Rotate texture by specified angle, which must be a multiple of 90 degrees.  Default: 0
//   tex_depth = Specify texture depth; if negative, invert the texture.  Default: 1.
//   tex_samples = Minimum number of "bend points" to have in VNF texture tiles.  Default: 8
//   tex_taper = If `caps=true`, scales the texture depth along the path given in `shape`.  If set to a scalar between 0 and 0.5, adjusts the specfied top and bottom fraction of the path linearly to zero depth.  You can also provide a lookup table or function defining the scala factor over the range [0,1].  Default: no taper
//   tex_aspect = Choose the angle of the revolution to maintain this aspect ratio for the tiles.  You must specify tex_reps.  Overrides any angle specified.  
//   pixel_aspect = Choose the angle of the revolution to maintain this apsect ratio for pixels in a heightfield texture.  You must specify tex_reps.  Overrides any angle specified.
//   style = {{vnf_vertex_array()}} style.  Default: "min_edge"
//   caps = If true and `shape` is a path whose endpoints are to the right of the Y axis, then adds untextured caps to the top and/or bottom of the revolved surface.  Ignored if `shape` is not a path or if its endpoints are on the Y axis.   Default: `false`
//   convexity = (Module only) Convexity setting for use with polyhedron.  Default: 10
//   cp = Centerpoint for determining "intersect" anchors or centering the shape.  Determintes the base of the anchor vector.  Can be "centroid", "mean", "box" or a 3D point.  Default: "centroid"
//   atype = Select "hull" or "intersect" anchor types.  Default: "hull"
//   anchor = Translate so anchor point is at the origin. Default: "origin"
//   spin = Rotate this many degrees around Z axis after anchor. Default: 0
//   orient = Vector to rotate top toward after spin (module only)
// Named Anchors:
//   "origin" = The native position of the shape.
//   "start-centroid" = (module only) When `angle<360`, the centroid of the shape, on the face at the starting face of the object
//   "end-centroid" = (module only) When `angle<360`, the centroid of the shape, on the face at the ending face of the object
// Anchor Types:
//   "hull" = Anchors to the virtual convex hull of the shape.
//   "intersect" = Anchors to the surface of the shape.
// Example(3D,NoAxes,VPR=[60.20,0.00,41.80],VPD=151.98,VPT=[0.85,-2.95,3.10]): Sweeping a shape that looks like a plus sign
//   rgn = right(30,
//           union([for (a = [0, 90])
//                    zrot(a, rect([15,5]))]));
//   rotate_sweep(rgn);
// Example(3D,NoAxes,VPR=[50.40,0.00,28.50],VPD=208.48,VPT=[0.23,-1.89,5.20]): Sweeping a region with multiple components
//   rgn = [
//       for (a = [0, 120, 240]) let(
//           cp = polar_to_xy(15, a) + [30,0]
//       ) each [
//           move(cp, p=circle(r=10)),
//           move(cp, p=hexagon(d=15)),
//       ]
//   ];
//   rotate_sweep(rgn, angle=240);
// Example(3D,NoAxes,VPR=[55.00,0.00,25.00],VPD=292.71,VPT=[1.59,1.80,-1.35]): Torus with bricks texture
//   path = right(50, p=circle(d=40));
//   rotate_sweep(path, texture="bricks_vnf",tex_size=10,
//                  tex_depth=0.5, style="concave");
// Example(3D,NoAxes,VPR=[76.30,0.00,44.60],VPD=257.38,VPT=[2.58,-5.21,0.37]): Applying a texture to a region.  Both the inside and outside receive texture.
//   rgn = [
//       right(40, p=circle(d=50)),
//       right(40, p=circle(d=40,$fn=6)),
//   ];
//   rotate_sweep(
//       rgn, texture="diamonds",
//       tex_size=[10,10], tex_depth=1,
//       angle=240, style="concave");
// Example(NoAxes): The simplest way to create a cylinder with just a single line segment and `caps=true`.  With this cylinder, the top and bottom have no texture.  
//   rotate_sweep([[20,-10],[20,10]], texture="dots",
//                tex_reps=[6,2],caps=true);
// Example(NoAxes): If we manually connect the top and bottom then they also receive texture.  
//   rotate_sweep([[0,-10],[20,-10],[20,10],[0,10]], 
//                tex_reps=[6,6],tex_depth=1.5,
//                texture="dots");
// Example(NoAxes,VPR=[95.60,0.00,69.80],VPD=74.40,VPT=[5.81,5.74,1.97]): You can connect just the top or bottom alone instead of both to get texture on one and a flat cap on the other.  Here you can see that the sloped top has texture but the bottom does not.  Also, the texture doesn't fit neatly on the side and top like it did in the previous two examples, but makes a somewhat ugly transition across the corner.  You have to size your object carefully so that the tops and sides each fit an integer number of texture tiles to avoid this type of transition.  
//   rotate_sweep([[15,-10],[15,10],[0,15]],
//                texture="dots", tex_reps=[6,6],
//                angle=90,caps=true,tex_depth=1.5);
// Example(NoAxes,VPR=[55.00,0.00,25.00],VPD=126.00,VPT=[1.37,0.06,-0.75]): Ribbed sphere. 
//   path = arc(r=20, $fn=64, angle=[-90, 90]);
//   rotate_sweep(path, 360, texture = texture("wave_ribs",n=15),
//                tex_size=[8,1.5]);
// Example(3D,NoAxes,VPR=[60.20,0.00,56.50],VPD=231.64,VPT=[4.18,-2.66,1.31]): This model uses `caps=true` to create the untextured caps with a user supplied texture.  They are flat because the texture is zero at its edges.
//   tex = [
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//       [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
//       [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
//       [0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1],
//       [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1],
//       [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1],
//       [0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
//       [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//   ];
//   path = arc(cp=[0,0], r=40, start=60, angle=-120);
//   rotate_sweep(
//       path, caps=true, 
//       texture=tex, tex_size=[20,20],
//       tex_depth=1, style="concave");
// Example(3D,NoAxes,VPR=[60.20,0.00,56.50],VPD=187.63,VPT=[2.07,-4.53,2.58]):  An example with a more complicated path.  Here the caps are not flat because the diamonds texture is not zero at the edges.  
//   bezpath = [
//       [15, 30], [10,15],
//       [10,  0], [20, 10], [30,12],
//       [30,-12], [20,-10], [10, 0],
//       [10,-15], [15,-30]
//   ];
//   path = bezpath_curve(bezpath, splinesteps=32);
//   rotate_sweep(
//       path, caps=true, 
//       texture="diamonds", tex_size=[10,10],
//       tex_depth=1, style="concave");
// Example(3D,NoAxes,VPR=[70.00,0.00,58.60],VPD=208.48,VPT=[1.92,-3.81,2.21]): The normal direction at the ends is perpendicular to the Z axis, so even though the texture is not zero, the caps are flat, unlike the previous example.
//   path = [
//       [20, 30], [20, 20],
//       each arc(r=20, corner=[[20,20],[10,0],[20,-20]]),
//       [20,-20], [20,-30],
//   ];
//   rotate_sweep(
//       path, caps=true, 
//       texture="diamonds",
//       tex_size=[5,5], tex_depth=1,
//       style="concave",
//       convexity=10);
// Example(3D,NoAxes,VPR=[59.20,0.00,226.90],VPD=113.40,VPT=[-4.53,3.03,3.84]): The top cap is definitely not flat.  
//   rotate_sweep(
//       arc(r=20,angle=[-45,45],n=45),
//       caps=true, texture="diamonds",
//       tex_size=[5,5], tex_depth=2,
//       convexity=10);
// Example(3D,NoAxes,VPR=[59.20,0.00,226.90],VPD=113.40,VPT=[-4.53,3.03,3.84]): Setting `tex_taper=0` abruptly tapers right at the caps so that the cap is flat:
//   rotate_sweep(
//       arc(r=20,angle=[-45,45],n=45),
//       caps=true, texture="diamonds",
//       tex_size=[5,5], tex_depth=2,
//       tex_taper=0, convexity=10);
// Example(3D,NoAxes,VPR=[59.20,0.00,226.90],VPD=113.40,VPT=[-4.53,3.03,3.84]): Setting `tex_taper=0.5` tapers gradually across the entire shape:
//   rotate_sweep(
//       arc(r=20,angle=[-45,45],n=45),
//       caps=true, texture="diamonds",
//       tex_size=[5,5], tex_depth=2,
//       tex_taper=.5, convexity=10);
// Example(3D,VPR=[59.20,0.00,91.10],VPD=126.00,VPT=[4.29,2.29,2.31],NoAxes): The path given here starts and ends on the Y axis, but you can still request (zero size) caps so that you can use tapering, which is permitted only when caps are enabled.  
//   rotate_sweep(
//      arc(r=20, angle=[-90,90], n=45), texture="dots",
//      caps=true, tex_reps=[15,10], tex_taper=0.5, tex_depth=2);
// Example(3D, NoAxes): Tapering of textures via lookup table to be maximal at the bottom and 0 at the top.  
//   path = [
//       [20, 30], [20, 20],
//       each arc(r=20, corner=[[20,20],[10,0],[20,-20]]),
//       [20,-20], [20,-30],
//   ];
//   rotate_sweep(
//       path, caps=true, 
//       texture="trunc_pyramids",
//       tex_size=[5,5], tex_depth=1,
//       tex_taper=[[0,1], [1,0]],
//       style="convex",
//       convexity=10);
// Example(3D,NoAxes,VPR=[106.10,0.00,158.30],VPD=155.56,VPT=[-2.68,-0.92,1.07]): Here we use a cosine function (lifted so it stays nonnegative) to scale the texture.  Since the taper function rises as high as 2 the effective texture depth is 4 at the peaks.
//   rotate_sweep([[20,-20],[20,20]],texture="trunc_diamonds",
//                caps=true, tex_reps=[20,16], tex_depth=2,
//                tex_taper=function(x) 1-cos(360*3*x));
// Example(3D,NoAxes,VPR=[83.70,0.00,195.40],VPD=82.67,VPT=[-1.69,4.43,0.46]): Here we use a sine function that goes below zero in the top half of the object.  This inverts the texture and the result is that the inverted texture bulges outward with the change in the texture depth that the taper applies.  In the bottom section, the scaling applies directly.  
//   rotate_sweep([[10,-12],[10,12]], caps=true, tex_reps=[16,6],
//                tex_taper=function(x) sin(360*x),tex_depth=2,
//                texture="dots");
// Example(3D,NoAxes,VPR=[83.70,0.00,195.40],VPD=82.67,VPT=[-1.69,4.43,0.46]): We adjust the VNF texture from the previous example so its "zero" level is at 1/2.  This makes the result symmetric between the positive and negative taperings.  
//      tex = up(1/2,zscale(1/2,texture("dots")));
//      rotate_sweep([[10,-12],[10,12]], caps=true, tex_reps=[16,6],
//                   tex_taper=function(x) sin(360*x),tex_depth=2,
//                   texture=tex);
// Example(3D,NoAxes,VPR=[72.50,0.00,119.10],VPD=155.56,VPT=[7.95,8.65,3.01]): Here we create a texture effect entirely with tapering using a constant "texture" of 3/4.  The inverted texture is 1-3/4 = 1/4, so the negative regions of the function create shallower bands.  
//    rotate_sweep([[20,-20],[20,20]], caps=true, tex_reps=[30,45], texture=[[3/4]],
//                 tex_taper=function(x) sin(2.5*360*x),tex_depth=4);
// Example(3D,NoAxes,Med,VPT=[-2.92656,1.26781,0.102897],VPR=[62.7,0,222.4],VPD=216.381): This VNF tile makes a closed shape and the actual main extrusion is not created.  We give `caps=true` to prevent the shape from being closed on the outside, but because the VNF tile has no edges, no actual cap is created.  
//   shape = skin([rect(2/5),
//                 rect(2/3),
//                 rect(2/5)],
//                z=[0,1/2,1],
//                slices=0,
//                caps=false);
//   tile = move([0,1/2,2/3],yrot(90,shape));
//   path = [for(y=[-30:30]) [ 20-3*(1-cos((y+30)/60*360)),y]];
//   rotate_sweep(path, caps=false, texture=tile, 
//                tex_size=[10,10], tex_depth=5);
// Example(3D,Med,VPT=[1.04269,4.35278,-0.716624],VPR=[98.4,0,43.9],VPD=175.268): Adding the angle parameter cuts off the extrusion.  Note how each extruded component is capped.  
//   shape = skin([rect(2/5),
//                 rect(2/3),
//                 rect(2/5)],
//                z=[0,1/2,1],
//                slices=0,
//                caps=false);
//   tile = move([0,1/2,2/3],yrot(90,shape));
//   path = [for(y=[-30:30]) [ 20-3*(1-cos((y+30)/60*360)),y]];
//   rotate_sweep(path, caps=true, texture=tile, 
//                tex_size=[10,15], tex_depth=5, angle=215);
// Example(3D,NoAxes,Med,VPT=[1.00759,3.89216,-1.27032],VPR=[57.1,0,34.8],VPD=240.423): Turning the texture 90 degrees with `tex_rot` produces a texture that ends at the top and bottom.
//   shape = skin([rect(2/5),
//                 rect(2/3),
//                 rect(2/5)],
//                z=[0,1/2,1],
//                slices=0,
//                caps=false);
//   tile = move([0,1/2,2/3],yrot(90,shape));
//   path = [for(y=[-30:30]) [ 20-3*(1-cos((y+30)/60*360)),y]];
//   rotate_sweep(path, caps=true, texture=tile, tex_rot=90,
//                tex_size=[12,8], tex_depth=9, angle=360);
// Example(3D,Med,NoAxes,VPR=[78.1,0,199.3],VPT=[-4.55445,1.37814,-4.39897],VPD=192.044): A basket weave texture, here only halfway around the circle to avoid clutter.  
//     diag_weave_vnf = [
//         [[0.2, 0, 0], [0.8, 0, 0], [1, 0.2, 0.5], [1, 0.8, 0.5], [0.7, 0.5, 0.5],
//          [0.5, 0.3, 0], [0.2, 0, 0.5], [0.8, 0, 0.5], [1, 0.2, 1], [1, 0.8, 1],
//          [0.7, 0.5, 1], [0.5, 0.3, 0.5], [1, 0.2, 0], [1, 0.8, 0], [0.8, 1, 0.5],
//          [0.2, 1, 0.5], [0.5, 0.7, 0.5], [0.7, 0.5, 0], [0.8, 1, 1], [0.2, 1, 1],
//          [0.5, 0.7, 1], [0.8, 1, 0], [0.2, 1, 0], [0, 0.8, 0.5], [0, 0.2, 0.5],
//          [0.3, 0.5, 0.5], [0.5, 0.7, 0], [0, 0.8, 1], [0, 0.2, 1], [0.3, 0.5, 1],
//          [0, 0.8, 0], [0, 0.2, 0], [0.3, 0.5, 0], [0.2, 0, 1], [0.8, 0, 1], [0.5, 0.3, 1]],
//         [[0, 1, 5], [1, 2, 4, 5], [7, 11, 10, 8], [8, 10, 9], [7, 8, 2, 1], [9, 10, 4, 3],
//          [10, 11, 5, 4], [0, 5, 11, 6], [12, 13, 17], [13, 14, 16, 17], [3, 4, 20, 18],
//          [18, 20, 19], [3, 18, 14, 13], [19, 20, 16, 15], [20, 4, 17, 16], [12, 17, 4, 2],
//          [21, 22, 26], [22, 23, 25, 26], [15, 16, 29, 27], [27, 29, 28], [15, 27, 23, 22],
//          [28, 29, 25, 24], [29, 16, 26, 25], [21, 26, 16, 14], [30, 31, 32], [31, 6, 11, 32],
//          [24, 25, 35, 33], [33, 35, 34], [24, 33, 6, 31], [34, 35, 11, 7],
//          [35, 25, 32, 11], [30, 32, 25, 23]]
//     ];
//     path = [for(y=[-30:30]) [ 20-3*(1-cos((y+30)/60*360)),y]];
//     down(31)linear_extrude(height=1)arc(r=23,angle=[0,180], wedge=true);
//     rotate_sweep(path, caps=true, texture=diag_weave_vnf, angle=180,
//                  tex_size=[10,10], convexity=12, tex_depth=2);
// Example(3D,VPR=[59.20,0.00,159.20],VPD=74.40,VPT=[7.45,6.83,1.54],NoAxes): Textures can be used to place images onto objects.  If you want to place an image onto a cylinder you probably don't want it to cover the whole cylinder, or to create many small copies.  To do this you can create a textured cylinder with an angle less than 360 degrees to hold the texture.  In this example we calculate the angle so that the output has the same aspect ratio.  The default `tex_extra` of zero for a single tile ensures that the image appears without an extra border.  
//   img = [
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//   ];
//   h = 20;
//   r = 15;
//   ang = len(img[0])/len(img)*h/(2*PI*r)*360;
//   rotate_sweep([[r,-h/2],[r,h/2]], texture=img,
//                tex_reps=1,angle=ang, caps=true);
// Example(3D,VPR=[80.20,0.00,138.40],VPD=82.67,VPT=[6.88,7.29,1.77],NoAxes): Here we have combined the above model with a suitable cylinder.  With a coarse texture like this you need to either match the `$fn` of the cylinder to the texture, or choose a sufficiently fine cylinder to avoid conflicting facets.  
//   img = [
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//   ];
//   h = 20;
//   r = 15;
//   ang = len(img[0])/len(img)*h/(2*PI*r)*360;
//   rotate_sweep([[r,-h/2],[r,h/2]], texture=img,
//                tex_reps=1,angle=ang, caps=true);
//   cyl(r=r,h=27,$fn=128);
// Example(3D,VPR=[68.30,0.00,148.90],VPD=91.85,VPT=[-0.56,5.78,-0.90],NoAxes): Above we explicitly calculated the required angle to produce the correct aspect ratio.  Here we use `pixel_aspect` which produces an output whose average width has the desired aspect ratio.  
//   img = [
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//   ];
//   rotate_sweep([[15,-10],[5,10]], texture=img,
//                tex_reps=[1,1], caps=true, pixel_aspect=1);
//   cyl(r1=16,r2=4,h=24,$fn=128);
// Example(3D,VPR=[96.30,0.00,133.50],VPD=54.24,VPT=[1.94,2.85,-0.47]): Here we apply the texture to a sphere using the automatic `pixel_aspect` to determine the angle.  Note that using {{spheroid()}} with the circum option eliminates artifacts arising due to mimatched faceting.  
//   img = [
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0,.5,.5, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
//      [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
//      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//   ];
//   arc = arc(r=10, angle=[-44,44],n=100);
//   rotate_sweep(arc, texture=img, tex_reps=[1,1],
//                caps=true, pixel_aspect=1);
//   spheroid(10,$fn=64,circum=true);
function rotate_sweep(
    shape, angle=360,
    texture, tex_size=[5,5], tex_counts, tex_reps, 
    tex_inset=false, tex_rot=0,
    tex_scale, tex_depth, tex_samples, tex_aspect, pixel_aspect, 
    tex_taper, shift=[0,0], caps, closed, 
    style="min_edge", cp="centroid",
    atype="hull", anchor="origin",
    spin=0, orient=UP, start=0, 
    _tex_inhibit_y_slicing
) =
    assert(is_num(angle) && angle>0 && angle<=360,"\nangle must be a positive number not more than 360")
    assert(num_defined([closed,caps])<2, "\nIn rotate_sweep the `closed` paramter has been replaced by `caps` with the opposite meaning. You cannot give both.")
    assert(num_defined([tex_reps,tex_counts])<2, "\nIn rotate_sweep() the 'tex_counts' parameters has been replaced by 'tex_reps'. You cannot give both.")
    assert(num_defined([tex_scale,tex_depth])<2, "\nIn linear_sweep() the 'tex_scale' parameter has been replaced by 'tex_depth'. You cannot give both.")
    assert(!is_path(shape) || caps || len(shape)>=3, "\n'shape' is a path and caps=false, but a closed path requires three points.")
    let(
         caps = is_def(caps) ? caps
              : is_def(closed) ? !closed
              : false,
         tex_reps = is_def(tex_counts)? echo("In rotate_sweep() the 'tex_counts' parameter is deprecated and has been replaced by 'tex_reps'")tex_counts
                  : tex_reps,
         tex_depth = is_def(tex_scale)? echo("In rotate_sweep() the 'tex_scale' parameter is deprecated and has been replaced by 'tex_depth'")tex_scale
                   : default(tex_depth,1),
         region = _force_xplus(force_region(shape))
    )
    assert(is_region(region), "\nshape is not a region or path.")
    let(
        bounds = pointlist_bounds(flatten(region)),
        min_x = bounds[0].x,
        max_x = bounds[1].x,
        min_y = bounds[0].y,
        max_y = bounds[1].y,
        h = max_y - min_y
    )
    assert(min_x>=0, "\nInput region must exist entirely in the X+ half-plane.")
    !is_undef(texture)? _textured_revolution(
        shape,
        texture=texture,
        tex_size=tex_size,
        counts=tex_reps,
        tex_scale=tex_depth,
        inset=tex_inset,
        rot=tex_rot,
        samples=tex_samples,
        inhibit_y_slicing=_tex_inhibit_y_slicing,
        taper=tex_taper, tex_aspect=tex_aspect, pixel_aspect=pixel_aspect, 
        shift=shift,
        closed=!caps,
        angle=angle,
        style=style,
        start=start
    ) :
    let(
        region = is_path(shape) && caps ? [deduplicate([[0,shape[0].y], each shape, [0,last(shape).y]])]
               : region,
        steps = ceil(segs(max_x) * angle / 360) + (angle<360? 1 : 0),
        skmat = down(min_y) * skew(sxz=shift.x/h, syz=shift.y/h) * up(min_y),
        transforms = [
            if (angle==360) for (i=[0:1:steps-1]) skmat * rot([90,0,start+360-i*360/steps]),
            if (angle<360) for (i=[0:1:steps-1]) skmat * rot([90,0,start+angle-i*angle/(steps-1)]),
        ],
        vnf = sweep(
            region, transforms,
            closed=angle==360,
            caps=angle!=360,
            style=style, cp=cp,
            atype=atype, anchor=anchor,
            spin=spin, orient=orient
        )
    ) vnf;

function _force_xplus(data) =
  [for(part=data) [for(pt=part) approx(pt.x,0) ? [0,pt.y] : pt]];

// Function&Module: sweep()
// Synopsis: Construct a 3d object from arbitrary transformations of a 2d polygon path.
// SynTags: VNF, Geom
// Topics: Extrusion, Sweep, Paths, Textures
// See Also: sweep_attach(), linear_sweep(), rotate_sweep(), spiral_sweep(), path_sweep(), path_sweep2d(), offset_sweep()
// Usage: As Module
//   sweep(shape, transforms, [closed], [caps], [style], [convexity=], [anchor=], [spin=], [orient=], [atype=]) [ATTACHMENTS];
// Usage: As Function
//   vnf = sweep(shape, transforms, [closed], [caps], [style], [anchor=], [spin=], [orient=], [atype=]);
// Description:
//   The input `shape` must be a non-self-intersecting 2D polygon or region, and `transforms`
//   is a list of 4x4 transformation matrices.  The sweep algorithm applies each transformation in sequence
//   to the shape input and links the resulting polygons together to form a polyhedron.
//   If `closed=true` then the first and last transformation are linked together.
//   As a function, returns the VNF for the polyhedron.  As a module, computes the polyhedron.
//   .
//   The `caps` parameter controls what happens at the ends of the polyhedron.  If `closed=true` the shape links to itself and has no
//   ends, but when `closed` is false, the two ends are, by default capped with flat faces.  If you set `caps=false` then the ends
//   receive no faces and the resulting non-manifold polyhedron has exposed edges.  You can also set caps to a number, which adds a
//   rounded cap with the specified radius, or you can set caps to an {{offset_sweep()}} end treatment, and the specified sweep
//   is attached as a cap.  Note that you are **adding** a rounded cap, not rounding the specified shape as is common for many other
//   library modules.  The rounded cap is attached to the end face and may not blend neatly with the swept shape unless the sides of
//   the swept shape are perpendicular to the end cap.  
//   .
//   This is a powerful, general framework for producing polyhedra.  It is important
//   to ensure that your resulting polyhedron does not include any self-intersections, or it will
//   be invalid and generate CGAL errors.  If you get such errors, most likely you have an
//   overlooked self-intersection.  The errors do not occur when your shape is alone
//   in your model, but errors arise if you add a second object to the model.  This may mislead you into
//   thinking the second object caused a problem.  Even adding a simple cube to the model reveals the problem.
//   .
//   You can apply a texture to the sweep object using the usual texture parameters.
//   See [Texturing](skin.scad#section-texturing) for more details on how textures work.
//   This works by passing through to {{vnf_vertex_array()}}, which also has more details on
//   texturing.  Note that textures work only when the shape is a path; you cannot apply a texture to a region.
//   The texture tiles are oriented on the path sweep so that the Y axis of the tile is aligned with the sweep direction.
//   .
//   
// Arguments:
//   shape = 2d path or region, describing the shape to be swept.
//   transforms = list of 4x4 matrices to apply
//   closed = set to true to form a closed (torus) model.  Default: false
//   caps = if closed is false, set caps to false to leave the ends open.  Other values are true to create a flat cap, a number a rounded cap, or an {{offset_sweep()}} end treatment to create the specified offset sweep.  Can be a single value or pair of values to control the caps independently at each end.  Default: true
//   style = vnf_vertex_array style.  Default: "min_edge"
//   ---
//   convexity = convexity setting for use with polyhedron. (module only) Default: 10
//   texture = A texture name string, or a rectangular array of scalar height values (0.0 to 1.0), or a VNF tile that defines the texture to apply to vertical surfaces.  See {{texture()}} for what named textures are supported.
//   tex_size = An optional 2D target size (2-vector or scalar) for the texture at the first point of your shape and first transformation.  Actual texture sizes are scaled somewhat to evenly fit the available surface. Default: `[5,5]`
//   tex_reps = If given instead of tex_size, a scalar or 2-vector giving the integer number of texture tile repetitions in the horizontal and vertical directions.
//   tex_inset = If numeric, lowers the texture into the surface by the specified proportion, e.g. 0.5 would lower it half way into the surface.  If `true`, insets by exactly its full depth.  Default: `false`
//   tex_rot = Rotate texture by specified angle, which must be a multiple of 90 degrees.  Default: 0
//   tex_depth = Specify texture depth; if negative, invert the texture.  Default: 1.  
//   tex_samples = Minimum number of "bend points" to have in VNF texture tiles.  Default: 8
//   tex_extra = number of extra lines of a hightfield texture to add at the end.  Can be a scalar or 2-vector to give x and y values.  Default: 1
//   tex_skip = number of lines of a heightfield texture to skip when starting.  Can be a scalar or two vector to give x and y values.  Default: 0
//   normals = if provided, used this array of normals for calculating the texture.  Dimension should be len(transforms) x len(shape).  
//   cp = Centerpoint for determining "intersect" anchors or centering the shape.  Determintes the base of the anchor vector.  Can be "centroid", "mean", "box" or a 3D point.  Default: "centroid"
//   atype = Select "hull" or "intersect" anchor types.  Default: "hull"
//   anchor = Translate so anchor point is at the origin. Default: "origin"
//   spin = Rotate this many degrees around Z axis after anchor. Default: 0
//   orient = Vector to rotate top toward after spin (module only)
// Named Anchors:
//   "origin" = The native position of the shape.  
// Anchor Types:
//   "hull" = Anchors to the virtual convex hull of the shape.
//   "intersect" = Anchors to the surface of the shape.
// Example(VPR=[45,0,74],VPD=175,VPT=[-3.8,12.4,19]): A bent object that also changes shape along its length.
//   radius = 75;
//   angle = 40;
//   shape = circle(r=5,$fn=32);
//   T = [for(i=[0:25]) xrot(-angle*i/25,cp=[0,radius,0])*scale([1+i/25, 2-i/25,1])];
//   sweep(shape,T);
// Example: This is the "sweep-drop" example from list-comprehension-demos.
//   function drop(t) = 100 * 0.5 * (1 - cos(180 * t)) * sin(180 * t) + 1;
//   function path(t) = [0, 0, 80 + 80 * cos(180 * t)];
//   function rotate(t) = 180 * pow((1 - t), 3);
//   step = 0.01;
//   path_transforms = [for (t=[0:step:1-step]) translate(path(t)) * zrot(rotate(t)) * scale([drop(t), drop(t), 1])];
//   sweep(reverse(circle(1, $fn=12)), path_transforms);
// Example: Another example from list-comprehension-demos
//   function f(x) = 3 - 2.5 * x;
//   function r(x) = 2 * 180 * x * x * x;
//   pathstep = 1;
//   height = 100;
//   shape_points = subdivide_path(square(10),40,closed=true);
//   path_transforms = [for (i=[0:pathstep:height]) let(t=i/height) up(i) * scale([f(t),f(t),i]) * zrot(r(t))];
//   sweep(shape_points, path_transforms);
// Example: Twisted container.  Note that this technique doesn't create a fixed container wall thickness.
//   shape = subdivide_path(square(30,center=true), 40, closed=true);
//   outside = [for(i=[0:24]) up(i)*rot(i)*scale(1.25*i/24+1)];
//   inside = [for(i=[24:-1:2]) up(i)*rot(i)*scale(1.2*i/24+1)];
//   sweep(shape, concat(outside,inside));
// Example: "sweet-drop" with a dots texture
//   function drop(t) = 100 * 0.5 * (1 - cos(180 * t)) * sin(180 * t) + 1;
//   function path(t) = [0, 0, 80 + 80 * cos(180 * t)];
//   function rotate(t) = 180 * pow((1 - t), 3);
//   step = 0.01;
//   path_transforms = [for (t=[0:step:1-step]) translate(path(t)) * zrot(rotate(t)) * scale([drop(t), drop(t), 1])];
//   sweep(reverse(circle(1, $fn=12)), path_transforms, texture="dots", tex_reps=[12,12],tex_depth=.1);
function sweep(shape, transforms, closed=false, caps, style="min_edge",
               anchor="origin", cp="centroid", spin=0, orient=UP, atype="hull",
               texture, tex_reps, tex_size, tex_samples, tex_inset=false, tex_rot=0, 
               tex_depth=1, tex_extra, tex_skip, _closed_for_normals=false, normals) =
    assert(is_consistent(transforms, ident(4)), "\nInput transforms must be a list of numeric 4×4 matrices in sweep.")
    assert(is_path(shape,2) || is_region(shape), "\nInput shape must be a 2d path or a region.")
    let(
        caps = is_list(caps) && select(caps,0,1)==["for","offset_sweep"] ? [caps,caps]
             : is_bool(caps) || is_num(caps) ? [caps,caps]
             : is_undef(caps) ? closed ? [false,false] : [true,true]
             : caps, 
        capsOK = is_list(caps) && len(caps)==2
                    &&
                      [] == [for(cap=caps)
                               if (!(is_bool(cap) || is_num(cap) || select(cap,0,1)==["for","offset_sweep"])) 1],
        flatcaps = [for(cap=caps) is_bool(cap) ? cap : false],
        fancycaps = [for(cap=caps) is_bool(cap) ? false
                                 : is_num(cap) ? os_circle(r=cap,steps=ceil(segs(cap)/4))
                                 : cap]
    )
    assert(len(transforms)>=2, "\ntransformation must be length 2 or more.")
    assert(capsOK, "\ncaps must be boolean, number, an offset_sweep specification, or a list of two of those.")
    assert(!closed || caps==[false,false], "\nCannot make closed shape with caps.")
    is_region(shape)?
        assert(fancycaps==[false,false], "\nRounded caps are not supported for regions.")
        assert(is_undef(texture), "\nTextures are not supported for regions, only paths.")
        let(
            regions = region_parts(shape),
            rtrans = reverse(transforms),
            vnfs = [
                for (rgn=regions) each [
                    for (path=rgn)
                        sweep(path, transforms, closed=closed, caps=false, style=style),
                    if (flatcaps[0]) vnf_from_region(rgn, transform=transforms[0], reverse=true, triangulate=true),  // triangulation needed?
                    if (flatcaps[1]) vnf_from_region(rgn, transform=last(transforms), triangulate=true),
                ],
            ],
            vnf = vnf_join(vnfs)
        )
        vnf
  :
    assert(len(shape)>=3, "\nshape must be a path of at least 3 non-collinear points.")
    let(
         points = [for(i=[0:len(transforms)-(closed?0:1)]) apply(transforms[i%len(transforms)],path3d(shape))],
         normals = is_def(normals) ? normals
                 : (!(is_def(texture) && (closed || _closed_for_normals))) ? undef
                 : let(
                        n = surface_normals(select(points,0,-2), col_wrap=true, row_wrap=true)
                   )
                   [each n, n[0]],
         vva_result = vnf_vertex_array(points, normals=normals, 
                               cap1=flatcaps[0],cap2=flatcaps[1],col_wrap=true,style=style, return_edges=fancycaps!=[false,false],
                               texture=texture, tex_reps=tex_reps, tex_size=tex_size, tex_samples=tex_samples,
                               tex_inset=tex_inset, tex_rot=tex_rot, tex_depth=tex_depth, tex_extra=tex_extra, tex_skip=tex_skip),
         vnf = fancycaps==[false,false] ? vva_result
             : vnf_join(
                   [ vva_result[0], 
                     for(ind=[0,1]) 
                          if (fancycaps[ind]) let(
                              polygon = vva_result[1][ind+2],
                              plane = plane_from_polygon(ind==0? reverse(polygon) : polygon)
                          )
                          apply(lift_plane(plane),offset_sweep(project_plane(plane, polygon), top=fancycaps[ind], caps=[false,true]))
                    ])
    ) vnf;

// Section: Introduction to Texturing
//   Some operations are able to add texture to the objects they create.  A texture can be any regularly repeated variation in the height of the surface.
//   To define a texture you need to specify how the height should vary over a rectangular block that is repeated to tile the object.  Because textures
//   are based on rectangular tiling, this means adding textures to curved shapes may result in distortion of the basic texture unit.  For example, if you
//   texture a cone, the scale of the texture is larger at the wide end of the cone and smaller at the narrower end of the cone.
//   .
//   You can specify a texture using two methods: a height field or a VNF.  For each method you also must specify the scale of the texture, which
//   gives the size of the rectangular unit in your object that corresponds to one texture tile.  This scale does not preserve
//   aspect ratio: you can stretch the texture as desired.
// Subsection: Height Field Texture Maps
//   The simplest way to specify a texture map is to give a 2d array of
//   height values that specify the height of the texture on a grid.
//   Values in the height field should generally range from 0 to 1.  A zero height
//   in the height field corresponds to the height of the surface and 1
//   the highest point in the texture above the surface being textured.
// Figure(2D,Big,NoScales,VPT=[6.21418,0.242814,0],VPD=28.8248,VPR=[0,0,0]): Here is a 2d texture described by a "grid" that just contains a single row.  Such a texture can be used to create ribbing. The texture is `[[0, 1, 1, 0]]`, and the fixture shows three repetitions of the basic texture unit.
//   ftex1 = [0,1,1,0,0];
//   stroke( transpose([count(5),ftex1]), dots=true, dots_width=3,width=.05);
//   right(4)stroke( transpose([count(5),ftex1]), dots=true, width=.05,dots_color="red",color="blue",dots_width=3);
//   right(8)stroke( transpose([count(5),ftex1]), dots=true, dots_width=3,width=.05);
//   stroke([[4,-.3],[8,-.3]],width=.05,endcaps="arrow2",color="black");
//   move([6,-.4])color("black")text("Texture Size", size=0.3,anchor=BACK);
// Continues:
//   Line segments connect the dots within the texture and also the dots between adjacent texture tiles.
//   The size of the texture (specified with `tex_size`) includes the segment that connects the tile to the next one.
//   Note that the grid is always uniformly spaced.
//   By default textures are created with unit depth, meaning that the top surface
//   of the texture is 1 unit above the surface being textured, assuming that the texture
//   is designed to span the range from 0 to 1.  The `tex_depth` parameter can adjust
//   this dimension of a texture without changing anything else, setting `tex_depth` negative
//   inverts a texture, and `tex_inset` lowers a texture into the textured object.
//   Textures that extend beyond the interval [0,1] are accepted, but the behavior of the
//   `tex_depth` and `tex_inset` parameters may be less intuitive.  
// Figure(2D,Big,NoScales,VPR=[0,0,0],VPT=[6.86022,-1.91238,0],VPD=28.8248):
//   ftex1 = [0,1,1,0,0];
//   left(0)color(.6*[1,1,1])rect([12,1],anchor=BACK+LEFT);
//   stroke( transpose([count(5),ftex1]), dots=true, dots_width=3,width=.05);
//   polygon( transpose([count(5),ftex1]));
//   right(4){stroke( transpose([count(5),ftex1]), dots=true, width=.05,dots_width=3);
//        polygon( transpose([count(5),ftex1]));
//        }
//   right(8){stroke( transpose([count(5),ftex1]), dots=true, dots_width=3,width=.05);
//             polygon( transpose([count(5),ftex1]));
//        }
//   stroke([[12.25,0],[12.25,1]],width=.05,endcaps="arrow2",color="black");
//   move([12.35,.5])color("black")text("Depth=1", size=0.3,anchor=LEFT);
//   fwd(4){
//   left(0)color(.6*[1,1,1])rect([12,1],anchor=BACK+LEFT);
//   stroke( transpose([count(5),2*ftex1]), dots=true, dots_width=3,width=.05);
//   polygon( transpose([count(5),2*ftex1]));
//   right(4){stroke( transpose([count(5),2*ftex1]), dots=true, width=.05,dots_width=3);
//        polygon( transpose([count(5),2*ftex1]));
//        }
//   right(8){stroke( transpose([count(5),2*ftex1]), dots=true, dots_width=3,width=.05);
//             polygon( transpose([count(5),2*ftex1]));
//        }
//   stroke([[12.25,0],[12.25,2]],width=.05,endcaps="arrow2",color="black");
//   move([12.35,1])color("black")text("Depth=2", size=0.3,anchor=LEFT);
//   }
// Continues:
//   If you want to keep the texture the same size but make the slope
//   steeper you need to add more points to make the uniform grid fine enough
//   to represent the slope you want.  This means that creating sharp edges
//   can require a large number of points, resulting in longer run times.
//   When using the built-in textures you can control the number of points
//   using the `n=` argument to {{texture()}}.  
// Figure(2D,Big,NoScales,VPT=[6.21418,0.242814,0],VPD=28.8248,VPR=[0,0,0]):  
//   ftex2 = xscale(4/11,transpose([count(12),[0,1,1,1,1,1,1,1,1,1,0,0]]));
//   stroke( ftex2, dots=true, dots_width=3,width=.05);
//   right(4)stroke( ftex2, dots=true, width=.05,dots_color="red",color="blue",dots_width=3);
//   right(8)stroke( ftex2, dots=true, dots_width=3,width=.05);
//   stroke([[4,-.3],[8,-.3]],width=.05,endcaps="arrow2",color="black");
//   move([6,-.4])color("black")text("Texture Size", size=0.3,anchor=BACK);
// Continues:
//   A more serious limitation of height field textures is that some shapes, such as hexagons or circles, cannot be accurately represented because
//   their points don't fall on any grid.  Trying to create such shapes is difficult and requires many points to approximate the
//   true point positions for the desired shape.  This makes the texture slow to compute.  
//   Another serious limitation is more subtle.  In the 2D examples above, it is obvious how to connect the
//   dots together.  But in 3D example we need to triangulate the points on a grid, and this triangulation is not unique.
//   The `style` argument lets you specify how the points are triangulated using the styles supported by {{vnf_vertex_array()}}.
//   In the example below we have expanded the 2D example into 3D:
//   
//   ```openscad
//       [[0,0,0,0],
//        [0,1,1,0],
//        [0,1,1,0],
//        [0,0,0,0]]
//   ```
//
// Continues:
//   and we show the 3D triangulations produced by the different styles:
// Figure(3D,Big,NoAxes,VPR=[45.5,0,18.2],VPT=[2.3442,-6.25815,3.91529],VPD=35.5861):
//   tex = [
//          [0,0,0,0,0],
//          [0,1,1,0,0],
//          [0,1,1,0,0],
//          [0,0,0,0,0],
//          [0,0,0,0,0]       
//         ];
//   hm = [for(i=[0:4]) [for(j=[0:4]) [i,-j,tex[i][j]]]];      
//   types = ["quincunx", "convex", "concave","min_area", "default","alt","min_edge"]; 
//   grid_copies(spacing=5, n=[4,2]){
//     let(s = types[$row*4+$col]){
//       if (is_def(s)){
//       vnf_polyhedron(vnf_vertex_array(hm,style=s));
//       if ($row==1)
//         back(.8)right(2)rotate($vpr)color("black")text(s,size=.5,anchor=CENTER);
//       else
//         fwd(4.7)right(2)rotate($vpr)color("black")text(s,size=.5,anchor=CENTER);
//       }
//     }
//   }  
// Continues:
//   Note that of the seven available styles, five produce a different result.  There may exist some concave shape where none of the styles
//   produce the right result everywhere on the shape.  If this happens it would be another limitation of height field textures.  (If you have an
//   example of such a texture and shape please let us know!)
// Subsection: VNF Textures
//   VNF textures overcome all of the limitations of height field textures, but with two costs.  They can be more difficult to construct than
//   a simple array of height values, and they are significantly slower to compute for a tile with the same number of points.  However, for
//   textures that don't neatly lie on a grid, a VNF tile is more efficient than a finely sampled height field.  With VNF textures you can create
//   textures that have disconnected components, or concavities that cannot be expressed with a single valued height map.  However, you can also
//   create invalid textures that fail to close at the ends, so care is required to ensure that your resulting shape is valid.  
//   .
//   A VNF texture is defined by providing a VNF whose projection onto the XY plane is contained in the unit square [0,1] x [0,1] so
//   that the VNF can be tiled.  The VNF is tiled without a gap, matching the edges, so the vertices along corresponding edges must match to make a
//   consistent triangulation possible.  The VNF cannot have any X or Y values outside the interval [0,1].  If you want a valid polyhedron
//   that OpenSCAD can render then you need to take care with edges of the tiles that correspond to endcap faces in the textured object.
//   So for example, in a linear sweep, the top and bottom edges of tiles end abruptly to form the end cap of the object.  You can make a valid object
//   in two ways.  One way is to create a tile with a single, complete edge along Y=0, and of course a corresponding edges along Y=1.  The second way
//   to make a valid object is to have no points at all on the Y=0 line, and of course none on Y=1.  In this case, the resulting texture produces
//   a collection of disconnected objects. The Z coordinates of your tile can be anything, but as with height fields, for the dimensional settings on textures
//   to work intuitively, you should construct your tile so that Z ranges from 0 to 1.  You can then use `tex_depth` to control the depth of the tile in use.  
// Figure(3D): This is the "hexgrid" VNF tile, which creates a hexagonal grid texture, something that doesn't work well with a height field because the edges of the hexagon don't align with the grid.  Note how the tile ranges between 0 and 1 in both X, Y and Z.  In fact, to get a proper aspect ratio in your final texture you need to use the `tex_size` parameter to introduct a sqrt(3) scale factor.  
//   tex = texture("hex_grid");
//   vnf_polyhedron(tex);
// Figure(3D): This is an example of a tile that has no edges at the top or bottom, so it creates disconnected rings.  See {{linear_sweep()}} for examples showing this tile in use.
//   shape = skin([
//                 rect(2/5),
//                 rect(2/3),
//                 rect(2/5)
//                ],
//                z=[0,1/2,1],
//                slices=0,
//                caps=false);
//   tile = move([0,1/2,2/3],yrot(90,shape));
//   vnf_polyhedron(tile);
// Continues:
//   A VNF texture provides a flat structure.  In order to apply this structure to a cylinder or other curved object, the VNF must be sliced
//   and "folded" so it can follow the curve.  This folding is controlled by the `tex_samples` parameter to {{cyl()}}, {{linear_sweep()}},
//   and {{rotate_sweep()}}.  Note that you specify it when you **use** the texture, not when you create it.  This differs from height
//   fields, where the analogous parameter is the `n=` parameter of the {{texture()}} function.  When `tex_samples` is too small, only the
//   points given in the VNF follows the surface, resulting in a blocky look and geometrical artifacts.  
// Figure(3D,Med,NoAxes): On the left the `tex_samples` value is small and the texture is blocky.  On the right, the default value of 8 allows a reasonable fit to the cylinder. 
//   xdistribute(spacing=5){
//      cyl(d=10/PI, h=5, chamfer=0,
//         texture=texture("bricks_vnf"), tex_samples=1, tex_reps=[6,3], tex_depth=.2);
//      cyl(d=10/PI, h=5, chamfer=0,
//         texture=texture("bricks_vnf"), tex_samples=8, tex_reps=[6,3], tex_depth=.2);
//   }
// Continues:
//   When the VNF is sliced,
//   extra points can be introduced in the interior of faces leading to unexpected irregularities in the textures, which appear
//   as extra triangles.  These artifacts can be minimized by making the VNF texture's faces as large as possible rather than using
//   a triangulated VNF, but depending on the specific VNF texture, it may be impossible to entirely eliminate them.
// Figure(3D,Med,NoAxes,VPR=[140.9,0,345.7],VPT=[9.48289,-0.88709,5.7837],VPD=39.5401): The left shows a normal bricks_vnf texture.  The right shows a texture that was first passed through {{vnf_triangulate()}}.  Note the extra triangle artifacts visible at the ends on the brick faces.
//   tex = texture("bricks_vnf");
//   cyl(d=10,h=15,texture=tex, tex_reps=[4,2],tex_samples=5,rounding=2);
//   up(7)fwd(-3)right(15)cyl(d=10,h=15,texture=vnf_triangulate(tex), tex_reps=[4,2],tex_samples=5,rounding=2);
//
// Subsection: Textures from Graphic Images
//   .
//   In additional to creating textured surfaces, the texturing feature of BOSL2 can be used to place relief images onto objects
//   using a single repetition of a large heightfield texture array. In order to do this, you'll need a way to import your image into OpenSCAD.
//   .
//   The BOSL2 scripts folder contains three scripts for creating heightfield texture arrays from graphic images.
//   Right-click the links to the python scripts to download them to your local system, then run them from the command line.
//   The html link will open in your browser.
//   .
//      - [**img2scad.html**](https://htmlpreview.github.io/?https://github.com/BelfrySCAD/BOSL2/blob/master/scripts/img2scad.html)
//   can create a texture array from any image your browser can render.  
//   .
//      - [**img2scad.py**](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/scripts/img2scad.py)
//   is a python script that creates a texture array from most common raster image formats, including gif, png, jpeg.
//   .
//      - [**geotiff2scad.py**](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/scripts/geotiff2scad.py)
//   is a python script creates a texture array from geotiff depth maps.
//   .
//   Each of these scripts places a named array in an .scad file with names specified at run time.   Use include<> to add the array to your model. 
//   .
//   Both **img2scad.py** and **img2scad.html** create texture arrays from graphics, but the html page has a few additional capabilities
//   and it provides a graphical user interface.
//   .
//   On the right is a {{textured_tile()}} with the texture array created by **img2scad.html** from the .png file on the left:
//   .
//   ![Textured Tile](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/images/WilburTex01.png)
//   .
//   The image luminance is directly translated into texture depth in the example above.  Better results can be obtained by passing 
//   the original image through an AI image processor to produce a depth map from the image before creating the texture array.
//   .
//   ![Texture Tile](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/images/WilburTex02.png)
//   .
//   AI image processing tool and workflows are still evolving rapidly. See the [discussion](https://github.com/BelfrySCAD/BOSL2/discussions/1731) on depth map workflows for current best practices.
//   .
//   Sources of whole planet GeoTIFF Data include:
//      * [USGS Astrogeology Science Center](https://astrogeology.usgs.gov/search)
//      * [NASA PDS (Planetary Data System)](https://pds.nasa.gov)
//      * [OpenPlanetaryMap / OpenPlanetary](https://github.com/OpenPlanetary/opm)
//   .
//   GeoTIFF data for smaller areas comes from the Space Shuttle Radar Topography Mission. Data covering about 80% of the Earth's surface
//   is available from [Earthdata](https://www.earthdata.nasa.gov/data/instruments/srtm/data-access-tools) 
//   .
//   A globe created using the **geotiff2scad.py** script to generate the texture array:
//   .
//   ![Geotiff Example](https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/images/globe_animation.png)
//   .
// Section: Texturing 
// Function: texture()
// Topics: Textures, Knurling
// Synopsis: Produce a standard texture. 
// Topics: Extrusion, Textures
// See Also: linear_sweep(), rotate_sweep(), cyl(), vnf_vertex_array(), sweep(), path_sweep(), textured_tile()
// Usage:
//   tx = texture(tex, [n=], [inset=], [gap=], [roughness=]);
// Description:
//   Given a texture name, returns a texture.  Textures can come in two varieties:
//   - Heightfield textures, which are 2D arrays of scalars.  These are usually faster to render, but can be less precise and prone to triangulation errors.  The table below gives the recommended style for the best triangulation.  If results are still incorrect, switch to the similar VNF tile by adding the "_vnf" suffix.
//   - VNF Tile textures, which are VNFs that cover the unit square [0,0] x [1,1].  These tend to be slower to render, but allow greater flexibility and precision for shapes that don't align with a grid.
//   .
//   In the descriptions below, imagine the textures positioned on the XY plane, so "horizontal" refers to the "sideways" dimensions of the texture and
//   "up" and "down" refer to the depth dimension, perpendicular to the surface being textured.  If a texture is placed on a cylinder, the "depth" becomes the radial direction and "horizontal"
//   refers to the vertical and tangential directions on the cylindrical surface.  All horizontal dimensions for VNF textures are relative to the unit square
//   on which the textures are defined, so a value of 0.25 for a gap or border refers to 1/4 of the texture's full length and/or width.  All supported textures appear below in the examples.  
// Arguments:
//   tex = The name of the texture to get.
//   ---
//   n = The number of samples to use for defining a heightfield texture.  Depending on the texture, the result is either n×n or 1×n.  Not allowed for VNF textures.  See the `tex_samples` argument to {{cyl()}}, {{linear_sweep()}} and {{rotate_sweep()}} for controlling the sampling of VNF textures.
//   border = The size of a border region on some VNF tile textures.  Generally between 0 and 0.5.
//   gap = The gap between logically distinct parts of some VNF tiles.  (ie: gap between bricks, gap between truncated ribs, etc.)
//   roughness = The amount of roughness used on the surface of some heightfield textures.  Generally between 0 and 0.5.
// Example(3D): **"bricks"** (Heightfield) = A brick-wall pattern.  Giving `n=` sets the number of heightfield samples to `n` by `n`.  Default: 24.  Giving `roughness=` creates a rough surface texture to the top brick faces by randomizing the brick height to a band of the specified height (relative to the tile range of 0 to 1), so with the default of 0.1 it means the top level varies randomly in [0.9,1].  Default: 0.1.  Use `style="convex"`.
//   tex = texture("bricks");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_depth=1/2, tex_size=[10,10]
//   );
// Example(3D): **"bricks_vnf"** (VNF) = VNF version of "bricks".  Giving `gap=` sets the "mortar" gap between adjacent bricks, default 0.05.  Giving `border=` specifies that the top face of the brick is smaller than the bottom of the brick by `border` on each of the four sides.  If `gap` is zero then a `border` value close to 0.5 causes the bricks to come to a sharp pointed edge, with just a tiny flat top surface.  Note that `gap+border` must be strictly smaller than 0.5.   Default is `border=0.05`.  
//   tex = texture("bricks_vnf");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "bricks_vnf" texture with large border. 
//   tex = texture("bricks_vnf",border=0.25);
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D,VPR=[84.4,0,4.7],VPT=[2.44496,6.53317,14.6135],VPD = 126): **"checkers"** (VNF) = A pattern of alternating checkerboard squares.  Giving `border=` specifies that the top face of the checker surface is smaller than the bottom by `border` on each of the four sides.  As `border` approaches 0.5 the tops come to sharp corners.  You must set `border` strictly between 0 and 0.5.  Default: 0.05.
//   tex = texture("checkers");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D,VPR=[84.4,0,4.7],VPT=[2.44496,6.53317,14.6135],VPD = 126): "checkers" texture with large border.  
//   tex = texture("checkers",border=0.25);
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): **"cones"** (VNF) = Raised conical spikes.  Specify `$fn` to set the number of segments on the cone (this is rounded to a multiple of 4).  The default is `$fn=16`.  Note that `$fa` and `$fs` are ignored, since the scale of the texture is unknown at the time of definition.  Giving `border=` specifies the horizontal border width between the edge of the tile and the base of the cone.  The `border` value must be nonnegative and smaller than 0.5.  Default: 0.
//   tex = texture("cones", $fn=16);
//   linear_sweep(
//       rect(30), texture=tex, h=30, tex_depth=3,
//       tex_size=[10,10]
//   );
// Example(3D): **"cubes"** (VNF) = Corner-cubes texture.  This texture needs to be scaled in vertically by sqrt(3) to have its correct aspect
//   tex = texture("cubes");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "cubes" texture at the correct scale.  
//   tex = texture("cubes");
//   linear_sweep(
//       rect(30), texture=tex, h=20*sqrt(3), tex_depth=3,
//       tex_size=[10,10*sqrt(3)]
//   );
// Example(3D): **"diamonds"** (Heightfield) = Four-sided pyramid with the corners of the base aligned with the axes.  Compare to "pyramids".  Useful for knurling.  Giving `n=` sets the number of heightfield samples to `n x n`. Default: 2.  Use `style="concave"` for pointed bumps, or `style="default"` or `style="alt"` for a diagonal ribs.  
//   tex = texture("diamonds");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10], style="concave"
//   );
// Example(3D): "diamonds" texture can give diagonal ribbing with "default" style. 
//   tex = texture("diamonds");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10], style="default"
//   );
// Example(3D): "diamonds" texture gives diagonal ribbing the other direction with "alt" style.  
//   tex = texture("diamonds");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10], style="alt"
//   );
// Example(3D): **"diamonds_vnf"** (VNF) = VNF version of "diamonds".
//   tex = texture("diamonds_vnf");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): **"dots"** (VNF) = Raised round bumps.  Specify `$fn` to set the number of segments on the dots (this is rounded to a multiple of 4).  The default is `$fn=16`.  Note that `$fa` and `$fs` are ignored, since the scale of the texture is unknown at the time of definition.  Giving `border=` specifies the horizontal width of the flat border region between the tile edge and the edge of the dots.  Must be nonnegative and strictly less than 0.5.  Default: 0.05.
//   tex = texture("dots", $fn=16);
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_depth=2, tex_size=[10,10]
//   );
// Example(3D): "dots" (VNF) = You can use the "dots" texture to create dimples (which used to exist as a separate texture) by specifying `tex_inset` and a negative `tex_depth`, which inverts the texture.
//   tex = texture("dots", $fn=16);
//   linear_sweep(
//       rect(30), texture=tex, h=30, tex_depth=-2,
//       tex_inset=1, tex_size=[10,10]
//   );
// Example(3D): **"hex_grid"** (VNF) = A hexagonal grid defined by V-grove borders.  Giving `border=` specifies that the top face of the hexagon is smaller than the bottom by `border` on the left and right sides.  This means the V-groove top width for grooves running parallel to the Y axis are double the border value.  If the texture is scaled in the Y direction by sqrt(3) then the groove is uniform on all six sides of the hexagon.  Border must be strictly between 0 and 0.5, default: 0.1.
//   tex = texture("hex_grid");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "hex_grid" texture with large border
//   tex = texture("hex_grid", border=0.4);
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "hex_grid" scaled in Y by sqrt(3) so hexagons are regular and grooves are all the same width.  Note height of cube is also scaled so tile fits without being automatically adjusted to fit, ruining our choice of scale.
//   tex = texture("hex_grid",border=.07);
//   linear_sweep(
//       rect(30), texture=tex, h=quantup(30,10*sqrt(3)),
//       tex_size=[10,10*sqrt(3)], tex_depth=3
//   );
// Example(3D): "hex_grid" texture, with approximate scaling because 17 is close to sqrt(3) times 10.
//   tex = texture("hex_grid");
//   linear_sweep(
//       rect(30), texture=tex, h=34,
//       tex_size=[10,17]
//   );
// Example(3D): **"hills"** (Heightfield) = Wavy sine-wave hills and valleys,  Giving `n=` sets the number of heightfield samples to `n` x `n`.  Default: 12.  Set `style="quincunx"`.
//   tex = texture("hills");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10], style="quincunx"
//   );
// Example(3D): **"pyramids"** (Heightfield) = Four-sided pyramid with the edges of the base aligned with the axess.  Compare to "diamonds". Useful for knurling.  Giving `n=` sets the number of heightfield samples to `n` by `n`. Default: 2. Set style to "convex".  Note that style="concave" or style="min_edge" produce mini-diamonds with flat squares in between.
//   tex = texture("pyramids");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10], style="convex"
//   );
// Example(3D): "pyramids" texture, with "concave" produces a mini-diamond texture.  Note that "min_edge" also gives this result.
//   tex = texture("pyramids");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10], style="concave"
//   );
// Example(3D): **"pyramids_vnf"** (VNF) = VNF version of "pyramids".
//   tex = texture("pyramids_vnf");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): **"ribs"** (Heightfield) = Vertically aligned triangular ribs.  Giving `n=` sets the number of heightfield samples to `n` by 1.  Default: 2.  The choice of style does not matter.
//   tex = texture("ribs");
//   linear_sweep(
//       rect(30), texture=tex, h=30, tex_depth=3,
//       tex_size=[10,10], style="concave"
//   );
// Example(3D): **"rough"** (Heightfield) = A pseudo-randomized rough texture.  Giving `n=` sets the number of heightfield samples to `n` by `n`.  Default: 32.  The texture is filled with random values ranging from 0 to 1.  To control the height of the random texture use the `tex_depth` parameter.  
//   tex = texture("rough");
//   linear_sweep(
//       rect(30), texture=tex, h=30, tex_depth=0.2,
//       tex_size=[10,10], style="min_edge"
//   );
// Example(3D): **"tri_grid"** (VNF) = A triangular grid defined by V-groove borders  Giving `border=` specifies that the top face of the triangular surface is smaller than the bottom by `border` along the horizontal edges (parallel to the X axis).  This means the V-groove top width of the grooves parallel to the X axis are double the border value.  (The other grooves are wider.) If the tile is scaled in the Y direction by sqrt(3) then the groove is uniform on the three sides of the triangle.  The border must be strictly between 0 and 1/6, default: 0.05.
//   tex = texture("tri_grid");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "tri_grid" texture with large border.  (Max border for tri_grid is 1/6.)  
//   tex = texture("tri_grid",border=.12);
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "tri_grid" texture scaled in Y by sqrt(3) so triangles are equilateral and grooves are all the same width.  Note we have to ensure the height evenly fits the scaled texture tiles.
//   tex = texture("tri_grid",border=.04);
//   linear_sweep(
//       rect(30), texture=tex, h=quantup(30,10*sqrt(3)),
//       tex_size=[10,10*sqrt(3)], tex_depth=3
//   );
// Example(3D): "tri_grid" texture.  Here scale makes Y approximately sqrt(3) larger than X so triangles are close to equilateral.
//   tex = texture("tri_grid");
//   linear_sweep(
//       rect(30), texture=tex, h=34,
//       tex_size=[10,17]
//   );
// Example(3D): **"trunc_diamonds"** (VNF) = Truncated diamonds, four-sided pyramids with the base corners aligned with the axes and the top cut off.  Or you can interpret it as V-groove lines at 45º angles.  Giving `border=` specifies that the width and height of the top surface of the diamond are smaller by `border` at the left, right, top, and bottom.  The border is measured in the **horizontal** direction.  This means the V-groove width is sqrt(2) times the border value.  The border must be strictly between 0 and sqrt(2)/4, which is about 0.35.  Default: 0.1.
//   tex = texture("trunc_diamonds");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "trunc_diamonds" texture with large border. 
//   tex = texture("trunc_diamonds",border=.25);
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): **"trunc_pyramids"** (Heightfield) = Truncated pyramids, four sided pyramids with the base edges aligned to the axes and the top cut off.  Giving `n=` sets the number of heightfield samples to `n` by `n`.  Default: 6.  Set `style="convex"`.
//   tex = texture("trunc_pyramids");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10], style="convex"
//   );
// Example(3D): **"trunc_pyramids_vnf"** (VNF) = Truncated pyramids, four sided pyramids with the base edges aligned to the axes and the top cut off.  You can also regard this as a grid of V-grooves.  Giving `border=` specifies that the top face is smaller than the top by `border` on all four sides.  This means the V-groove top width is double the border value.  The border must be strictly between 0 and 0.5.  Default: 0.1.
//   tex = texture("trunc_pyramids_vnf");
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): "trunc_pyramids_vnf" texture with large border
//   tex = texture("trunc_pyramids_vnf", border=.4);
//   linear_sweep(
//       rect(30), texture=tex, h=30,
//       tex_size=[10,10]
//   );
// Example(3D): **"trunc_ribs"** (Heightfield) = Truncated ribs.  Vertically aligned triangular ribs with the tops cut off, and with rib separation equal to the width of the flat tops.  Giving `n=` sets the number of heightfield samples to `n` by `1`.  Default: 4.  The style does not matter.
//   tex = texture("trunc_ribs");
//   linear_sweep(
//       rect(30), h=30, texture=tex,
//       tex_depth=3, tex_size=[10,10],
//       style="concave"
//   );
// Example(3D): **"trunc_ribs_vnf"** (VNF) = Vertically aligned triangular ribs with the tops cut off.  Giving `gap=` sets the bottom gap between ribs.  Giving `border=` specifies that the top rib face is smaller than its base by `border` on both the left and right sides.  The gap measures the flat part between ribs and the border the width of the sloping portion. In order to fit, gap+2*border must be less than 1.  (This is because the gap is counted once but the border counts on both sides.)  Defaults: gap=1/4, border=1/4.
//   tex = texture("trunc_ribs_vnf", gap=0.25, border=1/6);
//   linear_sweep(
//       rect(30), h=30, texture=tex,
//       tex_depth=3, tex_size=[10,10]
//   );
// Example(3D): **"wave_ribs"** (Heightfield) = Vertically aligned wavy ribs.  Giving `n=` sets the number of heightfield samples to `n` by `1`.  Default: 8.  The style does not matter.  
//   tex = texture("wave_ribs");
//   linear_sweep(
//       rect(30), h=30, texture=tex, 
//       tex_size=[10,10], tex_depth=3, style="concave"
//   );
function _tex_fn_default() = 16;

function texture(tex, n, border, gap, roughness, inset) =
    assert(num_defined([border,inset])<2, "In texture() the 'inset' parameter has been replaced by 'border'.  You cannot give both parameters.")
    let(
        border = is_def(inset)?echo("In texture() the argument 'inset' has been deprecated and will be removed.  Use 'border' instead")
                               inset
                              :border
    )
    assert(is_undef(n) || all_positive([n]), "\nn must be a positive value if given.")
    assert(is_undef(border) || is_finite(border), "\nborder must be a number if given.")
    assert(is_undef(gap) || is_finite(gap), "\ngap must be a number if given.")
    assert(is_undef(roughness) || all_nonnegative([roughness]), "\nroughness must be a nonnegative value if given.")  
    tex=="ribs"?
        assert(num_defined([gap, border, roughness])==0, "\nribs texture does not accept gap, border, or roughness.")

        let(
            n = quantup(default(n,2),2)
        ) [[
            each lerpn(1,0,n/2,endpoint=false),
            each lerpn(0,1,n/2,endpoint=false),
        ]] :
    tex=="trunc_ribs"?
        assert(num_defined([gap, border, roughness])==0, "\ntrunc_ribs texture does not accept gap, border, or roughness.")
        let(
            n = quantup(default(n,4),4)
        ) [[
            each repeat(0,n/4),
            each lerpn(0,1,n/4,endpoint=false),
            each repeat(1,n/4),
            each lerpn(1,0,n/4,endpoint=false),
        ]] :
    tex=="trunc_ribs_vnf"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))
        let(
            border = default(border,1/4)*2,
            gap = default(gap,1/4)
        )
        assert(all_nonnegative([border,gap]), "\ntrunc_ribs_vnf texture requires gap>=0 and border>=0.")
        assert(gap+border <= 1, "\ntrunc_ribs_vnf texture requires that 2*border+gap <= 1.")
        [
            [
               each move([0.5,0.5], p=path3d(rect([1-gap,1]),0)),
               each move([0.5,0.5], p=path3d(rect([1-gap-border,1]),1)),
               each path3d(square(1)),
            ], [
                [4,7,3,0], [1,2,6,5],
                if (gap+border < 1-_EPSILON) [4,5,6,7],
                if (gap > _EPSILON) each [[1,9,10,2], [0,3,11,8]],
            ]
        ] :
    tex=="wave_ribs"?
        assert(num_defined([gap, border, roughness])==0, "\nwave_ribs texture does not accept gap, border, or roughness.")
        let(
            n = max(6,default(n,8))
        ) [[
            for(a=[0:360/n:360-_EPSILON])
            (cos(a)+1)/2
        ]] :
    tex=="diamonds"?
        assert(num_defined([gap, border, roughness])==0, "\ndiamonds texture does not accept gap, border, or roughness.")
        let(
            n = quantup(default(n,2),2)
        ) [
            let(
                path = [
                    each lerpn(0,1,n/2,endpoint=false),
                    each lerpn(1,0,n/2,endpoint=false),
                ]
            )
            for (i=[0:1:n-1]) [
                for (j=[0:1:n-1]) min(
                    select(path,i+j),
                    select(path,i-j)
                )
            ],
        ] :
    tex=="diamonds_vnf"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))
        assert(num_defined([gap, border, roughness])==0, "\ndiamonds_vnf texture does not accept gap, border, or roughness.")
        [
            [
                [0,   1, 1], [1/2,   1, 0], [1,   1, 1],
                [0, 1/2, 0], [1/2, 1/2, 1], [1, 1/2, 0],
                [0,   0, 1], [1/2,   0, 0], [1,   0, 1],
            ], [
                [0,1,3], [2,5,1], [8,7,5], [6,3,7],
                [1,5,4], [5,7,4], [7,3,4], [4,3,1],
            ]
        ] :
    tex=="pyramids"?
        assert(num_defined([gap, border, roughness])==0, "\npyramids texture does not accept gap, border, or roughness.")
        let(
            n = quantup(default(n,2),2)
        ) [
            for (i = [0:1:n-1]) [
                for (j = [0:1:n-1])
                1 - (max(abs(i-n/2), abs(j-n/2)) / (n/2))
            ]
        ] :
    tex=="pyramids_vnf"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))
        assert(num_defined([gap, border, roughness])==0, "\npyramids_vnf texture does not accept gap, border, or roughness.")
        [
            [ [0,1,0], [1,1,0], [1/2,1/2,1], [0,0,0], [1,0,0] ],
            [ [2,0,1], [2,1,4], [2,4,3], [2,3,0] ]
        ] :
    tex=="trunc_pyramids"?
        assert(num_defined([gap, border, roughness])==0, "\ntrunc_pyramids texture does not accept gap, border, or roughness.")
        let(
            n = quantup(default(n,6),3)
        ) [
            for (i = [0:1:n-1]) [
                for (j = [0:1:n-1])
                (1 - (max(n/6, abs(i-n/2), abs(j-n/2)) / (n/2))) * 1.5
            ]
        ] :
    tex=="trunc_pyramids_vnf"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))
        assert(num_defined([gap, roughness])==0, "\ntrunc_pyramids_vnf texture does not accept gap or roughness.")
        let(
            border = default(border,0.1)
        )
        assert(border>0 && border<.5, "\ntrunc_pyramids_vnf texture requires border in (0,0.5).")
        [
            [
                each path3d(square(1)),
                each move([1/2,1/2,1], p=path3d(rect(1-2*border))),
            ], [
                for (i=[0:3])
                    [i, (i+1)%4, (i+1)%4+4,i+4],
                [4,5,6,7]
            ]
        ] :
    tex=="hills"?
        assert(num_defined([gap, border, roughness])==0, "\nhills texture does not accept gap, border, or roughness.")
        let(
            n = default(n,12)
        ) [
            for (a=[0:360/n:359.999]) [
                for (b=[0:360/n:359.999])
                (cos(a)*cos(b)+1)/2
            ]
        ] :
    tex=="bricks"?
        assert(num_defined([gap,border])==0, "\nbricks texture does not accept gap or border.")
        let(
            n = quantup(default(n,24),2),
            rough = default(roughness,0.1)
        ) [
            for (y = [0:1:n-1])
               let(rand = rands(1-rough, 1, n, seed=12345+y*678))
               [
                for (x = [0:1:n-1])
                   (y%(n/2) <= max(1,n/16)) ? 0 :
                      let( even = floor(y/(n/2))%2 ? n/2 : 0 )
                        (x+even) % n <= max(1,n/16)? 0 : rand[x]
            ]
        ] :
    tex=="bricks_vnf"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))
        assert(num_defined([roughness])==0, "\nbricks_vnf texture does not accept roughness.")
        let(
            border = default(border,0.05),
            gap = default(gap,0.05)
        )
        assert(border>=0,"\nbricks_vnf texture requires nonnegative border.")
        assert(gap>0, "\nbricks_vnf requires gap greater than 0.")
        assert(gap+border<0.5, "\nbricks_vnf requires gap+border < 0.5.")
          [
            [
                each path3d(square(1)),
                each move([gap/2, gap/2, 0], p=path3d(square([1-gap, 0.5-gap]))),
                each move([gap/2+border/2, gap/2+border/2, 1], p=path3d(square([1-gap-border, 0.5-gap-border]))),
                each move([0, 0.5+gap/2, 0], p=path3d(square([0.5-gap/2, 0.5-gap]))),
                each move([0, 0.5+gap/2+border/2, 1], p=path3d(square([0.5-gap/2-border/2, 0.5-gap-border]))),
                each move([0.5+gap/2, 0.5+gap/2, 0], p=path3d(square([0.5-gap/2, 0.5-gap]))),
                each move([0.5+gap/2+border/2, 0.5+gap/2+border/2, 1], p=path3d(square([0.5-gap/2-border/2, 0.5-gap-border]))),
            ], [
                [0,4,7,20], [4,8,11,7], [9,8,4,5], [4,0,1,5], [10,9,5,6],
                [20,7,6,13,12,21] ,[2,3,23,22,15,14], [15,19,18,14], [22,23,27,26], [16,19,15,12],[13,6,5,1],
                [26,25,21,22], [8,9,10,11],[7,11,10,6],[17,16,12,13],[22,21,12,15],[16,17,18,19],[24,25,26,27],[25,24,20,21]
            ]
        ] :
    tex=="checkers"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))
        assert(num_defined([gap, roughness])==0, "\ncheckers texture does not accept gap or roughness")
        let(
            border = default(border,0.05)
        )
        assert(border>0 && border<.5, "\ncheckers texture requires border in (0,0.5).")
          [
            [
                each move([0,0], p=path3d(square(0.5-border),1)),
                each move([0,0.5], p=path3d(square(0.5-border))),
                each move([0.5,0], p=path3d(square(0.5-border))),
                each move([0.5,0.5], p=path3d(square(0.5-border),1)),
                [1/2-border/2,1/2-border/2,1/2], [0,1,1], [1/2-border,1,1],
                [1/2,1,0], [1-border,1,0], [1,0,1], [1,1/2-border,1],
                [1,1/2,0], [1,1-border,0], [1,1,1], [1/2-border/2,1-border/2,1/2],
                [1-border/2,1-border/2,1/2], [1-border/2,1/2-border/2,1/2],
            ], [
                for (i=[0:4:12]) each [[i,i+1,i+2,i+3]],
                [10,16,13,12,28,11],[9,0,3,16,10], [11,28,22,21,8],
                [4,7,26,14,13,16], [7,6,17,18,26], [5,4,16,3,2],
                [19,20,27,15,14,26], [20,25,27], [19,26,18],
                [23,28,12,15,27,24], [23,22,28], [24,27,25]
            ]
        ] :
    tex=="cones"?
        assert(is_undef(n),str("\nTo set number of segments on cones use $fn. ", tex,__vnf_no_n_mesg))
        assert(num_defined([gap,roughness])==0, "\ncones texture does not accept gap or roughness.")  
        let(
            border = default(border,0),
            n = $fn > 0 ? quantup($fn,4) : _tex_fn_default()
        )
        assert(border>=0 && border<0.5)
        [
            [
                each move([1/2,1/2], p=path3d(circle(d=1-2*border,$fn=n))),
                [1/2,1/2,1],
                each border>0 ? path3d(subdivide_path(square(1),refine=2,closed=true))
                              : path3d(square(1))
            ], [
                for (i=[0:1:n-1]) [i, (i+1)%n, n],
                if (border>0) for (i=[0:3]) [for(j=[(i+1)*n/4:-1:i*n/4]) j%n,
                                            (2*i+7)%8+n+1,(2*i)%8+n+1, (2*i+1)%8+n+1],
                if (border==0) for (i=[0:3]) [for(j=[(i+1)*n/4:-1:i*n/4]) j%n, i+n+1]
            ]
        ] :
    tex=="cubes"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))
        assert(num_defined([gap, border, roughness])==0, "\ncubes texture does not accept gap, border, or roughness.")  
        [
            [
                [0,1,1/2], [1,1,1/2], [1/2,5/6,1], [0,4/6,0], [1,4/6,0],
                [1/2,3/6,1/2], [0,2/6,1], [1,2/6,1], [1/2,1/6,0], [0,0,1/2],
                [1,0,1/2],
            ], [
                [0,1,2], [0,2,3], [1,4,2], [2,5,3], [2,4,5],
                [6,3,5], [4,7,5], [7,8,5], [6,5,8], [10,8,7],
                [9,6,8], [10,9,8],
            ]
        ] :
    tex=="trunc_diamonds"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))  
        assert(num_defined([gap, roughness])==0, "\ntrunc_diamonds texture does not accept gap or roughness.")
        let(
            border = default(border,0.1)/sqrt(2)*2
        )
        assert(border>0 && border<0.5)
        [
            [
                each move([1/2,1/2,0], p=path3d(circle(d=1,$fn=4))),
                each move([1/2,1/2,1], p=path3d(circle(d=1-border*2,$fn=4))),
                for (a=[0:90:359]) each move([1/2,1/2], p=zrot(-a, p=[[1/2,border,1], [border,1/2,1], [1/2,1/2,1]]))
            ], [
                for (i=[0:3]) each let(j=i*3+8) [
                    [i,(i+1)%4,(i+1)%4+4,i+4],
                    [j,j+1,j+2], [i, (i+3)%4,j+1, j], 
                ],
                [4,5,6,7],
            ]
        ] :
    tex=="dimples" ? assert(false, "\nThe dimples texture has been removed; use \"dots\" with 'tex_inset=1' and negative 'tex_depth' instead.") 0 : 
    tex=="dots" ?
        assert(is_undef(n),str("\nTo set number of segments on ",tex," use $fn. ", tex,__vnf_no_n_mesg))
        assert(num_defined([gap,roughness])==0, str("\n",tex," texture does not accept gap or roughness."))
        let(
            border = default(border,0.05),
            n = $fn > 0 ? quantup($fn,4) : _tex_fn_default()
        )
        assert(border>=0 && border < 0.5)
        let(
            rows=ceil(n/4),
            r=adj_ang_to_hyp(1/2-border,45),
            dots = true,
            cp = [1/2, 1/2, -r*sin(45)],
            sc = 1 / (r - abs(cp.z)),
            uverts = [
                for (p=[0:1:rows-1], t=[0:360/n:359.999])
                    cp + spherical_to_xyz(r, -t, 45-45*p/rows),
                cp + r * UP, 
                each border>0 ? path3d(subdivide_path(square(1),refine=2,closed=true))
                              : path3d(square(1)),
                      
            ],
            verts = zscale(sc, p=uverts),
            faces = [
                for (i=[0:1:rows-2], j=[0:1:n-1]) each [
                    [i*n+j, i*n+(j+1)%n, (i+1)*n+(j+1)%n,(i+1)*n+j],
                ],
                for (i=[0:1:n-1]) [(rows-1)*n+i, (rows-1)*n+(i+1)%n, rows*n],
                if (border>0) for (i=[0:3]) [for(j=[(i+1)*n/4:-1:i*n/4]) j%n,
                                            (2*i+7)%8+rows*n+1,(2*i)%8+rows*n+1, (2*i+1)%8+rows*n+1],
                if (border==0) for (i=[0:3]) [for(j=[(i+1)*n/4:-1:i*n/4]) j%n, i+rows*n+1]
            ]
        ) [verts, faces] :
    tex=="tri_grid"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))  
        assert(num_defined([gap, roughness])==0, str("\n",tex," texture does not accept gap or roughness."))  
        let(
            border = default(border,0.05)*sqrt(3)
        )
        assert(border>0 && border<sqrt(3)/6, "\ntri_grid texture requires border in (0,1/6).")
        let(
            adj = opp_ang_to_adj(border, 30),
            y1 = border / adj_ang_to_opp(1,60),     // i/sqrt(3)
            y2 = 2*y1,            // 2*i/sqrt(3)
            y3 = 0.5 - y1,
            y4 = 0.5 + y1,
            y5 = 1 - y2,
            y6 = 1 - y1
        )
        [
            [
                [0,0,0], [1,0,0],
                [adj,y1,1], [1-adj,y1,1],
                [0,y2,1], [1,y2,1],
                [0.5,0.5-y2,1],
                [0,y3,1], [0.5-adj,y3,1], [0.5+adj,y3,1], [1,y3,1],
                [0,0.5,0], [0.5,0.5,0], [1,0.5,0],
                [0,y4,1], [0.5-adj,y4,1], [0.5+adj,y4,1], [1,y4,1],
                [0.5,0.5+y2,1],
                [0,y5,1], [1,y5,1],
                [adj,y6,1], [1-adj,y6,1],
                [0,1,0], [1,1,0],
            ], [
               [0,2,3,1],
               [21,23,24,22],
               [2,6,3], [0,12,6,2], [1,3,6,12],
               [0,4,8,12], [4,7,8], [8,7,11,12],
               [1,12,9,5], [5,9,10], [10,9,12,13], 
               [11,14,15,12], [19,15,14], [19,23,12,15],
               [16,17,13,12], [16,20,17], [12,24,20,16], 
               [21,22,18], [12,23,21,18],
               [12,18,22,24],
            ]
        ] :
    tex=="hex_grid"?
        assert(is_undef(n), str(tex,__vnf_no_n_mesg))  
        assert(num_defined([gap, roughness])==0, str("\n",tex," texture does not accept gap or roughness."))
        let(
            border=default(border,0.1)
        )
        assert(border>0 && border<0.5)
        let(
            diag=opp_ang_to_hyp(border,60),
            side=adj_ang_to_opp(1,30),
            hyp=adj_ang_to_hyp(0.5,30),
            sc = 1/3/hyp,
            hex=[ [1,2/6,0], [1/2,1/6,0], [0,2/6,0], [0,4/6,0], [1/2,5/6,0], [1,4/6,0] ]
        ) [
            [
                each hex,
                each move([0.5,0.5], p=yscale(sc, p=path3d(ellipse(d=1-2*border, circum=true, realign=false, spin=-30,$fn=6),1))),
                hex[0]-[0,diag*sc,-1],
                for (ang=[270+60,270-60]) hex[1]+yscale(sc, p=cylindrical_to_xyz(diag,ang,1)),
                hex[2]-[0,diag*sc,-1],
                [0,0,1], [0.5-border,0,1], [0.5,0,0], [0.5+border,0,1], [1,0,1],
                hex[3]+[0,diag*sc,1],
                for (ang=[90+60,90-60]) hex[4]+yscale(sc, p=cylindrical_to_xyz(diag,ang,1)),
                hex[5]+[0,diag*sc,1],
                [0,1,1], [0.5-border,1,1], [0.5,1,0], [0.5+border,1,1], [1,1,1],
            ], [
                count(6,s=6),
                for (i=[0:1:5]) [i,(i+1)%6, (i+1)%6+6, i+6],
                [20,19,13,12], [17,16,15,14],
                [21,25,26,22], [23,28,29,24],
                [0,12,13,1], [1,14,15,2],
                [3,21,22,4], [4,23,24,5],
                [1,13,19,18], [1,18,17,14], 
                [4,22,26,27], [4,27,28,23],
            ]
        ] :
    tex=="rough"?
        assert(num_defined([gap,border])==0, str("\n",tex," texture does not accept gap or border."))
        assert(num_defined([roughness])==0, str("\n",tex," texture no longer accepts 'roughness'. Use tex_depth to control roughness (0.2 was the old default)."))  
        let(
            n = default(n,32)
        ) [
            for (y = [0:1:n-1])
            rands(0, 1, n, seed=123456+29*y)
        ] :
    assert(false, str("\nUnrecognized texture name: ", tex));

/// Function&Module: _textured_linear_sweep()
/// Usage: As Function
///   vnf = _textured_linear_sweep(region, texture, tex_size, h, ...);
///   vnf = _textured_linear_sweep(region, texture, counts=, h=, ...);
/// Usage: As Module
///   _textured_linear_sweep(region, texture, tex_size, h, ...) [ATTACHMENTS];
///   _textured_linear_sweep(region, texture, counts=, h=, ...) [ATTACHMENTS];
/// Topics: Sweep, Extrusion, Textures, Knurling
/// Description:
///   Given a [[Region|regions.scad]], creates a linear extrusion of it vertically, optionally twisted, scaled, and/or shifted,
///   with a given texture tiled evenly over the side surfaces.  The texture can be given in one of three ways:
///   - As a texture name string. (See {{texture()}} for supported named textures.)
///   - As a 2D array of evenly spread height values. (AKA a heightfield.)
///   - As a VNF texture tile.  A VNF tile exactly defines a surface from `[0,0]` to `[1,1]`, with the Z coordinates
///     being the height of the texture point from the surface.  VNF tiles MUST be able to tile in both X and Y
///     directions with no gaps, with the front and back edges aligned exactly, and the left and right edges as well.
///   . 
///   One script to convert a grayscale image to a texture heightfield array in a .scad file can be found at:
///   https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/scripts/img2scad.py
/// Arguments:
///   region = The [[Region|regions.scad]] to sweep/extrude.
///   texture = A texture name string, or a rectangular array of scalar height values (0.0 to 1.0), or a VNF tile that defines the texture to apply to vertical surfaces.  See {{texture()}} for what named textures are supported.
///   tex_size = An optional 2D target size for the textures.  Actual texture sizes are scaled somewhat to evenly fit the available surface. Default: `[5,5]`
///   h / l = The height to extrude/sweep the path.
///   ---
///   counts = If given instead of tex_size, gives the tile repetition counts for textures over the surface length and height.
///   inset = If numeric, lowers the texture into the surface by that amount, before the tex_scale multiplier is applied.  If `true`, insets by exactly `1`.  Default: `false`
///   rot = If true, rotates the texture 90º.
///   tex_scale = Scaling multiplier for the texture depth.
///   twist = Degrees of twist for the top of the extrustion/sweep, compared to the bottom.  Default: 0
///   scale = Scaling multiplier for the top of the extrustion/sweep, compared to the bottom.  Default: 1
///   shift = [X,Y] amount to translate the top, relative to the bottom.  Default: [0,0]
///   style = The triangulation style used.  See {{vnf_vertex_array()}} for valid styles.  Used only with heightfield type textures. Default: `"min_edge"`
///   samples = Minimum number of "bend points" to have in VNF texture tiles.  Default: 8
///   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
///   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
///   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
/// Named Anchors:
///   "centroid_top" = The centroid of the top of the shape, oriented UP.
///   "centroid" = The centroid of the center of the shape, oriented UP.
///   "centroid_bot" = The centroid of the bottom of the shape, oriented DOWN.
function _get_vnf_tile_edges(texture) =
    let(
        verts = texture[0],
        faces = texture[1],
        everts = [for (v = verts) (v.x==0 || v.y==0 || v.x==1 || v.y==1)],
        uc = unique_count([
            for (face = faces, i = idx(face))
            let(edge = select(face,i,i+1), i1 = min(edge), i2 = max(edge))
            if (everts[i1] && everts[i2])
            [i1, i2]
        ]),
        edges = uc[0], counts = uc[1],
        uedges = [for (i = idx(edges)) if (counts[i] == 1) edges[i] ]
    ) uedges;

function _validate_texture(texture) =
    is_vnf(texture)
      ? let( // Validate VNF tile texture
            bounds = pointlist_bounds(texture[0]),
            min_xy = point2d(bounds[0]),
            max_xy = point2d(bounds[1])
        )
        assert(all_nonnegative(concat(min_xy,[1,1]-max_xy)), "\nVNF tile X and Y components must be between 0 and 1.")
        let(
            verts = texture[0],
            uedges = _get_vnf_tile_edges(texture),
            edge_verts = [for (i = unique(flatten(uedges))) verts[i] ],
            hverts = [for(v = edge_verts) if(v.x==0 || v.x==1) v],
            vverts = [for(v = edge_verts) if(v.y==0 || v.y==1) v],
            allgoodx = all(hverts, function(v) any(hverts, function(w) approx(w,[1-v.x, v.y, v.z]))),
            allgoody = all(vverts, function(v) any(vverts, function(w) approx(w,[v.x, 1-v.y, v.z])))
        )
        assert(allgoodx && allgoody, "\nAll VNF tile edge vertices must line up with a vertex on the opposite side of the tile.")
        true
      : // Validate heightfield texture.
        assert(is_matrix(texture), "\nMalformed texture.")
        let( tex_dim = list_shape(texture) )
        assert(len(tex_dim) == 2, "\nHeightfield texture must be a 2D square array of scalar heights.")
        assert(all_defined(tex_dim), "\nHeightfield texture must be a 2D square array of scalar heights.")
        true;

function _tex_height(scale, inset, z) =  scale<0 ? -(1-z - inset) * scale
                                                 :  (z - inset) * scale;

function _get_texture(texture, tex_rot) =
    let(
         tex_rot=!is_bool(tex_rot)? tex_rot
                : echo("boolean value for tex_rot is deprecated.  Use a numerical angle divisible by 90.") tex_rot?90:0
    )
    assert(is_num(tex_rot) && posmod(tex_rot,90)==0, "\ntex_rot must be a multiple of 90 degrees.")
    let(
        tex = is_string(texture)? texture(texture,$fn=_tex_fn_default()) : texture,
        check_tex = _validate_texture(tex),       
        tex_rot = posmod(tex_rot,360)
    )
    tex_rot==0 ? tex
  : is_vnf(tex)? zrot(tex_rot, cp=[1/2,1/2], p=tex)
  : tex_rot==180? reverse([for (row=tex) reverse(row)])
  : tex_rot==270? [for (row=transpose(tex)) reverse(row)]
  : reverse(transpose(tex));

// Given a VNF texture tile finds the paths on either the x=0 (axis=0) or the y=0 (axis=1) cases.
// Would also find the z=0 paths if you gave axis=2.
//
// It returns two lists, a list of open paths and a list of closed paths.  By default a max of
// one open path is permitted; either list can be empty.  The paths go in the direction of the segments
// in the VNF.
function _tile_edge_path_list(vnf, axis, maxopen=1) =
    let(
        verts = vnf[0],
        faces = vnf[1],
        segs = [for(face=faces, edge=pair(select(verts,face),wrap=true)) if (approx(edge[0][axis],0) && approx(edge[1][axis],0)) [edge[1],edge[0]]],
        paths = _assemble_partial_paths(segs),
        closedlist = [
            for(path=paths)
              if (len(path)>3 && approx(path[0],last(path))) list_unwrap(path)
        ],
        openlist = [
            for(path=paths)
              if (path[0]!=last(path)) path
        ]
    )
    assert(len(openlist)<=1, str("\nVNF has ",len(openlist)," open paths on an edge and at most ",maxopen," is supported."))
    [openlist,closedlist];

/// Function&Module: _textured_revolution()
/// Usage: As Function
///   vnf = _textured_revolution(shape, texture, tex_size, [tex_scale=], ...);
///   vnf = _textured_revolution(shape, texture, counts=, [tex_scale=], ...);
/// Usage: As Module
///   _textured_revolution(shape, texture, tex_size, [tex_scale=], ...) [ATTACHMENTS];
///   _textured_revolution(shape, texture, counts=, [tex_scale=], ...) [ATTACHMENTS];
/// Topics: Sweep, Extrusion, Textures, Knurling
/// Description:
///   Given a 2D region or path, fully in the X+ half-plane, revolves that shape around the Z axis (after rotating its Y+ to Z+).
///   This creates a solid from that surface of revolution, possibly capped top and bottom, with the sides covered in a given tiled texture.
///   The texture can be given in one of three ways:
///   - As a texture name string. (See {{texture()}} for supported named textures.)
///   - As a 2D array of evenly spread height values. (AKA a heightfield.)
///   - As a VNF texture tile.  A VNF tile exactly defines a surface from `[0,0]` to `[1,1]`, with the Z coordinates
///     being the height of the texture point from the surface.  VNF tiles MUST be able to tile in both X and Y
///     directions with no gaps, with the front and back edges aligned exactly, and the left and right edges as well.
///   .
///   One script to convert a grayscale image to a texture heightfield array in a .scad file can be found at:
///   https://raw.githubusercontent.com/BelfrySCAD/BOSL2/master/scripts/img2scad.py
/// Arguments:
///   shape = The path or region to sweep/extrude.
///   texture = A texture name string, or a rectangular array of scalar height values (0.0 to 1.0), or a VNF tile that defines the texture to apply to the revolution surface.  See {{texture()}} for what named textures are supported.
///   tex_size = An optional 2D target size for the textures.  Actual texture sizes are scaled somewhat to evenly fit the available surface. 
///   tex_scale = Scaling multiplier for the texture depth.
///   ---
///   inset = If numeric, lowers the texture into the surface by that amount, before the tex_scale multiplier is applied.  If `true`, insets by exactly `1`.  Default: `false`
///   rot = If true, rotates the texture 90º.
///   shift = [X,Y] amount to translate the top, relative to the bottom.  Default: [0,0]
///   closed = if true and the shape is a path then treat it as a closed path and make a torus.  If false then connect the path to the axis of rotation with horizontal caps that do not receive any specified texture.  If the shape is a region this option has no effect.  Default: `true`
///   taper = If given, and `closed=false`, tapers the texture height to zero over the first and last given percentage of the path.  If given as a lookup table with indices between 0 and 100, uses the percentage lookup table to ramp the texture heights.  Default: `undef` (no taper)
///   angle = The number of degrees counter-clockwise from X+ to revolve around the Z axis.  Default: `360`
///   style = The triangulation style used.  See {{vnf_vertex_array()}} for valid styles.  Used only with heightfield type textures. Default: `"min_edge"`
///   counts = If given instead of tex_size, gives the tile repetition counts for textures over the surface length and height.
///   samples = Minimum number of "bend points" to have in VNF texture tiles.  Default: 8
///   anchor = Translate so anchor point is at origin (0,0,0).  See [anchor](attachments.scad#subsection-anchor).  Default: `CENTER`
///   spin = Rotate this many degrees around the Z axis after anchor.  See [spin](attachments.scad#subsection-spin).  Default: `0`
///   orient = Vector to rotate top toward, after spin.  See [orient](attachments.scad#subsection-orient).  Default: `UP`
/// Anchor Types:
///   "hull" = Anchors to the virtual convex hull of the shape.
///   "intersect" = Anchors to the surface of the shape.
function _textured_revolution(
    shape, texture, tex_size, tex_scale=1,
    inset=false, rot=false, shift=[0,0],
    taper, closed=true, angle=360,
    inhibit_y_slicing,tex_aspect, pixel_aspect, 
    counts, samples, start=0,tex_extra,
    style="min_edge", atype="intersect",
    anchor=CENTER, spin=0, orient=UP
) =
    assert(is_path(shape,[2]) || is_region(shape))
    assert(is_undef(samples) || is_int(samples))
    assert(is_bool(closed))
    assert(counts==undef || is_int(counts) || (all_integer(counts) && len(counts)==2), "\ntex_reps must be an integer or list of two integers.")
    assert(tex_size==undef || is_vector(tex_size,2) || is_finite(tex_size))
    assert(is_bool(rot) || in_list(rot,[0,90,180,270]))
    assert(in_list(atype, _ANCHOR_TYPES), "\nAnchor type must be \"hull\" or \"intersect\".")
    assert(is_undef(tex_extra) || is_finite(tex_extra) || is_vector(tex_extra,2), "\ntex_extra must be a number of 2-vector.")
    assert(num_defined([tex_aspect, pixel_aspect])<=1, "\nCannot give both tex_aspect and pixel_aspect.")
    assert(is_undef(taper) || !closed, "\nCannot give tex_taper if caps=false.")
    //assert(num_defined([tex_aspect, pixel_aspect])==0 || is_undef(angle), "\nCannot give tex_aspect or pixel_aspect if you give angle.")
    let(
        inhibit_y_slicing = default(inhibit_y_slicing, is_path(shape) && len(shape)==2 ? true : false), 
        regions = !is_path(shape,2)? region_parts(shape)
                : closed? region_parts([shape]) 
                : let(
                      testpoly = [[0,shape[0].y], each shape, [0,last(shape).y]]
                  )
                  [[is_polygon_clockwise(testpoly) ? shape : reverse(shape)]],



        
        checks = [
            for (rgn=regions, path=rgn)
                assert(all(path, function(pt) pt.x>=0),"\nAll points in the shape must have non-negative x value."),
            //for(reg=regions, path=reg, edge=pair(path,wrap=closed))
            //              assert(edge[0].x>0 || edge[1].x>0,
            //                     str("\nThe shape cannot have any edges on the axis of rotation",closed?" (including the segment that closes the shape).":"."))
        ]
    )
    assert(closed || is_path(shape,2), "\ncaps=true is allowed only with paths")
    let(
        counts = is_undef(counts) ? undef : force_list(counts,2),
        tex_size = force_list(tex_size,2),
        texture = _get_texture(texture, rot),
        tex_extra_try = is_vnf(texture) ? [1,1]
                      : is_def(tex_extra) ? force_list(tex_extra,2)
                      : counts==[1,1] ? [0,0]
                      : [1,1],
        tex_extra = angle==360 ? [1,tex_extra_try.y] : tex_extra_try,
        dummy = assert(is_def(counts) || num_defined([pixel_aspect,tex_aspect])==0, "\nMust specify tex_counts (not tex_size) when using pixel_aspect or tex_aspect.")
                assert(is_undef(pixel_aspect) || !is_vnf(texture), "\nCannot give pixel_aspect with a VNF texture.")
                assert(is_undef(samples) || is_vnf(texture), "\nYou gave the tex_samples argument with a heightfield texture, which is not permitted.  Use the n= argument to texture() instead."),
        inset = is_num(inset)? inset : inset? 1 : 0,
        samples = !is_vnf(texture)? len(texture)
                : is_num(samples)? samples
                : 8,
        bounds = pointlist_bounds(flatten(flatten(regions))),
        maxx = bounds[1].x,
        miny = bounds[0].y,
        maxy = bounds[1].y,
        h = maxy - miny,
        circumf = 2 * PI * maxx,
        texcnt = is_vnf(texture) ? undef : [len(texture[0]), len(texture)],
        angle = num_defined([tex_aspect,pixel_aspect])==0 ? angle
              : let(
                     paths = flatten(regions),
                     lengths = [for(path=paths) path_length(path,closed=closed)],
                     ind = max_index(lengths),
                     rpath = resample_path(paths[ind], n=counts.y * samples + (closed?0:tex_extra.y), closed=closed),
                     h = path_length(rpath), 
                     r = mean(column(rpath,0)),
                     width = counts.x/counts.y * (is_def(pixel_aspect) ? (texcnt.x+tex_extra.x-1)/(texcnt.y+tex_extra.y-1) : tex_aspect) * h + (is_def(pixel_aspect)?1:0),
                     ang = 360 * width / (2*PI*r)
                )
                assert(ang<=360, str("\nAngle required for requested tile counts and aspect is ",ang, ", which exceeds 360°."))
                360 * width / (2*PI*r),

        tile = !is_vnf(texture) || samples==1 ? texture
             :
              let(
                  s = 1 / samples,
                  slices = list([s : s : 1-s/2]),
                  vnfx = vnf_slice(texture, "X", slices),
                  vnfy = inhibit_y_slicing? vnfx : vnf_slice(vnfx, "Y", slices),
                  zvnf = vnf_triangulate(vnf_quantize(vnfy,1e-4))
              ) zvnf,
        edge_paths = is_vnf(tile) ? _tile_edge_path_list(tile,1) : undef,
        edge_closed_paths = is_def(edge_paths) ? edge_paths[1] : [],
        side_paths = angle==360 || !is_vnf(tile) ? undef
                   : _tile_edge_path_list(tile,0),
        side_open_path = is_undef(side_paths) ? undef : len(side_paths[0])==0 ? [] : side_paths[0][0],
        side_closed_paths = is_undef(side_paths) ? [] : side_paths[1], 
        counts_x = is_def(counts)? counts.x : max(1,round(angle/360*circumf/tex_size.x)),
        adj_angle = is_vnf(texture)?angle
                  : angle*(1-(tex_extra.x-1)/(texcnt.x*counts_x+tex_extra.x-1)),  // adjusted angle for strip positions taking tex_extra into account
        taperfunc = closed || is_undef(taper)? function (x) 1
                  : is_finite(taper)?
                         let(
                              taper = taper<=1 ? taper
                                    : echo("The tex_taper now uses a value from 0-1.  Your entry was larger than 1 and has been scaled by 1/100.")
                                      taper/100
                         )
                         assert(taper>=0 && taper<=0.5, str("\ntex_taper must be between 0 and 0.5 but was ",taper,"."))
                         function (x) lookup(x, [[0,0],
                                                 if (taper==0.5) [taper,1]
                                                 else each [[taper+_EPSILON,1],[1-taper-_EPSILON,1]],
                                                 [1,0]])
                  : is_path(taper,2) ?
                         let(
                             taper = max(column(taper,0)) <= 1 ? taper
                                   : echo("The tex_taper table now uses values from 0-1. Your entry was larger than 1 and has been scaled by 1/100.")
                                     xscale(1/100,taper)
                         )
                         function(x) lookup(x,taper)
                  : is_function(taper) ? taper
                  : assert(false,"\ntex_taper must be a function, scalar, or list of pairs."),
        // Checks a path to see if it has segments on the Y axis.  More than 1 is an error.  If no segments return
        // path unchanged with closed=true.  If there is 1 segment, delete that segment (by rotating the path so it's
        // at the end) and return closed=false.  This prevents textures from continuing into the inside of a shape.  
        open_axis_paths = function(path,closed)
                            !closed ? [path,closed]
                          : let(
                               axind = [for(i=[0:1:len(path)-1]) if (approx(path[i].x,0) && approx(select(path,i+1).x,0)) i],
                               dummy = assert(len(axind)<=1, "\nFound path with more than 1 segment on the Y axis, which is not supported with texturing.")
                            )
                            len(axind)==0 ? [path,true]
                          :
                            [list_rotate(path, (axind[0]+1)%len(path)), false],
        transform_point = function(tileind, tilez, counts_y, bases, norms)
                             let(
                                 part = tileind * samples,
                                 ind = floor(part),
                                 frac = part - ind,
                                 base = lerp(select(bases,ind), select(bases,ind+1), frac),
                                 norm = unit(lerp(select(norms,ind), select(norms,ind+1), frac)),
                                 scale = tex_scale * taperfunc(1-tileind/counts_y) * base.x/maxx,
                                 texh = scale<0 ? -(1-tilez - inset) * scale
                                                :  (tilez - inset) * scale
                             )
                             base - norm * texh,
        full_vnf = vnf_join([
            for (rgn = regions) let(
                rgn_wall_vnf = vnf_join(
                   [for (path = rgn) let(
                        path_closed = open_axis_paths(path,closed),
                        path = path_closed[0],
                        closed = path_closed[1], 
                        plen = path_length(path, closed=closed),
                        counts_y = is_def(counts) ? counts.y : max(1,round(plen/tex_size.y)),
                        obases = resample_path(path, n=counts_y * samples + (closed?0:tex_extra.y), closed=closed),
                        onorms = path_normals(obases, closed=closed),
                        bases = xrot(90, p=path3d(obases)),
                        norms = xrot(90, p=path3d(onorms)),
                        vnf = is_vnf(texture)
                          ? let(strip=
                                  vnf_join([ // VNF tile texture
                                             for (j = [0:1:counts_y-1])
                                                [
                                                   [
                                                       for (vert = tile[0])
                                                            let(xyz = transform_point(j + (1-vert.y),vert.z,counts_y,bases, norms))
                                                            zrot(vert.x*angle/counts_x, p=xyz)
                                                   ],
                                                tile[1]
                                                ]
                                           ]),
                                full_wall = vnf_join([
                                              for (i = [0:1:counts_x-1])
                                                 zrot(i*angle/counts_x, strip)
                                            ])
                            )
                            full_wall
                          : let( // Heightfield texture
                                tiles = [
                                    for (j = [0,1], tj = [0:1:texcnt.x-1])
                                      if (j == 0 || tj < max(1,tex_extra.x))
                                        let(
                                            v = (j * texcnt.x + tj) / (texcnt.x*counts_x+tex_extra.x-1),
                                            mat = zrot(v*angle)
                                        )
                                        apply(mat, [
                                                    for (i = [0:1:counts_y-(closed?1:0)], ti = [0:1:texcnt.y-1])
                                                      if (i != counts_y || ti < tex_extra.y)
                                                         transform_point(i + (ti/texcnt.y),texture[ti][tj],counts_y, bases, norms)
                                               ])
                                ],
                                strip_pts = transpose(select(tiles,0,texcnt.x)),
                                last_pts = transpose(select(tiles,0,texcnt.x-1+tex_extra.x)),
                                strip_vnf = vnf_vertex_array(strip_pts, caps=false, style=style,col_wrap=false, row_wrap=closed),
                                last_vnf = vnf_vertex_array(last_pts, caps=false, style=style,col_wrap=false, row_wrap=closed),
                                full_wall = vnf_join([
                                                       for (i = [0:1:counts_x-2]) zrot(i*adj_angle/counts_x, strip_vnf),
                                                       zrot((counts_x-1)*adj_angle/counts_x, last_vnf)
                                                     ])
                            )
                            full_wall
                      )
                      vnf
                   ]),
                sidecap_vnf = angle == 360? EMPTY_VNF :
                    let(
                        cap_rgn = side_open_path == [] ? [] 
                           : [ for (path = rgn)
                                 let(
                                   path_closed = open_axis_paths(path,closed),
                                   path = path_closed[0],
                                   closed = path_closed[1], 
                                   plen = path_length(path, closed=closed),
                                   counts_y = is_def(counts) ? counts.y : max(1,round(plen/tex_size.y)),
                                   bases = resample_path(path, n=counts_y * samples + (closed?0:tex_extra.y), closed=closed),
                                   norms = path_normals(bases, closed=closed),
                                   ppath = is_vnf(texture)
                                         ? let( onepath = [ // VNF tile texture
                                                             for (j = [0:1:counts_y-1], vert=side_open_path)
                                                               transform_point(j + (1 - vert.y),vert.z,counts_y,bases, norms)
                                                          ]
                                           )
                                           [onepath,onepath]
                                        :
                                           [for(j=[0,1])    // Heightfield texture
                                              [ 
                                               for (i = [0:1:counts_y-(closed?1:0)], ti = [0:1:texcnt.y-1])
                                                 if (i != counts_y || ti < tex_extra.y)
                                                   transform_point(i + (ti/texcnt.y),texture[ti][(j*(texcnt.x-1+tex_extra.x))%texcnt.x],counts_y, bases, norms)
                                              ]
                                          ], 
                                   paths = [for(p=ppath)
                                              deduplicate([
                                                           if (!closed) [0, p[0].y],
                                                           each p,
                                                           if (!closed) [0, last(p).y]
                                                          ],
                                                          closed=closed)]
                                 )
                                 paths
                             ],
                        cap_vnfs = cap_rgn == [] ? [EMPTY_VNF]
                                 : [for(i=[0,1]) vnf_from_region(column(cap_rgn,i), rot([90,0,i*angle]), reverse=i==1)],
                        extra_paths = side_closed_paths==[] ? [] 
                           : [for (path = rgn) let(
                                path_closed = open_axis_paths(path,closed),
                                path = path_closed[0],
                                closed = path_closed[1], 
                            
                                plen = path_length(path, closed=closed),
                                counts_y = is_def(counts) ? counts.y : max(1,round(plen/tex_size.y)),
                                bases = resample_path(path, n=counts_y * samples + (closed?0:1), closed=closed),
                                norms = path_normals(bases, closed=closed),
                                modpaths = [for (j = [0:1:counts_y-1], cpath=side_closed_paths)
                                              [for(vert=cpath)
                                                 transform_point(j + (1 - vert.y),vert.z,counts_y,bases, norms)]
                                           ]
                             )
                             each modpaths
                            ],
                        extra_vnfs = [
                           if (len(extra_paths)>0) for(path=extra_paths) [xrot(90,path3d(path)), [count(len(path))]],
                           if (len(extra_paths)>0) for(path=extra_paths) [rot([90,0,angle],p=path3d(path)), [count(len(path),reverse=true)]],
                        ]
                    ) vnf_join(concat(cap_vnfs, extra_vnfs)),
                endcaps_vnf = closed? EMPTY_VNF :
                    let(
                        path_closed = open_axis_paths(rgn[0],closed),
                        path = path_closed[0],
                        closed = path_closed[1], 
                        plen = path_length(path, closed=closed),
                        counts_y = is_def(counts) ? counts.y : max(1,round(plen/tex_size.y)),
                        obases = resample_path(path, n=counts_y * samples + (closed?0:tex_extra.y), closed=closed),
                        onorms = path_normals(obases, closed=closed),
                        bases = xrot(90, p=path3d(obases)),
                        norms = xrot(90, p=path3d(onorms)),
                        bpath = is_def(edge_paths)
                                   ? len(edge_paths[0])==0 ? [] : repeat(hstack([column(edge_paths[0][0],0), column(edge_paths[0][0],2)]),2)
                                   :  
                                     [ for(j=[texcnt.y-1+tex_extra.y,0])
                                         [for (i = [0:1:texcnt.x-1+max(1,tex_extra.x)])
                                             [i/texcnt.x, texture[j%texcnt.y][i%texcnt.x]]]],
                        caps_vnf = vnf_join([
                            for (epath=edge_closed_paths, j = [-1,0])
                                    let(
                                        base = select(bases,j),
                                        norm = unit(select(norms,j)),
                                        ppath = [
                                            for (vert = epath) let(
                                                uang = vert.x / counts_x,
                                                tex_scale = tex_scale * taperfunc(j+1),
                                                texh = tex_scale<0 ? -(1-vert.z - inset) * tex_scale * (base.x / maxx)
                                                                   : (vert.z - inset) * tex_scale * (base.x / maxx),
                                                xyz = base - norm * texh
                                            ) zrot(angle*uang, p=xyz)
                                        ],
                                        faces = [count(ppath,reverse=j==0)]
                                    )
                                    for(i=[0:1:counts_x-1])
                                        [zrot(i*angle/counts_x, ppath), faces],
                            if (len(bpath)>0)
                                for (j = [-1,0])
                                    let(
                                         base = select(bases,j),
                                         norm = unit(select(norms,j)),
                                         ppath = [
                                             for (vert = bpath[j+1]) let(
                                                 uang = vert.x / counts_x,
                                                 tex_scale = tex_scale * taperfunc(j+1),
                                                 texh = tex_scale<0 ? -(1-vert.y - inset) * tex_scale * (base.x / maxx)
                                                                    : (vert.y - inset) * tex_scale * (base.x / maxx),
                                                 xyz = base - norm * texh
                                             ) zrot(adj_angle*uang, p=xyz)
                                         ],
                                         pplen = is_def(texcnt) ? texcnt.x+1 : len(ppath), 
                                         last_len = len(ppath)-(tex_extra.x==0?1:0), 
                                         zed = j<0? max(column(ppath,2)): min(column(ppath,2)),
                                         slice_vnf = [
                                             [
                                                 each select(ppath,0,pplen-1),
                                                 [0, 0, zed],
                                             ], [
                                                 for (i = [0:1:pplen-2])
                                                     j<0? [pplen, i, (i+1)%pplen]
                                                        : [pplen, (i+1)%pplen, i]
                                             ]
                                         ],
                                         last_slice = [
                                             [
                                                 each select(ppath,0,last_len-1),
                                                 [0, 0, zed],
                                             ], [
                                                 for (i = [0:1:last_len-2])
                                                     j<0? [last_len, i, (i+1)%last_len]
                                                        : [last_len, (i+1)%last_len, i]
                                             ]
                                         ]
                                    )
                                    for (i = [0:counts_x-1])
                                       i<counts_x-1 ? zrot(i*adj_angle/counts_x, slice_vnf)
                                                    : zrot((counts_x-1)*adj_angle/counts_x, last_slice)
                        ])
                    ) caps_vnf
            ) vnf_join([rgn_wall_vnf, sidecap_vnf, endcaps_vnf])
        ]),
        skmat = zrot(start) * down(-miny) * skew(sxz=shift.x/h, syz=shift.y/h) * up(-miny),
        skvnf = apply(skmat, full_vnf),
        geom = atype=="intersect"
              ? attach_geom(vnf=skvnf, extent=false)
              : attach_geom(vnf=skvnf, extent=true)
    ) reorient(anchor,spin,orient, geom=geom, p=skvnf);

function _textured_point_array(points, texture, tex_reps, tex_size, tex_samples, tex_inset=false, tex_rot=0, triangulate=false, tex_scaling="default",return_edges=false, 
                col_wrap=false, tex_depth=1, row_wrap=false, caps, cap1, cap2, reverse=false, style="min_edge", tex_extra, tex_skip, sidecaps,sidecap1,sidecap2,normals) =
    assert(tex_reps==undef || is_int(tex_reps) || (all_integer(tex_reps) && len(tex_reps)==2), "\ntex_reps must be an integer or list of two integers.")
    assert(tex_size==undef || is_num(tex_size) || is_vector(tex_size,2), "\ntex_size must be a scalar or 2-vector.")
    assert(num_defined([tex_size, tex_reps])==1, "\nMust give exactly one of tex_size and tex_reps.")
    assert(in_list(style,["default","alt","quincunx", "convex","concave", "min_edge","min_area","flip1","flip2"]))
    assert(is_matrix(points[0], n=3),"\nPoint array has the wrong shape or points are not 3D.")
    assert(is_consistent(points), "\nNon-rectangular or invalid point array.")
    let(
        cap1 = first_defined([cap1,caps,false]),
        cap2 = first_defined([cap2,caps,false]),
        sidecap1 = first_defined([sidecap1,sidecaps,false]),
        sidecap2 = first_defined([sidecap2,sidecaps,false]),
        tex_inset = is_num(tex_inset)? tex_inset : tex_inset? 1 : 0,
        texture = _get_texture(texture, tex_rot),
        dummy = assert(is_undef(tex_samples) || is_vnf(texture),
                       "\nYou gave the tex_samples argument with a heightfield texture, which is not permitted. Use the n= argument to texture() instead."),
        ptsize=[len(points[0]), len(points)],
        tex_reps = is_def(tex_reps) ? force_list(tex_reps,2)
                 : let(
                       tex_size = force_list(tex_size,2),
                       xsize = norm(points[0][0]-points[0][1])*(ptsize.x+(col_wrap?1:0)),
                       ysize = norm(points[0][0]-points[1][0])*(ptsize.y+(row_wrap?1:0))
                   )
                   [max(1,round(xsize/tex_size.x)), max(1,round(ysize/tex_size.y))],
        normals = default(normals,surface_normals(points, col_wrap=col_wrap, row_wrap=row_wrap)),
        getscale = tex_scaling=="default" ? function(x,y) (x+y)/2
                 : tex_scaling=="const" ? function(x,y) 1
                 : assert(false, "\nUnknown tex_scaling value. Must be either \"default\" or \"const\".")
    )
    !is_vnf(texture) ?  // heightmap case
        let(
            extra = is_def(tex_extra) ? force_list(tex_extra,2)
                  : [col_wrap?0:1, row_wrap?0:1],
            skip = is_def(tex_skip) ? force_list(tex_skip,2) : [0,0],
            texsize = [len(texture[0]), len(texture)],
            fullsize = [texsize.x*tex_reps.x+extra.x-skip.x, texsize.y*tex_reps.y+extra.y-skip.y],
            res_points = _resample_point_array(points,fullsize, col_wrap=col_wrap, row_wrap=row_wrap),
            res_normals= _resample_point_array(normals,fullsize, col_wrap=col_wrap, row_wrap=row_wrap),
            local_scale = [for(y=[0:1:fullsize.y-1])
                             [for(x=[0:1:fullsize.x-1])
                                let(
                                     xlen = [
                                              if(x>0 || col_wrap) norm(res_points[y][x] - select(res_points[y], x-1)),
                                              if(x<fullsize.x-1 || col_wrap) norm(res_points[y][x] - select(res_points[y], x+1))
                                            ],
                                     ylen = [
                                              if(y>0 || row_wrap) norm(res_points[y][x] - select(res_points,y-1)[x]),
                                              if(y<fullsize.y-1 || row_wrap) norm(res_points[y][x] - select(res_points,y+1)[x])
                                            ]
                                 )
                                 getscale(mean(xlen),mean(ylen))
                              ]
                           ],
            tex_surf =
              [for(y=[0:1:fullsize.y-1])
                 [for(x=[0:1:fullsize.x-1])
                    let(yind = (y+skip.y)%texsize.y,
                        xind = (x+skip.x)%texsize.x
                    )
                    res_points[y][x] + _tex_height(tex_depth,tex_inset,texture[yind][xind]) * res_normals[y][x]*(reverse?-1:1)*local_scale[y][x]/local_scale[0][0]
                  ]
              ]
        )  
        vnf_vertex_array(tex_surf, row_wrap=row_wrap, col_wrap=col_wrap, reverse=reverse,style=style,
                         caps=caps, cap1=cap1, cap2=cap2, triangulate=triangulate, return_edges=return_edges)
   : // VNF case
        let(
            local_scale = [for(y=[-1:1:ptsize.y])
                             [for(x=[-1:1:ptsize.x])
                               ((!col_wrap && (x<0 || x>=ptsize.x-1))
                                   || (!row_wrap && (y<0 || y>=ptsize.y-1))) ? undef
                              : let(
                                     dx = [norm(select(select(points,y),x) - select(select(points,y),x+1)),
                                          norm(select(select(points,y+1),x) - select(select(points,y+1),x+1))],
                                     dy = [norm(select(select(points,y),x) - select(select(points,y+1),x)),
                                          norm(select(select(points,y),x+1) - select(select(points,y+1),x+1))]
                                )
                                getscale(mean(dx),mean(dy))]],
            samples = default(tex_samples,8),
            vnf = samples==1? texture
                :
                  let(
                      s = 1 / samples,
                      slice_us = list([s:s:1-s/2]),
                      vnf_x = vnf_slice(texture, "X", slice_us),
                      vnf_xy = vnf_slice(vnf_x, "Y", slice_us),
                      vnf_q = vnf_quantize(vnf_xy,1e-4)
                  )
                  vnf_triangulate(vnf_q),
            yedge_paths = !row_wrap ? _tile_edge_path_list(vnf,1) : undef,
            xedge_paths = !col_wrap ? _tile_edge_path_list(vnf,0) : undef,
            trans_pt = function(x,y,pt)
               let(
                   tileindx = x+pt.x,
                   tileindy = y+(1-pt.y),

                   refx = tileindx/tex_reps.x*(ptsize.x-(col_wrap?0:1)),
                   refy = tileindy/tex_reps.y*(ptsize.y-(row_wrap?0:1)),
                   xind = floor(refx),
                   yind = floor(refy),
                   xfrac = refx-xind,
                   yfrac = refy-yind, 
                   corners = [points[yind%ptsize.y][xind%ptsize.x],     points[(yind+1)%ptsize.y][xind%ptsize.x],
                              points[yind%ptsize.y][(xind+1)%ptsize.x], points[(yind+1)%ptsize.y][(xind+1)%ptsize.x]],
                   base = bilerp(corners,yfrac, xfrac),
                   scale_list = xfrac==0 && yfrac==0 ? [local_scale[yind][xind], local_scale[yind][xind+1], local_scale[yind+1][xind], local_scale[yind+1][xind+1]]
                              : xfrac==0 ? [local_scale[yind+1][xind], local_scale[yind+1][xind+1]]
                              : yfrac==0 ? [local_scale[yind][xind+1], local_scale[yind+1][xind+1]]
                              :            [ local_scale[yind+1][xind+1]],
                   scale = mean([for(s=scale_list) if (is_def(s)) s])/local_scale[1][1],
                   normal = bilerp([normals[yind%ptsize.y][xind%ptsize.x],     normals[(yind+1)%ptsize.y][xind%ptsize.x],
                                    normals[yind%ptsize.y][(xind+1)%ptsize.x], normals[(yind+1)%ptsize.y][(xind+1)%ptsize.x]],
                                    yfrac, xfrac)
               )
               base + _tex_height(tex_depth,tex_inset,pt.z) * normal*(reverse?-1:1) * scale,
            fullvnf = vnf_join([
                           for(y=[0:1:tex_reps.y-1], x=[0:1:tex_reps.x-1])   // Main body of the textured shape
                             [
                              [for(pt=vnf[0]) trans_pt(x,y,pt)],
                              vnf[1]
                             ],
                           for(y=[if (cap1) 0, if (cap2) tex_reps.y-1])
                             let(
                                 cap_paths = [
                                              if (col_wrap && len(yedge_paths[0])>0)
                                                 [for(x=[0:1:tex_reps.x-1], pt=yedge_paths[0][0])
                                                     trans_pt(x,y,[pt.x,y?0:1,pt.z])],
                                              if (!row_wrap)      
                                                for(closed_path=yedge_paths[1], x=[0:1:tex_reps.x-1])
                                                   [for(pt = closed_path) trans_pt(x,y,[pt.x,y?0:1,pt.z])]
                                             ]
                             )
                             for(path=cap_paths) [path, [count(path,reverse=y==0)]],
                           if (!col_wrap)
                             for(x=[if (sidecap1) 0, if (sidecap2) tex_reps.x-1])
                                let( 
                                   cap_paths = [for(closed_path=xedge_paths[1], y=[0:1:tex_reps.y-1])
                                                   [for(pt = closed_path) trans_pt(x,y,[x?1:0,pt.y,pt.z])]]
                                )
                                for(path=cap_paths) [path, [count(path,reverse=x!=0)]]
                      ]),
            edgepaths = !return_edges ? undef
                      : [
                          if (!col_wrap)
                             for(x=[0, tex_reps.x-1])
                                   [for(y=[0:1:tex_reps.y-1],pt=xedge_paths[0][0])
                                                   trans_pt(x,y,[x?1:0,pt.y,pt.z])]
                          else each [[],[]],
                                 
                          if (!row_wrap && len(yedge_paths[0])>0)
                             for(ind=[0,1])
                               if ([cap1,cap2][ind]) []
                               else let(y=[0,tex_reps.y-1][ind])
                               [for(x=[0:1:tex_reps.x-1], pt=yedge_paths[0][0])
                                                     trans_pt(x,y,[pt.x,y?0:1,pt.z])]
                          else each [[],[]]
                        ],
            revvnf = reverse ? vnf_reverse_faces(fullvnf) : fullvnf
                          
       )
       !return_edges ? revvnf : [revvnf, edgepaths];

// Resamples a point array to the specified size.
// In use above, data is a list of points in R^3 on a grid 
// and size is the desired dimensions of the output array covering the
// same data.
function _resample_point_array(data, size, col_wrap=false, row_wrap=false) =
  let(
      xL=len(data[0]),
      yL=len(data),
      lastx=xL-(col_wrap?0:1),
      lasty=yL-(row_wrap?0:1),
      lastoutx = size.x - (col_wrap?0:1),
      lastouty = size.y - (row_wrap?0:1),      
      xscale = lastx/lastoutx,
      yscale = lasty/lastouty
  )
  [
    for(y=[0:1:lastouty])
      [
        for(x=[0:1:lastoutx])
           let(
                sx = xscale*x,
                sy = yscale*y,
                xind=floor(sx),
                yind=floor(sy)
           )
           bilerp([data[yind%yL][xind%xL],     data[(yind+1)%yL][xind%xL],
                   data[yind%yL][(xind+1)%xL], data[(yind+1)%yL][(xind+1)%xL]],
                  sy-yind, sx-xind)
      ]
  ];

// onescad: BOSL2/utility.scad
//////////////////////////////////////////////////////////////////////
// LibFile: utility.scad
//   Functions for type checking, handling undefs, processing function arguments,
//   and testing. 
// Includes:
//   include <BOSL2/std.scad>
// FileGroup: Data Management
// FileSummary: Type checking, dealing with undefs, processing function args
// FileFootnotes: STD=Included in std.scad
//////////////////////////////////////////////////////////////////////

// Function: is_def()
// Synopsis: Returns true if `x` is not `undef`.
// Topics: Type Checking
// See Also: typeof(), is_type(), is_str()
// Usage:
//   bool = is_def(x);
// Description:
//   Returns true if `x` is not `undef`.  False if `x==undef`.
// Arguments:
//   x = value to check
// Example:
//   bool = is_def(undef);  // Returns: false
//   bool = is_def(false);  // Returns: true
//   bool = is_def(42);     // Returns: true
//   bool = is_def("foo");  // Returns: true
function is_def(x) = !is_undef(x);

// Function: is_str()
// Synopsis: Returns true if the argument is a string.
// Topics: Type Checking
// See Also: typeof(), is_type(), is_int(), is_def(), is_int()
// Usage:
//   bool = is_str(x);
// Description:
//   Returns true if `x` is a string.  A shortcut for `is_string()`.
// Arguments:
//   x = value to check
// Example:
//   bool = is_str(undef);  // Returns: false
//   bool = is_str(false);  // Returns: false
//   bool = is_str(42);     // Returns: false
//   bool = is_str("foo");  // Returns: true
function is_str(x) = is_string(x);

// Function: is_int()
// Alias: is_integer()
// Synopsis: Returns true if the argument is an integer.
// Topics: Type Checking
// See Also: typeof(), is_type(), is_str(), is_def()
// Usage:
//   bool = is_int(n);
//   bool = is_integer(n);
// Description:
//   Returns true if the given value is an integer (it is a number and it rounds to itself).  
// Arguments:
//   n = value to check
// Example:
//   bool = is_int(undef);  // Returns: false
//   bool = is_int(false);  // Returns: false
//   bool = is_int(42);     // Returns: true
//   bool = is_int("foo");  // Returns: false
function is_int(n) = is_finite(n) && n == round(n);

function is_integer(n) = is_finite(n) && n == round(n);

// Function: all_integer()
// Synopsis: Returns true if all of the numbers in the argument are integers.
// Topics: Type Checking
// See also: is_int(), typeof(), is_type()
// Usage:
//   bool = all_integer(x);
// Description:
//   If given a number, returns true if the number is a finite integer.
//   If given an empty list, returns false.  If given a non-empty list, returns
//   true if every item of the list is an integer.  Otherwise, returns false.
// Arguments:
//   x = The value to check.
// Example:
//   b = all_integer(true);  // Returns: false
//   b = all_integer("foo"); // Returns: false
//   b = all_integer(4);     // Returns: true
//   b = all_integer(4.5);   // Returns: false
//   b = all_integer([]);    // Returns: false
//   b = all_integer([3,4,5]);   // Returns: true
//   b = all_integer([3,4.2,5]); // Returns: false
//   b = all_integer([3,[4,7],5]); // Returns: false
function all_integer(x) =
    is_num(x)? is_int(x) :
    is_list(x)? (x != [] && [for (xx=x) if(!is_int(xx)) 1] == []) :
    false;

// Function: is_nan()
// Synopsis: Return true if the argument is "not a number".
// Topics: Type Checking
// See Also: typeof(), is_type(), is_str(), is_def(), is_int(), is_finite()
// Usage:
//   bool = is_nan(x);
// Description:
//   Returns true if a given value `x` is nan, a floating point value representing "not a number".
// Arguments:
//   x = value to check
// Example:
//   bool = is_nan(undef);  // Returns: false
//   bool = is_nan(false);  // Returns: false
//   bool = is_nan(42);     // Returns: false
//   bool = is_nan("foo");  // Returns: false
//   bool = is_nan(NAN);    // Returns: true
function is_nan(x) = (x!=x);

// Function: is_finite()
// Synopsis: Returns true if the argument is a finite number.
// Topics: Type Checking
// See Also: typeof(), is_type(), is_str(), is_def(), is_int(), is_nan()
// Usage:
//   bool = is_finite(x);
// Description:
//   Returns true if a given value `x` is a finite number.
// Arguments:
//   x = value to check
// Example:
//   bool = is_finite(undef);  // Returns: false
//   bool = is_finite(false);  // Returns: false
//   bool = is_finite(42);     // Returns: true
//   bool = is_finite("foo");  // Returns: false
//   bool = is_finite(NAN);    // Returns: false
//   bool = is_finite(INF);    // Returns: false
//   bool = is_finite(-INF);   // Returns: false
function is_finite(x) = is_num(x) && !is_nan(0*x);

// Function: is_range()
// Synopsis: Returns true if the argument is a range.
// Topics: Type Checking
// See Also: typeof(), is_type(), is_str(), is_def(), is_int()
// Usage:
//   bool = is_range(x);
// Description:
//   Returns true if its argument is a range
// Arguments:
//   x = value to check
// Example:
//   bool = is_range(undef);   // Returns: false
//   bool = is_range(false);   // Returns: false
//   bool = is_range(42);      // Returns: false
//   bool = is_range([3,4,5]); // Returns: false
//   bool = is_range("foo");   // Returns: false
//   bool = is_range([3:5]);   // Returns: true
function is_range(x) = !is_list(x) && is_finite(x[0]) && is_finite(x[1]) && is_finite(x[2]) ;

// Function: valid_range()
// Synopsis: Returns true if the argument is a valid range.
// Topics: Type Checking
// See Also: typeof(), is_type(), is_str(), is_def(), is_int(), is_range()
// Usage:
//   bool = valid_range(x);
// Description:
//   Returns true if its argument is a valid range (deprecated ranges excluded).
// Arguments:
//   x = value to check
// Example:
//   bool = is_range(undef);   // Returns: false
//   bool = is_range(false);   // Returns: false
//   bool = is_range(42);      // Returns: false
//   bool = is_range([3,4,5]); // Returns: false
//   bool = is_range("foo");   // Returns: false
//   bool = is_range([3:5]);   // Returns: true
//   bool = is_range([3:1]);   // Returns: false
function valid_range(x) = 
    is_range(x) 
    && ( x[1]>0 
         ? x[0]<=x[2]
         : ( x[1]<0 && x[0]>=x[2] ) );

// Function: is_func()
// Synopsis: Returns true if the argument is a function literal.
// Topics: Type Checking, Function Literals
// See also: is_type(), typeof()
// Usage:
//   bool = is_func(x);
// Description:
//   Returns true if OpenSCAD supports function literals, and the given item is one.
// Arguments:
//   x = The value to check
// Example:
//   f = function (a) a==2;
//   bool = is_func(f);  // Returns: true
function is_func(x) = version_num()>20210000 && is_function(x);

// Function: is_consistent()
// Synopsis: Returns true if the argument is a list with consistent structure and finite numerical data.
// Topics: Type Checking, Testing
// See Also: typeof(), is_type(), is_str(), is_def(), is_int(), is_range(), is_homogeneous()
// Usage:
//   bool = is_consistent(list, [pattern]);
// Description:
//   Tests whether input is a list of entries which all have the same list structure
//   and are filled with finite numerical data.  You can optionally specify a required 
//   list structure with the pattern argument.  
//   It returns `true` for the empty list regardless the value of the `pattern`.
// Arguments:
//   list = list to check
//   pattern = optional pattern required to match
// Example:
//   is_consistent([3,4,5]);              // Returns true
//   is_consistent([[3,4],[4,5],[6,7]]);  // Returns true
//   is_consistent([[3,4,5],[3,4]]);      // Returns false
//   is_consistent([[3,[3,4,[5]]], [5,[2,9,[9]]]]); // Returns true
//   is_consistent([[3,[3,4,[5]]], [5,[2,9,9]]]);   // Returns false
//   is_consistent([3,4,5], 0);            // Returns true
//   is_consistent([3,4,undef], 0);        // Returns false
//   is_consistent([[3,4],[4,5]], [1,1]);  // Returns true
//   is_consistent([[3,"a"],[4,true]], [1,undef]);  // Returns true
//   is_consistent([[3,4], 6, [4,5]], [1,1]);  // Returns false
//   is_consistent([[1,[3,4]], [4,[5,6]]], [1,[2,3]]);    // Returns true
//   is_consistent([[1,[3,INF]], [4,[5,6]]], [1,[2,3]]);  // Returns false
//   is_consistent([], [1,[2,3]]);                        // Returns true
function is_consistent(list, pattern) =
    is_list(list) 
    && (len(list)==0 
       || (let(pattern = is_undef(pattern) ? _list_pattern(list[0]): _list_pattern(pattern) )
          []==[for(entry=0*list) if (entry != pattern) entry]));

//Internal function
//Creates a list with the same structure of `list` with each of its elements replaced by 0.
function _list_pattern(list) =
  is_list(list) 
  ? [for(entry=list) is_list(entry) ? _list_pattern(entry) : 0]
  : 0;

// Function: same_shape()
// Synopsis: Returns true if the argument lists are numeric and of the same shape.
// Topics: Type Checking, Testing
// See Also: is_homogeneous(), is_consistent()
// Usage:
//   bool = same_shape(a,b);
// Description:
//   Tests whether the inputs `a` and `b` are both numeric and are the same shaped list.
// Example:
//   same_shape([3,[4,5]],[7,[3,4]]);   // Returns true
//   same_shape([3,4,5], [7,[3,4]]);    // Returns false
function same_shape(a,b) = is_def(b) && _list_pattern(a) == b*0;

// Function: is_bool_list()
// Synopsis: Returns true if the argument list contains only booleans.
// Topics: Boolean Testing
// See Also: is_homogeneous(), is_consistent()
// Usage:
//   check = is_bool_list(list,[length])
// Description:
//   Tests whether input is a list containing only booleans, and optionally checks its length.
// Arguments:
//   list = list to test
//   length = if given, list must be this length
function is_bool_list(list, length) =
     is_list(list) && (is_undef(length) || len(list)==length) && []==[for(entry=list) if (!is_bool(entry)) 1];

// Section: Boolean list testing

// Function: any()
// Synopsis: Returns true if any item in the argument list is true.
// Topics: Type Checking
// See Also: all(), num_true()
// Usage:
//   bool = any(l);
//   bool = any(l, func);   // Requires OpenSCAD 2021.01 or later.
// Requirements:
//   Requires OpenSCAD 2021.01 or later to use the `func` argument.
// Description:
//   Returns true if any item in list `l` evaluates as true.
//   If `func` is given then returns true if the function evaluates as true on any list entry. 
//   Items that evaluate as true include nonempty lists, nonempty strings, and nonzero numbers.
// Arguments:
//   l = The list to test for true items.
//   func = An optional function literal of signature (x), returning bool, to test each list item with.
// Example:
//   any([0,false,undef]);  // Returns false.
//   any([1,false,undef]);  // Returns true.
//   any([1,5,true]);       // Returns true.
//   any([[0,0], [0,0]]);   // Returns true.
//   any([[0,0], [1,0]]);   // Returns true.
function any(l, func) =
    assert(is_list(l), "The input is not a list." )
    assert(func==undef || is_func(func))
    is_func(func)
      ? _any_func(l, func)
      : _any_bool(l);

function _any_func(l, func, i=0, out=false) =
    i >= len(l) || out? out :
    _any_func(l, func, i=i+1, out=out || func(l[i]));

function _any_bool(l, i=0, out=false) =
    i >= len(l) || out? out :
    _any_bool(l, i=i+1, out=out || l[i]);

// Function: all()
// Synopsis: Returns true if all items in the argument list are true.
// Topics: Type Checking
// See Also: any(), num_true()
// Usage:
//   bool = all(l);
//   bool = all(l, func);   // Requires OpenSCAD 2021.01 or later.
// Requirements:
//   Requires OpenSCAD 2021.01 or later to use the `func` argument.
// Description:
//   Returns true if all items in list `l` evaluate as true.
//   If `func` is given then returns true if the function evaluates as true on all list etnries. 
//   Items that evaluate as true include nonempty lists, nonempty strings, and nonzero numbers.
// Arguments:
//   l = The list to test for true items.
//   func = An optional function literal of signature (x), returning bool, to test each list item with.
// Example:
//   test1 = all([0,false,undef]);  // Returns false.
//   test2 = all([1,false,undef]);  // Returns false.
//   test3 = all([1,5,true]);       // Returns true.
//   test4 = all([[0,0], [0,0]]);   // Returns true.
//   test5 = all([[0,0], [1,0]]);   // Returns true.
//   test6 = all([[1,1], [1,1]]);   // Returns true.
function all(l, func) =
    assert(is_list(l), "The input is not a list.")
    assert(func==undef || is_func(func))
    is_func(func)
      ? _all_func(l, func)
      : _all_bool(l);

function _all_func(l, func, i=0, out=true) =
    i >= len(l) || !out? out :
    _all_func(l, func, i=i+1, out=out && func(l[i]));

function _all_bool(l, i=0, out=true) =
    i >= len(l) || !out? out :
    _all_bool(l, i=i+1, out=out && l[i]);

// Function: num_true()
// Synopsis: Returns the number of true entries in the arguemnt list.
// Topics: Boolean Testing
// See Also: any(), all()
// Usage:
//   seq = num_true(l);
//   seq = num_true(l, func);  // Requires OpenSCAD 2021.01 or later.
// Requirements:
//   Requires OpenSCAD 2021.01 or later to use the `func=` argument.
// Description:
//   Returns the number of items in `l` that evaluate as true.  If `func` is given then counts
//   list entries where the function evaluates as true.  
//   Items that evaluate as true include nonempty lists, nonempty strings, and nonzero numbers.
// Arguments:
//   l = The list to test for true items.
//   func = An optional function literal of signature (x), returning bool, to test each list item with.
// Example:
//   num1 = num_true([0,false,undef]);  // Returns 0.
//   num2 = num_true([1,false,undef]);  // Returns 1.
//   num3 = num_true([1,5,false]);      // Returns 2.
//   num4 = num_true([1,5,true]);       // Returns 3.
//   num5 = num_true([[0,0], [0,0]]);   // Returns 2.
//   num6 = num_true([[], [1,0]]);      // Returns 1.
function num_true(l, func) = 
    assert(is_list(l))
    assert(func==undef || is_func(func))
    let(
        true_list = is_def(func)? [for(entry=l) if (func(entry)) 1]
                                : [for(entry=l) if (entry) 1]
    )
    len(true_list);

// Section: Handling `undef`s.


// Function: default()
// Synopsis: Returns a default value if the argument is 'undef', else returns the argument.
// Topics: Undef Handling
// See Also: first_defined(), one_defined(), num_defined()
// Usage:
//   val = default(val, dflt);
// Description:
//   Returns the value given as `v` if it is not `undef`.
//   Otherwise, returns the value of `dflt`.
// Arguments:
//   v = Value to pass through if not `undef`.
//   dflt = Value to return if `v` *is* `undef`.  Default: undef
function default(v,dflt=undef) = is_undef(v)? dflt : v;

// Function: first_defined()
// Synopsis: Returns the first value in the argument list that is not 'undef'.
// Topics: Undef Handling
// See Also: default(), one_defined(), num_defined(), any_defined(), all_defined()
// Usage:
//   val = first_defined(v, [recursive]);
// Description:
//   Returns the first item in the list that is not `undef`.
//   If all items are `undef`, or list is empty, returns `undef`.
// Arguments:
//   v = The list whose items are being checked.
//   recursive = If true, sublists are checked recursively for defined values.  The first sublist that has a defined item is returned.  Default: false
// Example:
//   val = first_defined([undef,7,undef,true]);  // Returns: 7
function first_defined(v,recursive=false,_i=0) =
    _i<len(v) && (
        is_undef(v[_i]) || (
            recursive &&
            is_list(v[_i]) &&
            is_undef(first_defined(v[_i],recursive=recursive))
        )
    )? first_defined(v,recursive=recursive,_i=_i+1) : v[_i];

// Function: one_defined()
// Synopsis: Returns the defined value in the argument list if only a single value is defined.
// Topics: Undef Handling
// See Also: default(), first_defined(), num_defined(), any_defined(), all_defined()
// Usage:
//   val = one_defined(vals, names, [dflt])
// Description:
//   Examines the input list `vals` and returns the entry which is not `undef`.
//   If more than one entry is not `undef` then an error is asserted, specifying
//   "Must define exactly one of" followed by the names in the `names` parameter.
//   If `dflt` is given, and all `vals` are `undef`, then the value in `dflt` is returned.
//   If `dflt` is *not* given, and all `vals` are `undef`, then an error is asserted.
// Arguments:
//   vals = The values to return the first one which is not `undef`.
//   names = A string with comma-separated names for the arguments whose values are passed in `vals`.
//   dflt = If given, the value returned if all `vals` are `undef`.
// Example:
//   length1 = one_defined([length,L,l], ["length","L","l"]);
//   length2 = one_defined([length,L,l], "length,L,l", dflt=1);
function one_defined(vals, names, dflt=_UNDEF) = 
    let(
        checkargs = is_list(names)? assert(len(vals) == len(names)) :
            is_string(names)? let(
                name_cnt = len([for (c=names) if (c==",") 1]) + 1
            ) assert(len(vals) == name_cnt) :
            assert(is_list(names) || is_string(names)) 0,
        ok = num_defined(vals)==1 || (dflt!=_UNDEF && num_defined(vals)==0)
    ) ok? default(first_defined(vals), dflt) :
    let(
        names = is_string(names) ? str_split(names,",") : names,
        defd = [for (i=idx(vals)) if (is_def(vals[i])) names[i]],
        msg = str(
            "Must define ",
            dflt==_UNDEF? "exactly" : "at most",
            " one of ",
            num_defined(vals) == 0 ? names : defd
        )
    ) assert(ok,msg);

// Function: num_defined()
// Synopsis: Returns the number of defined values in the the argument list.
// Topics: Undef Handling
// See Also: default(), first_defined(), one_defined(), any_defined(), all_defined()
// Usage:
//   cnt = num_defined(v);
// Description:
//   Counts how many items in list `v` are not `undef`.
// Example:
//   cnt = num_defined([3,7,undef,2,undef,undef,1]);  // Returns: 4
function num_defined(v) =
    len([for(vi=v) if(!is_undef(vi)) 1]);

// Function: any_defined()
// Synopsis: Returns true if any item in the argument list is not `undef`.
// Topics: Undef Handling
// See Also: default(), first_defined(), one_defined(), num_defined(), all_defined()
// Usage:
//   bool = any_defined(v, [recursive]);
// Description:
//   Returns true if any item in the given array is not `undef`.
// Arguments:
//   v = The list whose items are being checked.
//   recursive = If true, any sublists are evaluated recursively.  Default: false
// Example:
//   bool = any_defined([undef,undef,undef]);    // Returns: false
//   bool = any_defined([undef,42,undef]);       // Returns: true
//   bool = any_defined([34,42,87]);             // Returns: true
//   bool = any_defined([undef,undef,[undef]]);  // Returns: true
//   bool = any_defined([undef,undef,[undef]],recursive=true);  // Returns: false
//   bool = any_defined([undef,undef,[42]],recursive=true);     // Returns: true
function any_defined(v,recursive=false) =
    first_defined(v,recursive=recursive) != undef;

// Function: all_defined()
// Synopsis: Returns true if all items in the given array are defined.
// Topics: Undef Handling
// See Also: default(), first_defined(), one_defined(), num_defined(), all_defined()
// Usage:
//   bool = all_defined(v, [recursive]);
// Description:
//   Returns true if all items in the given array are not `undef`.
// Arguments:
//   v = The list whose items are being checked.
//   recursive = If true, any sublists are evaluated recursively.  Default: false
// Example:
//   bool = all_defined([undef,undef,undef]);    // Returns: false
//   bool = all_defined([undef,42,undef]);       // Returns: false
//   bool = all_defined([34,42,87]);             // Returns: true
//   bool = all_defined([23,34,[undef]]);        // Returns: true
//   bool = all_defined([23,34,[undef]],recursive=true);  // Returns: false
//   bool = all_defined([23,34,[42]],recursive=true);     // Returns: true
function all_defined(v,recursive=false) = 
    []==[for (x=v) if(is_undef(x)||(recursive && is_list(x) && !all_defined(x,recursive))) 0 ];

// Section: Undef Safe Arithmetic

// Function: u_add()
// Synopsis: Returns the sum of 2 numbers if both are defined, otherwise returns undef.
// Topics: Undef Handling
// See Also: u_sub(), u_mul(), u_div()
// Usage:
//   x = u_add(a, b);
// Description:
//   Adds `a` to `b`, returning the result, or undef if either value is `undef`.
//   This emulates the way undefs used to be handled in versions of OpenSCAD before 2020.
// Arguments:
//   a = First value.
//   b = Second value.
function u_add(a,b) = is_undef(a) || is_undef(b)? undef : a + b;

// Function: u_mul()
// Synopsis: Returns the product of 2 numbers if both are defined, otherwise returns undef.
// Topics: Undef Handling
// See Also: u_add(), u_sub(), u_div()
// Usage:
//   x = u_mul(a, b);
// Description:
//   Multiplies `a` by `b`, returning the result, or undef if either value is `undef`.
//   This emulates the way undefs used to be handled in versions of OpenSCAD before 2020.
// Arguments:
//   a = First value.
//   b = Second value.
function u_mul(a,b) =
    is_undef(a) || is_undef(b)? undef :
    is_vector(a) && is_vector(b)? v_mul(a,b) :
    a * b;

// Section: Processing Arguments to Functions and Modules


// Function: get_anchor()
// Synopsis: Returns the correct anchor from `anchor` and `center`.
// Topics: Argument Handling
// See Also: get_radius()
// Usage:
//   anchr = get_anchor(anchor,center,[uncentered],[dflt]);
// Description:
//   Calculated the correct anchor from `anchor` and `center`.  In order:
//   - If `center` is not `undef` and `center` evaluates as true, then `CENTER` (`[0,0,0]`) is returned.
//   - Otherwise, if `center` is not `undef` and `center` evaluates as false, then the value of `uncentered` is returned.
//   - Otherwise, if `anchor` is not `undef`, then the value of `anchor` is returned.
//   - Otherwise, the value of `dflt` is returned.
//   .
//   This ordering ensures that `center` will override `anchor`.
// Arguments:
//   anchor = The anchor name or vector.
//   center = If not `undef`, this overrides the value of `anchor`.
//   uncentered = The value to return if `center` is not `undef` and evaluates as false.  Default: BOTTOM
//   dflt = The default value to return if both `anchor` and `center` are `undef`.  Default: `CENTER`
// Example:
//   anchr1 = get_anchor(undef, undef, BOTTOM, TOP);  // Returns: [0, 0, 1] (TOP)
//   anchr2 = get_anchor(RIGHT, undef, BOTTOM, TOP);  // Returns: [1, 0, 0] (RIGHT)
//   anchr3 = get_anchor(undef, false, BOTTOM, TOP);  // Returns: [0, 0,-1] (BOTTOM)
//   anchr4 = get_anchor(RIGHT, false, BOTTOM, TOP);  // Returns: [0, 0,-1] (BOTTOM)
//   anchr5 = get_anchor(undef, true,  BOTTOM, TOP);  // Returns: [0, 0, 0] (CENTER)
//   anchr6 = get_anchor(RIGHT, true,  BOTTOM, TOP);  // Returns: [0, 0, 0] (CENTER)
function get_anchor(anchor,center,uncentered=BOT,dflt=CENTER) =
    !is_undef(center)? (center? CENTER : uncentered) :
    !is_undef(anchor)? anchor :
    dflt;

// Function: get_radius()
// Synopsis: Given various radii and diameters, returns the most specific radius.
// Topics: Argument Handling
// See Also: get_anchor()
// Usage:
//   r = get_radius([r1=], [r2=], [r=], [d1=], [d2=], [d=], [dflt=]);
// Description:
//   Given various radii and diameters, returns the most specific radius.  If a diameter is most
//   specific, returns half its value, giving the radius.  If no radii or diameters are defined,
//   returns the value of `dflt`.  Value specificity order is `r1`, `r2`, `d1`, `d2`, `r`, `d`,
//   then `dflt`.  Only one of `r1`, `r2`, `d1`, or `d2` can be defined at once, or else it errors
//   out, complaining about conflicting radius/diameter values.  
// Arguments:
//   ---
//   r1 = Most specific radius.
//   r2 = Second most specific radius.
//   r = Most general radius.
//   d1 = Most specific diameter.
//   d2 = Second most specific diameter.
//   d = Most general diameter.
//   dflt = Value to return if all other values given are `undef`.
// Example:
//   r = get_radius(r1=undef, r=undef, dflt=undef);  // Returns: undef
//   r = get_radius(r1=undef, r=undef, dflt=1);      // Returns: 1
//   r = get_radius(r1=undef, r=6, dflt=1);          // Returns: 6
//   r = get_radius(r1=7, r=6, dflt=1);              // Returns: 7
//   r = get_radius(r1=undef, r2=8, r=6, dflt=1);    // Returns: 8
//   r = get_radius(r1=undef, r2=8, d=6, dflt=1);    // Returns: 8
//   r = get_radius(r1=undef, d=6, dflt=1);          // Returns: 3
//   r = get_radius(d1=7, d=6, dflt=1);              // Returns: 3.5
//   r = get_radius(d1=7, d2=8, d=6, dflt=1);        // Returns: 3.5
//   r = get_radius(d1=undef, d2=8, d=6, dflt=1);    // Returns: 4
//   r = get_radius(r1=8, d=6, dflt=1);              // Returns: 8
function get_radius(r1, r2, r, d1, d2, d, dflt) = 
    assert(num_defined([r1,d1,r2,d2])<2, "Conflicting or redundant radius/diameter arguments given.")
    assert(num_defined([r,d])<2, "Conflicting or redundant radius/diameter arguments given.")
    let(
        rad = !is_undef(r1) ?  r1 
            : !is_undef(d1) ?  d1/2
            : !is_undef(r2) ?  r2
            : !is_undef(d2) ?  d2/2
            : !is_undef(r)  ?  r
            : !is_undef(d)  ?  d/2
            : dflt
    )
    assert(is_undef(dflt) || is_finite(rad) || is_vector(rad), "Invalid radius." )
    rad;

// Function: scalar_vec3()
// Synopsis: Expands a scalar or a list with length less than 3 to a length 3 vector. 
// Topics: Argument Handling
// See Also: get_anchor(), get_radius(), force_list()
// Usage:
//   vec = scalar_vec3(v, [dflt]);
// Description:
//   This is expands a scalar or a list with length less than 3 to a length 3 vector in the
//   same way that OpenSCAD expands short vectors in some contexts, e.g. cube(10) or rotate([45,90]).  
//   If `v` is a scalar, and `dflt==undef`, returns `[v, v, v]`.
//   If `v` is a scalar, and `dflt!=undef`, returns `[v, dflt, dflt]`.
//   if `v` is a list of length 3 or more then returns `v`
//   If `v` is a list and dflt is defined, returns a length 3 list by padding with `dflt`
//   If `v` is a list and dflt is undef, returns a length 3 list by padding with 0
//   If `v` is `undef`, returns `undef`.
// Arguments:
//   v = Value to return vector from.
//   dflt = Default value to set empty vector parts from.
// Example:
//   vec = scalar_vec3(undef);      // Returns: undef
//   vec = scalar_vec3(10);         // Returns: [10,10,10]
//   vec = scalar_vec3(10,1);       // Returns: [10,1,1]
//   vec = scalar_vec3([10,10],1);  // Returns: [10,10,1]
//   vec = scalar_vec3([10,10]);    // Returns: [10,10,0]
//   vec = scalar_vec3([10]);       // Returns: [10,0,0]
function scalar_vec3(v, dflt) =
    is_undef(v)? undef :
    is_list(v)? [for (i=[0:2]) default(v[i], default(dflt, 0))] :
    !is_undef(dflt)? [v,dflt,dflt] : [v,v,v];

// Function: segs()
// Synopsis: Returns the number of sides for a circle given `$fn`, `$fa`, and `$fs`.
// Topics: Geometry
// See Also: circle(), cyl()
// Usage:
//   sides = segs(r, [angle]);
// Description:
//   Calculate the standard number of sides OpenSCAD would give a circle based on `$fn`, `$fa`, and `$fs`.
//   If angle is given, calculate for an arc of the given angle.
// Arguments:
//   r = Radius of circle/arc to get the number of segments for.
//   angle = Angle of arc to get the get the number of segments for.
// Example:
//   $fn=12; sides=segs(10);           // Returns: 12
//   $fa=2; $fs=3; sides=segs(10);     // Returns: 21
//   $fa=2; $fs=3; sides=segs(10,180); // Returns: 11
function segs(r,angle) =
    is_def(angle) ? ceil(segs(r)*abs(angle)/360-2e-15)  // 2e-15 needed in case angle is slightly large due to rounding error
  : $fn>0? ($fn>3? $fn : 3)
  : let( r = is_finite(r)? r : 0 )
    ceil(max(5, min(360/$fa, abs(r)*2*PI/$fs)));

// Module: no_children()
// Synopsis: Assert that the calling module does not support children.
// Topics: Error Checking
// See Also: no_function(), no_module(), req_children()
// Usage:
//   no_children($children);
// Description:
//   Assert that the calling module does not support children.  Prints an error message to this effect and fails if children are present,
//   as indicated by its argument.
// Arguments:
//   $children = number of children the module has.  
// Example(NORENDER):
//   module foo() {
//       no_children($children);
//   }
module no_children(count) {
  assert($children==0, "Module no_children() does not support child modules");
  if ($parent_modules>0) {
      assert(count==0, str("Module ",parent_module(1),"() does not support child modules"));
  }
}

// Module: req_children()
// Synopsis: Assert that the calling module requires children.
// Topics: Error Checking
// See Also: no_function(), no_module()
// Usage:
//   req_children($children);
// Description:
//   Assert that the calling module requires children.  Prints an error message and fails if no
//   children are present as indicated by its argument.
// Arguments:
//   $children = number of children the module has.  
// Example(NORENDER):
//   module foo() {
//       req_children($children);
//   }
module req_children(count) {
  assert($children==0, "Module no_children() does not support child modules");
  if ($parent_modules>0) {
      assert(count>0, str("Module ",parent_module(1),"() requires children"));
  }
}

// onescad: main.scad

cuboid(size, rounding = 2);
