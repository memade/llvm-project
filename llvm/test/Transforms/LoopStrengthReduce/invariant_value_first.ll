; Check that the index of 'P[outer]' is pulled out of the loop.
; RUN: opt < %s -loop-reduce -S | \
; RUN:   not grep "getelementptr.*ptr %INDVAR"

target datalayout = "e-p:32:32:32-n8:16:32"
declare i1 @pred()

declare i32 @foo()

define void @test(ptr %P) {
; <label>:0
	%outer = call i32 @foo( )		; <i32> [#uses=1]
	br label %Loop
Loop:		; preds = %Loop, %0
	%INDVAR = phi i32 [ 0, %0 ], [ %INDVAR2, %Loop ]		; <i32> [#uses=2]
	%STRRED = getelementptr [10000 x i32], ptr %P, i32 %outer, i32 %INDVAR		; <ptr> [#uses=1]
	store i32 0, ptr %STRRED
	%INDVAR2 = add i32 %INDVAR, 1		; <i32> [#uses=1]
	%cond = call i1 @pred( )		; <i1> [#uses=1]
	br i1 %cond, label %Loop, label %Out
Out:		; preds = %Loop
	ret void
}

