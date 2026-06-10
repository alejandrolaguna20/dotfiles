#!/bin/bash

set -e

TMPBG="/tmp/lockscreen.png"
FONT="/usr/share/fonts/TTF/CrimsonPro-Bold.ttf"

grim "$TMPBG"

QUOTES=(
    "The butterfly counts not months but moments, and has time enough|Rabindranath Tagore"
    "The quieter you become, the more you are able to hear|Ramana Maharshi"
    "To understand the immeasurable, the mind must be extraordinarily quiet|Jiddu Krishnamurti"
    "Sometimes I go about pitying myself, and all the while I am being carried on great winds across the sky|Ojibwe saying"
    "Walk as if you are kissing the Earth with your feet|Thich Nhat Hanh"
    "The real voyage of discovery consists not in seeking new landscapes, but in having new eyes|Marcel Proust"
    "The only way to deal with an unfree world is to become so absolutely free that your very existence is an act of rebellion|Albert Camus"
    "In the depth of winter, I finally learned that within me there lay an invincible summer|Albert Camus"
    "I am no bird; and no net ensnares me|Charlotte Brontë"
    "Life is not a problem to be solved, but a reality to be experienced|Søren Kierkegaard"
    "Until you make the unconscious conscious, it will direct your life and you will call it fate|Carl Jung"
    "Who looks outside, dreams; who looks inside, awakes|Carl Jung"
    "The privilege of a lifetime is to become who you truly are|Carl Jung"
    "We have art in order not to die of the truth|Friedrich Nietzsche"
    "He who has a why to live can bear almost any how|Friedrich Nietzsche"
    "There is always some madness in love. But there is also always some reason in madness|Friedrich Nietzsche"
    "One must give value to their existence by behaving as if one's very existence were a work of art|Friedrich Nietzsche"
    "Everything was beautiful and nothing hurt|Kurt Vonnegut"
    "The soul becomes dyed with the color of its thoughts|Marcus Aurelius"
    "We are what we repeatedly do. Excellence, then, is not an act but a habit|Aristotle"
    "The mind is not a vessel to be filled, but a fire to be kindled|Plutarch"
    "I know that I know nothing|Socrates"
    "Knowing others is wisdom; knowing yourself is enlightenment|Laozi"
    "When you realize there is nothing lacking, the whole world belongs to you|Laozi"
    "Flow with whatever may happen and let your mind be free: stay centered by accepting whatever you are doing|Zhuangzi"
    "The wound is the place where the Light enters you|Rumi"
    "Out beyond ideas of wrongdoing and rightdoing, there is a field. I will meet you there|Rumi"
    "Sell your cleverness and buy bewilderment|Rumi"
    "Travel — it leaves you speechless, then turns you into a storyteller|Ibn Battuta"
    "The beginning of wisdom is to call things by their right names|Ibn Khaldun"
    "In the beginner's mind there are many possibilities; in the expert's mind there are few|Shunryu Suzuki"
    "Before enlightenment, chop wood, carry water. After enlightenment, chop wood, carry water|Zen proverb"
    "The pine tree endures the storm because it has deep roots|Vietnamese proverb"
    "Until the lion learns to write, every story will glorify the hunter|African proverb"
    "I am because we are|Ubuntu philosophy"
    "The axe forgets, but the tree remembers|Zimbabwean proverb"
    "If you want to go fast, go alone. If you want to go far, go together|African proverb"
    "A child who is not embraced by the village will burn it down to feel its warmth|African proverb"
    "There is no agony like bearing an untold story inside you|Zora Neale Hurston"
    "They tried to bury us. They did not know we were seeds|Mexican proverb"
    "We do not inherit the earth from our ancestors; we borrow it from our children|Indigenous proverb"
    "Not everything that is faced can be changed, but nothing can be changed until it is faced|James Baldwin"
    "The function of freedom is to free someone else|Toni Morrison"
    "The most common way people give up their power is by thinking they don't have any|Alice Walker"
    "Still, like dust, I'll rise|Maya Angelou"
    "One is not born, but rather becomes, a woman|Simone de Beauvoir"
    "I am not free while any woman is unfree, even when her shackles are very different from my own|Audre Lorde"
    "The most effective way to do it, is to do it|Amelia Earhart"
    "When the whole world is silent, even one voice becomes powerful|Malala Yousafzai"
)

# Pick random quote
RANDOM_QUOTE=${QUOTES[$RANDOM % ${#QUOTES[@]}]}
QUOTE=$(echo "$RANDOM_QUOTE" | cut -d'|' -f1)
AUTHOR=$(echo "$RANDOM_QUOTE" | cut -d'|' -f2)

magick "$TMPBG" \
    -blur 0x18 \
    \
    \( \
        -background none \
        -fill "#00000088" \
        -font "$FONT" \
        -pointsize 38 \
        label:"$QUOTE" \
    \) \
    -gravity southeast \
    -geometry +78+82 \
    -composite \
    \
    \( \
        -background none \
        -fill "#FFFFFFEE" \
        -font "$FONT" \
        -pointsize 38 \
        label:"$QUOTE" \
    \) \
    -gravity southeast \
    -geometry +80+80 \
    -composite \
    \
    \( \
        -background none \
        -fill "#00000066" \
        -font "$FONT" \
        -pointsize 16 \
        label:"$AUTHOR" \
    \) \
    -gravity southeast \
    -geometry +78+48 \
    -composite \
    \
    \( \
        -background none \
        -fill "#FFFFFF99" \
        -font "$FONT" \
        -pointsize 16 \
        label:"$AUTHOR" \
    \) \
    -gravity southeast \
    -geometry +80+50 \
    -composite \
    \
    "$TMPBG"

exec swaylock -i "$TMPBG"
