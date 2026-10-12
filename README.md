# RPP E-Transactions Dashboard

A Flutter app that displays Collection and Disbursement e-transaction statistics from the Rajasthan Payment Portal.

## Features

- Collection E-Transactions
- Disbursement E-Transactions
- Individual refresh for each card
- Pull to refresh
- Loading shimmer
- Error and retry handling
- Empty state handling
- Indian number formatting
- Auto refresh every 60 seconds
- Last updated time
- Responsive UI
- 4-second splash screen

## Tech Stack

- Flutter
- Dart
- Provider
- Dio
- Shimmer
- Intl

## Architecture

The project is divided into simple layers:

```text
Presentation
     ↓
Provider
     ↓
Repository
     ↓
API Service
     ↓
Dio
     ↓
RPP API