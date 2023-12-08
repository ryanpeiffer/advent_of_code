import sys
import re

#read inputs
input = open('inputs/day7input.txt').read().strip()
lines = input.split('\n')
#part 1
print('part 1')

hands = []
bids = []
for line in lines:
    hand, bid = line.split()
    hands.append(hand)
    bids.append(bid)
bids = list(map(int, bids))
     
valid_cards = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
hand_scores = []

for hand in hands:
    card_matches = [hand.count(card) for card in valid_cards]
    
    #rank by the type of hand. setting these to over 1m so the indiv card numbers below cant change order
    if max(card_matches) == 5:
        hand_type_score = 7e6
    elif max(card_matches) == 4:
        hand_type_score = 6e6
    elif max(card_matches) == 3:
        if 2 in card_matches:
            hand_type_score = 5e6
        else:
            hand_type_score = 4e6
    elif max(card_matches) == 2:
        if card_matches.count(2) == 2:
            hand_type_score = 3e6
        else:
            hand_type_score = 2e6
    else:
        hand_type_score = 1e6
        
    #gather up the value of each individual card in case of ties
    card_score = 0
    i = 0
    #print(hand)
    for card in hand[::-1]:
    	#i played with this in excel, i think this works lol
        this_card_score = (valid_cards.index(card)+1) * ((len(valid_cards)+1)**i) 
        card_score += this_card_score
        #print('card ' + card + ' score ' + str(card_score))
        i+=1
    
    hand_scores.append(hand_type_score + card_score)

#create dataset of hands, types, bids sorted by type
big_data = sorted(zip(hands, hand_scores, bids), key = lambda x: x[1], reverse = False)
#print(big_data)

final_bids = [item[2] for item in big_data] 
ans = sum([value * (index + 1) for index, value in enumerate(final_bids)])
print(ans)


#part 2
print('part 2')
p2_valid_cards = ['J', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'Q', 'K', 'A']

hand_scores = []

for hand in hands:
    all_card_matches = [hand.count(card) for card in p2_valid_cards]
    joker_count = all_card_matches[0]
    card_matches = all_card_matches[1:]
    #rank by the type of hand
    if max(card_matches) == 5 or joker_count >= 4:
        hand_type_score = 7e6
    elif joker_count == 3:
        if max(card_matches) == 2:
            hand_type_score = 7e6
        else:
            hand_type_score = 6e6
    elif max(card_matches) == 4:
        if joker_count == 1:
            hand_type_score = 7e6
        else:
            hand_type_score = 6e6
    elif max(card_matches) == 3:
        if joker_count == 2:
            hand_type_score = 7e6
        elif joker_count == 1:
            hand_type_score = 6e6
        else:
            if 2 in card_matches:
                hand_type_score = 5e6
            else:
                hand_type_score = 4e6
    elif max(card_matches) == 2:
        if joker_count == 2:
            hand_type_score = 6e6 
        elif card_matches.count(2) == 2 and joker_count == 1:
            hand_type_score = 5e6
        elif joker_count == 1:
            hand_type_score = 4e6
        elif card_matches.count(2) == 2 and joker_count == 0:
            hand_type_score = 3e6
        else:
            hand_type_score = 2e6
    else:
        if joker_count == 2:
            hand_type_score = 4e6
        elif joker_count == 1:
            hand_type_score = 2e6
        else:
            hand_type_score = 1e6
        
    #gather up the value of each individual card in case of ties
    card_score = 0
    i = 0
    #print(hand)
    for card in hand[::-1]:
    	#i played with this in excel, i think this works lol
        this_card_score = (p2_valid_cards.index(card)+1) * ((len(p2_valid_cards)+1)**i) 
        card_score += this_card_score
        #print('card ' + card + ' score ' + str(card_score))
        i+=1
    
    hand_scores.append(hand_type_score + card_score)

#create dataset of hands, types, bids sorted by type
big_data = sorted(zip(hands, hand_scores, bids), key = lambda x: x[1], reverse = False)
#print(big_data)

final_bids = [item[2] for item in big_data] 
ans = sum([value * (index + 1) for index, value in enumerate(final_bids)])
print(ans)