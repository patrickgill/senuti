/* 
 * The FadingRed Shared Framework (FSFramework) is the legal property of its developers, whose names
 * are listed in the copyright file included with this source distribution.
 * 
 * This program is free software; you can redistribute it and/or modify it under the terms of the GNU
 * General Public License as published by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
 * Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along with this program; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

/* This code is taken from Sean Patrick O'Brien's iLife Controls
 * and has been minimally modified.  It is published under an MIT
 * license, and that license holds for this file. */

/*
 *     Generated by class-dump 3.1.
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2005 by Steve Nygard.
 */

#import "NSFrameView.h"

@class NSDocumentDragButton;

@interface NSTitledFrame : NSFrameView
{
    int resizeFlags;
    NSDocumentDragButton *fileButton;
    NSSize titleCellSize;
}

+ (void)initialize;
+ (float)_windowBorderThickness:(unsigned int)fp8;
+ (float)_minXWindowBorderWidth:(unsigned int)fp8;
+ (float)_maxXWindowBorderWidth:(unsigned int)fp8;
+ (float)_minYWindowBorderHeight:(unsigned int)fp8;
+ (BOOL)_resizeFromEdge;
+ (NSRect)frameRectForContentRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
+ (NSRect)contentRectForFrameRect:(NSRect)fp8 styleMask:(unsigned int)fp24;
+ (NSSize)minFrameSizeForMinContentSize:(NSSize)fp8 styleMask:(unsigned int)fp16;
+ (NSSize)minContentSizeForMinFrameSize:(NSSize)fp8 styleMask:(unsigned int)fp16;
+ (float)minFrameWidthWithTitle:(id)fp8 styleMask:(unsigned int)fp12;
+ (NSSize)_titleCellSizeForTitle:(id)fp8 styleMask:(unsigned int)fp12;
+ (float)_titleCellHeight:(unsigned int)fp8;
+ (float)_windowTitlebarTitleMinHeight:(unsigned int)fp8;
+ (float)_titlebarHeight:(unsigned int)fp8;
+ (NSSize)sizeOfTitlebarButtons:(unsigned int)fp8;
+ (float)windowTitlebarLinesSpacingWidth:(unsigned int)fp8;
+ (float)windowTitlebarTitleLinesSpacingWidth:(unsigned int)fp8;
+ (float)_contentToFrameMinXWidth:(unsigned int)fp8;
+ (float)_contentToFrameMaxXWidth:(unsigned int)fp8;
+ (float)_contentToFrameMinYHeight:(unsigned int)fp8;
+ (float)_contentToFrameMaxYHeight:(unsigned int)fp8;
- (id)initWithFrame:(NSRect)fp8 styleMask:(unsigned int)fp24 owner:(id)fp28;
- (void)dealloc;
- (void)setIsClosable:(BOOL)fp8;
- (void)setIsResizable:(BOOL)fp8;
- (void)_resetTitleFont;
- (void)_setUtilityWindow:(BOOL)fp8;
- (BOOL)isOpaque;
- (BOOL)worksWhenModal;
- (void)propagateFrameDirtyRects:(NSRect)fp8;
- (void)_showDrawRect:(NSRect)fp8;
- (id)frameHighlightColor;
- (id)frameShadowColor;
- (void)setFrameOrigin:(NSPoint)fp8;
- (void)tileAndSetWindowShape:(BOOL)fp8;
- (void)tile;
- (void)_tileTitlebarAndRedisplay:(BOOL)fp8;
- (void)setTitle:(id)fp8;
- (BOOL)_shouldRepresentFilename;
- (void)setRepresentedFilename:(id)fp8;
- (void)_drawTitleStringIn:(NSRect)fp8 withColor:(id)fp24;
- (id)titleFont;
- (id)titleButtonOfClass:(Class)fp8;
- (id)initTitleButton:(id)fp8;
- (id)newCloseButton;
- (id)newZoomButton;
- (id)newMiniaturizeButton;
- (id)newFileButton;
- (id)fileButton;
- (void)_removeButtons;
- (void)_updateButtons;
- (BOOL)_eventInTitlebar:(id)fp8;
- (BOOL)acceptsFirstMouse:(id)fp8;
- (void)mouseDown:(id)fp8;
- (void)mouseUp:(id)fp8;
- (void)rightMouseDown:(id)fp8;
- (void)rightMouseUp:(id)fp8;
- (int)resizeEdgeForEvent:(id)fp8;
- (NSSize)_resizeDeltaFromPoint:(NSPoint)fp8 toEvent:(id)fp16;
- (NSRect)_validFrameForResizeFrame:(NSRect)fp8 fromResizeEdge:(int)fp24;
- (NSRect)frame:(NSRect)fp8 resizedFromEdge:(int)fp24 withDelta:(NSSize)fp28;
- (BOOL)constrainResizeEdge:(int *)fp8 withDelta:(NSSize)fp12 elapsedTime:(float)fp20;
- (void)resizeWithEvent:(id)fp8;
- (int)resizeFlags;
- (void)resetCursorRects;
- (void)setDocumentEdited:(BOOL)fp8;
- (NSSize)miniaturizedSize;
- (NSSize)minFrameSize;
- (float)_windowBorderThickness;
- (float)_windowTitlebarXResizeBorderThickness;
- (float)_windowTitlebarYResizeBorderThickness;
- (float)_windowResizeBorderThickness;
- (float)_minXWindowBorderWidth;
- (float)_maxXWindowBorderWidth;
- (float)_minYWindowBorderHeight;
- (id)_customTitleCell;
- (void)_invalidateTitleCellSize;
- (void)_invalidateTitleCellWidth;
- (float)_titleCellHeight;
- (NSSize)_titleCellSize;
- (float)_titlebarHeight;
- (NSRect)titlebarRect;
- (NSRect)_maxTitlebarTitleRect;
- (NSRect)_titlebarTitleRect;
- (float)_windowTitlebarTitleMinHeight;
- (NSRect)dragRectForFrameRect:(NSRect)fp8;
- (NSSize)sizeOfTitlebarButtons;
- (NSSize)_sizeOfTitlebarFileButton;
- (float)_windowTitlebarButtonSpacingWidth;
- (float)_minXTitlebarButtonsWidth;
- (float)_maxXTitlebarButtonsWidth;
- (int)_numberOfTitlebarLines;
- (float)windowTitlebarLinesSpacingWidth;
- (float)windowTitlebarTitleLinesSpacingWidth;
- (float)_minLinesWidthWithSpace;
- (NSRect)_minXTitlebarLinesRectWithTitleCellRect:(NSRect)fp8;
- (NSRect)_maxXTitlebarLinesRectWithTitleCellRect:(NSRect)fp8;
- (float)_minXTitlebarDecorationMinWidth;
- (float)_maxXTitlebarDecorationMinWidth;
- (NSPoint)_closeButtonOrigin;
- (NSPoint)_zoomButtonOrigin;
- (NSPoint)_collapseButtonOrigin;
- (NSPoint)_fileButtonOrigin;
- (float)_maxYTitlebarDragHeight;
- (float)_minXTitlebarDragWidth;
- (float)_maxXTitlebarDragWidth;
- (float)_contentToFrameMinXWidth;
- (float)_contentToFrameMaxXWidth;
- (float)_contentToFrameMinYHeight;
- (float)_contentToFrameMaxYHeight;
- (NSRect)contentRect;
- (float)_windowResizeCornerThickness;
- (NSRect)_minYResizeRect;
- (NSRect)_minYminXResizeRect;
- (NSRect)_minYmaxXResizeRect;
- (NSRect)_minXResizeRect;
- (NSRect)_minXminYResizeRect;
- (NSRect)_minXmaxYResizeRect;
- (NSRect)_maxYResizeRect;
- (NSRect)_maxYminXResizeRect;
- (NSRect)_maxYmaxXResizeRect;
- (NSRect)_maxXResizeRect;
- (NSRect)_maxXminYResizeRect;
- (NSRect)_maxXmaxYResizeRect;
- (NSRect)_minXTitlebarResizeRect;
- (NSRect)_maxXTitlebarResizeRect;
- (NSRect)_minXBorderRect;
- (NSRect)_maxXBorderRect;
- (NSRect)_maxYBorderRect;
- (NSRect)_minYBorderRect;

@end

