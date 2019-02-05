#pragma once

//
// t2.h
//
// Copyright (C) 2012 - 2017 jones@scss.tcd.ie
//
// example of mixing C++ and x64 assembly language
//

//
// NB: "extern C" to avoid procedure name mangling by C++ compiler
//

extern "C" _int64 g = 4;
extern "C" _int64 min(_int64 a, _int64 b, _int64 c);			// min
extern "C" _int64 p(_int64 i, _int64 j, _int64 k, _int64 l);
extern "C" _int64 gcd(_int64 a, _int64 b);

											// eof#pragma once
