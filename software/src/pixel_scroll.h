#ifndef PIXEL_SCROLL_H_
#define PIXEL_SCROLL_H_

/* Pure pixel-position math shared by the board UI and host-side tests. */
static inline unsigned int pixel_scroll_max(unsigned int count,
                                             unsigned int row_px,
                                             unsigned int viewport_px)
{
    unsigned int content_px = count * row_px;
    return content_px > viewport_px ? content_px - viewport_px : 0U;
}

static inline unsigned int pixel_scroll_drag(unsigned int current,
                                              int last_y, int y,
                                              unsigned int maximum)
{
    int next = (int)current + last_y - y;
    if (next < 0) return 0U;
    if ((unsigned int)next > maximum) return maximum;
    return (unsigned int)next;
}

#endif
