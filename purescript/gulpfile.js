'use strict';

const
	gulp = require('gulp'),
	plumber = require('gulp-plumber'),
	purescript = require('gulp-purescript'),
	browserify = require('gulp-browserify'),
	uglify = require('gulp-uglify'),
	rename = require('gulp-rename');

const sources = [
	'src/**/*.purs',
	'bower_components/purescript-*/src/**/*.purs'
];

const foreigns = [
	'src/**/*.js',
	'bower_components/purescript-*/src/**/*.js'
];

const staticDir = '../static/js/';

gulp.task('psc', function() {
	return purescript.psc({ src: sources, ffi: foreigns });
});

gulp.task('psci', ['psc'], function() {
	return purescript.psci({ src: sources, ffi: foreigns })
		.pipe(gulp.dest('.'));
});

gulp.task('bundle', ['psc', 'psci'], function() {
	return purescript.pscBundle({
		src: 'output/**/*.js', output: 'dist/bundle.js', main: "Main", module: "Main"
	});
});

gulp.task('bundle-static', ['bundle'], function() {
	return gulp
		.src('dist/bundle.js')
		.pipe(gulp.dest(staticDir))
		.pipe(uglify())
		.pipe(rename({ suffix: '.min' }))
		.pipe(gulp.dest(staticDir));
});

// gulp.task('browserify', ['bundle'], function() {
// 	return gulp.src('tmp/bundle.js')
// 		.pipe(browserify())
// 		.pipe(gulp.dest('dist'));
// });

gulp.task('watch', function() {
	gulp.watch('src/**/*.purs', ['bundle-static'])
	gulp.watch('src/**/*.js', ['bundle-static']);
});

gulp.task('default', ['watch', 'bundle-static']);
