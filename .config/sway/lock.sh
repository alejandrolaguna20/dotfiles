#!/bin/bash

set -e

TMPBG="/tmp/lockscreen.png"
FONT="/usr/share/fonts/TTF/CrimsonPro-Bold.ttf"

grim "$TMPBG"

QUOTES=(
    "Call me Ishmael|Herman Melville, Moby-Dick"
    "It is better to be feared than loved, if you cannot be both|Niccolò Machiavelli, The Prince"
    "The only way to get rid of temptation is to yield to it|Oscar Wilde, The Picture of Dorian Gray"
    "Nowadays people know the price of everything and the value of nothing|Oscar Wilde, The Picture of Dorian Gray"
    "We are all in the gutter, but some of us are looking at the stars|Oscar Wilde, Lady Windermere's Fan"
    "To define is to limit|Oscar Wilde, The Picture of Dorian Gray"
    "Experience is merely the name men give to their mistakes|Oscar Wilde, The Picture of Dorian Gray"
    "The truth is rarely pure and never simple|Oscar Wilde, The Importance of Being Earnest"
    "It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife|Jane Austen, Pride and Prejudice"
    "There is no greater agony than bearing an untold story inside you|Maya Angelou, I Know Why the Caged Bird Sings"
    "It was the best of times, it was the worst of times|Charles Dickens, A Tale of Two Cities"
    "What are men to rocks and mountains?|Jane Austen, Pride and Prejudice"
    "I have been bent and broken, but - I hope - into a better shape|Charles Dickens, Great Expectations"
    "Suffering has been stronger than all other teaching|Charles Dickens, Great Expectations"
    "All that we see or seem is but a dream within a dream|Edgar Allan Poe, A Dream Within a Dream"
    "I am not what I am|William Shakespeare, Othello"
    "Love looks not with the eyes, but with the mind|William Shakespeare, A Midsummer Night's Dream"
    "We are such stuff as dreams are made on|William Shakespeare, The Tempest"
    "Hell is empty and all the devils are here|William Shakespeare, The Tempest"
    "There is nothing either good or bad, but thinking makes it so|William Shakespeare, Hamlet"
    "To be, or not to be: that is the question|William Shakespeare, Hamlet"
    "The lady doth protest too much, methinks|William Shakespeare, Hamlet"
    "I must be cruel only to be kind|William Shakespeare, Hamlet"
    "All the world's a stage, and all the men and women merely players|William Shakespeare, As You Like It"
    "Some are born great, some achieve greatness, and some have greatness thrust upon 'em|William Shakespeare, Twelfth Night"
    "Parting is such sweet sorrow|William Shakespeare, Romeo and Juliet"
    "In the middle of the journey of our life I found myself in a dark wood, for the straight way was lost|Dante Alighieri, Inferno"
    "Abandon all hope, ye who enter here|Dante Alighieri, Inferno"
    "Do not go gentle into that good night|Dylan Thomas"
    "It is a sin to write this|John Donne"
    "No man is an island entire of itself|John Donne"
    "For whom the bell tolls, it tolls for thee|John Donne"
    "It was a bright cold day in April, and the clocks were striking thirteen|George Orwell, Nineteen Eighty-Four"
    "War is peace, freedom is slavery, ignorance is strength|George Orwell, Nineteen Eighty-Four"
    "All animals are equal, but some animals are more equal than others|George Orwell, Animal Farm"
    "The creatures outside looked from pig to man, and from man to pig, and from pig to man again; but already it was impossible to say which was which|George Orwell, Animal Farm"
    "So we beat on, boats against the current, borne back ceaselessly into the past|F. Scott Fitzgerald, The Great Gatsby"
    "In my younger and more vulnerable years my father gave me some advice that I've been turning over in my mind ever since|F. Scott Fitzgerald, The Great Gatsby"
    "I hope she'll be a fool — that's the best thing a girl can be in this world, a beautiful little fool|F. Scott Fitzgerald, The Great Gatsby"
    "Gatsby believed in the green light, the orgastic future that year by year recedes before us|F. Scott Fitzgerald, The Great Gatsby"
    "I was within and without, simultaneously enchanted and repelled by the inexhaustible variety of life|F. Scott Fitzgerald, The Great Gatsby"
    "It takes two to make an accident|F. Scott Fitzgerald, The Great Gatsby"
    "I want to know what passion is. I want to feel something strongly|Aldous Huxley, Brave New World"
    "But I don't want comfort. I want God, I want poetry, I want real danger, I want freedom, I want goodness. I want sin|Aldous Huxley, Brave New World"
    "One believes things because one has been conditioned to believe them|Aldous Huxley, Brave New World"
    "I feel I've become a giant, and I'm only a small man in a large world|Albert Camus, The Stranger"
    "I opened myself to the gentle indifference of the world|Albert Camus, The Stranger"
    "Man is an animal that makes bargains: no other animal does this - no dog exchanges bones with another|Adam Smith, The Wealth of Nations"
    "There is no such thing as a moral or an immoral book. Books are well written, or badly written|Oscar Wilde, The Picture of Dorian Gray"
    "The mystery of love is greater than the mystery of death|Oscar Wilde, Salomé"
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
