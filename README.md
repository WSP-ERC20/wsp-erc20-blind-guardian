# Blind Guardian
The Blind Guardian is a smart contract that guards ether. It allows for the transfer of Ether and for a locktime to be set. The ethereum only may retrieve their funds after the given locktime passes. Each depositor may create a multi key fallback. E.g. 2 of 3 other accounts may signal to the contract to the delay the fund dispersement and/or defer withdrawal to a fallback address.

It can be used to protect assets in the event that a high value hodler were to travel through a hostile area they may designate two unknown fallbacks who trigger the delay of fund withdrawal in the event of kidnapping. This absolves the Ether holder of the risk of extortion or the famous XKCD monkey wrench interrogation method of defeating strong crypto.

Less grimm applications include fund dispersement over time for trusts, allowance, basic income payments. It should be possible to work a deal with a bank where the hodler stashes N Ether with the blind guardian in exchange for a credit line / debit card that allows them to make visa-like purchases at the spot price of Ether. After the locktime resolves, settle with the ammount due and start again.

## Usage

To initialize a project with this exapmple, run `truffle init webpack` inside an empty directory.

## Building and the frontend

1. First run `truffle compile`, then run `truffle migrate` to deploy the contracts onto your network of choice (default "development").
1. Then run `npm run dev` to build the app and serve it on http://localhost:8080
