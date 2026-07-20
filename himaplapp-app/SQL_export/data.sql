SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict MY3SQftKiCuJXoRSdEf0abgb08TI989abNVI0K1Reu5o44fy2Ja9AQycigJbgo7

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") VALUES
	('92d28380-f5f9-4a87-9941-919a8c54454a', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-01 20:20:45.93249+00', '2026-07-01 20:20:45.93249+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/profile', NULL, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false),
	('5165116f-5ab7-46f8-8ae1-4393b56e0a1f', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-01 20:26:36.987175+00', '2026-07-01 20:26:36.987175+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/profile', NULL, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false),
	('25e1bf42-e282-47b9-b644-14fa1686be71', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-01 20:27:05.361779+00', '2026-07-01 20:27:05.361779+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/profile', NULL, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false),
	('652c00d4-9e7f-4188-b087-450b46991b6a', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-02 10:39:13.708143+00', '2026-07-02 10:39:13.708143+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/home', NULL, NULL, false),
	('e7a90302-0724-47c1-b372-778f0b30ce46', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-02 10:42:03.3431+00', '2026-07-02 10:42:03.3431+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/home', NULL, NULL, false),
	('7338e7e5-d308-4905-8ce9-da80c8812862', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-02 10:42:11.330296+00', '2026-07-02 10:42:11.330296+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/home', NULL, NULL, false),
	('fe8ab600-c378-4c36-bbf9-c9318784bd1b', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-02 10:52:18.511134+00', '2026-07-02 10:52:18.511134+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/home', NULL, NULL, false),
	('1814a56b-8330-41ef-957c-71c490ed2d72', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-02 10:52:44.906437+00', '2026-07-02 10:52:44.906437+00', 'oauth', NULL, NULL, 'http://localhost:8100/tabs/home', NULL, NULL, false),
	('6a54ca0e-31bd-45db-a56f-3b02455d61c8', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-12 12:17:09.141699+00', '2026-07-12 12:17:09.141699+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false),
	('9eb70712-7c67-43f5-8c09-d6973231a6c3', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-06 11:44:56.986087+00', '2026-07-06 11:44:56.986087+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false),
	('983d4fbe-30b9-45d0-b933-ec4d400a5c46', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-12 15:00:34.996123+00', '2026-07-12 15:00:34.996123+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false),
	('be61055f-024d-491d-a454-658c23698405', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-12 15:02:51.72761+00', '2026-07-12 15:02:51.72761+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false),
	('88e5d66d-7a1c-446f-9896-e5efc3cded91', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-07 11:17:29.396827+00', '2026-07-07 11:17:29.396827+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false),
	('6f8809e1-ebb3-49ea-a49c-ce4a4f963e28', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-04 15:02:26.267823+00', '2026-07-04 15:02:26.267823+00', 'oauth', NULL, NULL, 'http://localhost:3000', NULL, NULL, false),
	('41254d1c-8e8c-47ca-8269-0cf26d40c1c3', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-04 15:03:43.829585+00', '2026-07-04 15:03:43.829585+00', 'oauth', NULL, NULL, 'http://localhost:3000', NULL, NULL, false),
	('57444a7c-5b04-4ec3-ae38-89b6ddf2ef2b', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-12 16:39:09.074687+00', '2026-07-12 16:39:09.074687+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false),
	('67c6a1dc-f6e2-46db-8da3-48f3cb4b1e0b', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-13 00:06:58.735141+00', '2026-07-13 00:06:58.735141+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false),
	('cdb04a71-2dcb-4b88-803c-a99c8e33a689', NULL, NULL, NULL, NULL, 'google', '', '', '2026-07-13 14:14:46.448298+00', '2026-07-13 14:14:46.448298+00', 'oauth', NULL, NULL, 'himaplapp://tabs/home', NULL, NULL, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'ce9b2af7-7dc5-4f1c-9a27-c72763248335', 'authenticated', 'authenticated', 'himapltestdosen@gmail.com', '$2a$10$DOJM/9DSu4MPsUPCQqOeFOSUqQqh.NMdTza7mJIDiVY8EFCHS.xzK', '2026-07-12 11:50:26.629668+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-12 11:50:26.636685+00', '{"provider": "email", "providers": ["email"]}', '{"nim": "1122334455", "sub": "ce9b2af7-7dc5-4f1c-9a27-c72763248335", "email": "himapltestdosen@gmail.com", "full_name": "Himapl Dosen", "email_verified": true, "phone_verified": false}', NULL, '2026-07-12 11:50:05.818131+00', '2026-07-12 11:51:16.457336+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'bbae5596-70f5-4491-8bcf-01ae43e701f7', 'authenticated', 'authenticated', 'me@uvers.ac.id', '$2a$10$zkAS6wqciTswFJvGF9dksOTZcoif/tAlv9voywEk2pRQHXEew15ke', NULL, NULL, '0631dac7326f6e7be71100450e0241468484b704fc79a4d0b89943d3', '2026-07-13 00:07:41.7758+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"nim": "2022133000", "sub": "bbae5596-70f5-4491-8bcf-01ae43e701f7", "email": "me@uvers.ac.id", "full_name": "me", "email_verified": false, "phone_verified": false}', NULL, '2026-07-13 00:07:41.680592+00', '2026-07-13 00:07:43.57357+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'authenticated', 'authenticated', 'leex5568@gmail.com', '$2a$10$ZtefwjJVQfCxmunaftO7GeHStj7y4vZ9upkYhlXY0adPLkmRuiJnK', '2026-06-23 11:25:16.714298+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-13 08:59:17.222105+00', '{"provider": "email", "providers": ["email", "google"]}', '{"iss": "https://accounts.google.com", "nim": "1234567890", "sub": "115066864125882760064", "name": "Alex Ferguson", "email": "leex5568@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIQOtEwyKbq6TNRXWOleCH2QBxB9mpaeU5SAikvkwagx9Xk2Q=s96-c", "full_name": "Alex Ferguson", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIQOtEwyKbq6TNRXWOleCH2QBxB9mpaeU5SAikvkwagx9Xk2Q=s96-c", "provider_id": "115066864125882760064", "email_verified": true, "phone_verified": false}', NULL, '2026-06-23 11:24:48.293175+00', '2026-07-13 14:14:38.286982+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '84fa6077-753c-4c79-99aa-bee2a82690f6', 'authenticated', 'authenticated', 'leex568@gmail.com', NULL, '2026-07-07 11:18:31.343673+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-07 11:23:00.419616+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "117585973386214160506", "name": "Alex Ferguson", "email": "leex568@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocL16dWVzTcsKOtGQ5PB2kgEmX3j8VizuJWF4BDO0qBEb6SHUQ=s96-c", "full_name": "Alex Ferguson", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocL16dWVzTcsKOtGQ5PB2kgEmX3j8VizuJWF4BDO0qBEb6SHUQ=s96-c", "provider_id": "117585973386214160506", "email_verified": true, "phone_verified": false}', NULL, '2026-07-07 11:18:31.329416+00', '2026-07-07 11:23:00.427332+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'dd4792af-61c7-46c6-b142-dac0fbf87083', 'authenticated', 'authenticated', 'alexferguson5568@gmail.com', '$2a$10$6QXvoHTG5eylseKZyj64Fu7SmbxbypSBobDh5/PpWSmK8eqHibVgm', '2026-06-23 11:07:04.114634+00', NULL, '', '2026-06-23 11:06:39.369256+00', '', '2026-07-07 09:12:02.28248+00', '', '', NULL, '2026-07-13 08:58:40.034195+00', '{"provider": "email", "providers": ["email", "google"]}', '{"iss": "https://accounts.google.com", "nim": "2022133011", "sub": "102716447679129093130", "name": "Alex Ferguson", "email": "alexferguson5568@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKhvyMIuzv_nb5L6MXx54V_MO2vypCh1ok4tl6AAj6bxRNA7Q=s96-c", "full_name": "Alex Ferguson", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKhvyMIuzv_nb5L6MXx54V_MO2vypCh1ok4tl6AAj6bxRNA7Q=s96-c", "provider_id": "102716447679129093130", "email_verified": true, "phone_verified": false}', NULL, '2026-06-23 11:06:39.334015+00', '2026-07-13 08:58:40.039329+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '29fdb77a-bf17-4032-ac54-a50c262769a7', 'authenticated', 'authenticated', 'vivietriyanti0921@uvers.ac.id', '$2a$10$cKOlw1Kg3N78JO6f578T4uslLDoga7yU/xAMXvBhFGR8cIWQ9RWoK', NULL, NULL, 'a8f47a4d8e34960af2dd8e81fcd5dc1261308eec88502ce1a10bd573', '2026-07-12 15:00:59.383653+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"nim": "2022133004", "sub": "29fdb77a-bf17-4032-ac54-a50c262769a7", "email": "vivietriyanti0921@uvers.ac.id", "full_name": "Vivie", "email_verified": false, "phone_verified": false}', NULL, '2026-07-12 14:58:04.943493+00', '2026-07-12 15:01:01.031083+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '62356062-e6e9-4e16-8e82-293e0ccba2fd', 'authenticated', 'authenticated', 'venessyacalista@gmail.com', NULL, '2026-07-06 11:03:04.220086+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-06 11:03:04.232622+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "104205576010131698809", "name": "Venessya Calista", "email": "venessyacalista@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocI1C0hPkuUpk8HPRKfP512vMbO_zgP29YkWi4d5WBHHCQ6kTN99=s96-c", "full_name": "Venessya Calista", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocI1C0hPkuUpk8HPRKfP512vMbO_zgP29YkWi4d5WBHHCQ6kTN99=s96-c", "provider_id": "104205576010131698809", "email_verified": true, "phone_verified": false}', NULL, '2026-07-06 11:03:04.118967+00', '2026-07-06 11:03:04.276561+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'c7b09eca-4095-4655-90d2-84ea06e21236', 'authenticated', 'authenticated', 'nextlvlgameshop@gmail.com', NULL, '2026-07-06 11:15:55.811461+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-06 11:15:55.818272+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "116282741045635798711", "name": "Nexl Level", "email": "nextlvlgameshop@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIHkPdVk7qAZ3PEoeIwkavdpq4rphw1BGPixKMvEKSXwbIuZw=s96-c", "full_name": "Nexl Level", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIHkPdVk7qAZ3PEoeIwkavdpq4rphw1BGPixKMvEKSXwbIuZw=s96-c", "provider_id": "116282741045635798711", "email_verified": true, "phone_verified": false}', NULL, '2026-07-06 11:15:55.768619+00', '2026-07-06 11:15:55.824117+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '29faba6b-83b1-4053-8d04-053e92bcc2e7', 'authenticated', 'authenticated', 'edsn197@gmail.com', NULL, '2026-07-12 15:04:07.148949+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-12 15:08:33.568406+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "117924489802331684812", "name": "Edison", "email": "edsn197@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKxVC3ZG_W5H0eBb7JLPc5SR5oQH2zpiRxQ5U-nnFDf9s2lgg=s96-c", "full_name": "Edison", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKxVC3ZG_W5H0eBb7JLPc5SR5oQH2zpiRxQ5U-nnFDf9s2lgg=s96-c", "provider_id": "117924489802331684812", "email_verified": true, "phone_verified": false}', NULL, '2026-07-12 15:04:07.133257+00', '2026-07-12 15:08:33.570225+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '4a7ed672-33a4-4cb7-bab2-e10c436879fd', 'authenticated', 'authenticated', 'himaplketuah@gmail.com', '$2a$10$BftKlF/2oD1y/v1eYomDyuz2.vQlJrhH81.72gCW3pFgIO8tDIJ7K', '2026-07-12 12:18:03.732243+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-13 14:15:01.253163+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "103999107588662885621", "name": "Himapl Ketua Himpunan", "email": "himaplketuah@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIfLrhhwtP6EUWlcsSalWXodOj2LEu3SZdNxPsA8UQaHMjbjg=s96-c", "full_name": "Himapl Ketua Himpunan", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIfLrhhwtP6EUWlcsSalWXodOj2LEu3SZdNxPsA8UQaHMjbjg=s96-c", "provider_id": "103999107588662885621", "email_verified": true, "phone_verified": false}', NULL, '2026-07-12 12:18:03.715029+00', '2026-07-13 14:15:01.258474+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '2051e56d-f59e-49bc-9a41-f258ba24da6c', 'authenticated', 'authenticated', 'himaplketuad@gmail.com', '$2a$10$QZJXok0Y2F0DN3rhEAeyl.PUhsaGQLhSeecsVov4pACNwg9Y12O4i', '2026-07-12 12:19:42.361222+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-12 15:10:16.960431+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "107909826733656456991", "name": "Himapl Ketua Divisi", "email": "himaplketuad@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJ9qrjPQHVC6GZoKDMcvZCUgcSsVeZ1dSj31e-6aA9LPoQGjQ=s96-c", "full_name": "Himapl Ketua Divisi", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJ9qrjPQHVC6GZoKDMcvZCUgcSsVeZ1dSj31e-6aA9LPoQGjQ=s96-c", "provider_id": "107909826733656456991", "email_verified": true, "phone_verified": false}', NULL, '2026-07-12 12:19:42.346488+00', '2026-07-12 15:10:16.977267+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', 'authenticated', 'authenticated', 'vivietriyanti0921@gmail.com', NULL, '2026-07-12 15:01:35.236395+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-12 15:01:35.241741+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "109774784043689286340", "name": "Vivie Triyanti", "email": "vivietriyanti0921@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJNsEQ9X33c-4mzR-hRyglQfAktCtgE0OAr_L9Wb4vqBRpawQ=s96-c", "full_name": "Vivie Triyanti", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJNsEQ9X33c-4mzR-hRyglQfAktCtgE0OAr_L9Wb4vqBRpawQ=s96-c", "provider_id": "109774784043689286340", "email_verified": true, "phone_verified": false}', NULL, '2026-07-12 15:01:35.227753+00', '2026-07-12 15:01:35.274643+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '219a4f40-b531-4956-9413-5a114c032334', 'authenticated', 'authenticated', 'theonanda.tom@gmail.com', NULL, '2026-07-12 15:04:52.236991+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-12 15:04:52.239811+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "108632446168851972910", "name": "Tommy Theonanda", "email": "theonanda.tom@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLw85WR5HuSRpn-oG5XZ1Pv_x6AGjFM8-EhTyr10vwSCiwbUq3f=s96-c", "full_name": "Tommy Theonanda", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocLw85WR5HuSRpn-oG5XZ1Pv_x6AGjFM8-EhTyr10vwSCiwbUq3f=s96-c", "provider_id": "108632446168851972910", "email_verified": true, "phone_verified": false}', NULL, '2026-07-12 15:04:52.21114+00', '2026-07-18 06:21:15.682284+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', 'authenticated', 'authenticated', 'hermanyang2803@uvers.ac.id', NULL, '2026-07-13 00:08:24.48964+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-13 00:08:24.493972+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "100297427450550705230", "name": "Herman TPL 2022", "email": "hermanyang2803@uvers.ac.id", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIhuPiLfvd5ep0mb6QC0bk273bFUJfu1P6-ocivqwmxX2Fl5GhG=s96-c", "full_name": "Herman TPL 2022", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIhuPiLfvd5ep0mb6QC0bk273bFUJfu1P6-ocivqwmxX2Fl5GhG=s96-c", "provider_id": "100297427450550705230", "custom_claims": {"hd": "uvers.ac.id"}, "email_verified": true, "phone_verified": false}', NULL, '2026-07-13 00:08:24.483097+00', '2026-07-13 00:08:24.538857+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '0e54a436-b68e-4e69-a31b-6eae5db4d623', 'authenticated', 'authenticated', 'hadi.s256314@uvers.ac.id', NULL, '2026-07-12 16:45:05.593022+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-12 16:45:05.599229+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "101389371319599277465", "name": "Hadi Susanto TPL 2022", "email": "hadi.s256314@uvers.ac.id", "picture": "https://lh3.googleusercontent.com/a/ACg8ocI8qyiVx8H0F9uHWCjAWG464-pISa7TJkjPbqahhfjvUA7piA=s96-c", "full_name": "Hadi Susanto TPL 2022", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocI8qyiVx8H0F9uHWCjAWG464-pISa7TJkjPbqahhfjvUA7piA=s96-c", "provider_id": "101389371319599277465", "custom_claims": {"hd": "uvers.ac.id"}, "email_verified": true, "phone_verified": false}', NULL, '2026-07-12 16:45:05.570938+00', '2026-07-12 16:45:05.627566+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', 'authenticated', 'authenticated', 'dripcakeofficial@gmail.com', NULL, '2026-07-13 08:26:42.791229+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-13 08:26:42.802454+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "109091406371973442750", "name": "Drip Cake", "email": "dripcakeofficial@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJMVZb90XANLVub7VILU9F9QgdveZdi8klEkpZa0cIz2Rh2kRY=s96-c", "full_name": "Drip Cake", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJMVZb90XANLVub7VILU9F9QgdveZdi8klEkpZa0cIz2Rh2kRY=s96-c", "provider_id": "109091406371973442750", "email_verified": true, "phone_verified": false}', NULL, '2026-07-13 08:26:42.72618+00', '2026-07-13 08:26:42.838114+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'ac4cbe57-8fb4-4603-b854-1057aa6e61e3', 'authenticated', 'authenticated', 'shereenclarentio9@gmail.com', NULL, '2026-07-14 04:11:08.26213+00', NULL, '', NULL, '', NULL, '', '', NULL, '2026-07-14 04:11:08.273029+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "101027125842473619772", "name": "Shereen Clarentio", "email": "shereenclarentio9@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKdATXuOubuSIjCIK8iMn_2qMtg6-SUKUlMlqxfvgKHOVMZXA=s96-c", "full_name": "Shereen Clarentio", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKdATXuOubuSIjCIK8iMn_2qMtg6-SUKUlMlqxfvgKHOVMZXA=s96-c", "provider_id": "101027125842473619772", "email_verified": true, "phone_verified": false}', NULL, '2026-07-14 04:11:08.18433+00', '2026-07-14 04:11:08.321274+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('dd4792af-61c7-46c6-b142-dac0fbf87083', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '{"nim": "2022133011", "sub": "dd4792af-61c7-46c6-b142-dac0fbf87083", "email": "alexferguson5568@gmail.com", "full_name": "Alex Ferguson", "email_verified": true, "phone_verified": false}', 'email', '2026-06-23 11:06:39.362669+00', '2026-06-23 11:06:39.363334+00', '2026-06-23 11:06:39.363334+00', '0a1db221-5a8d-44fe-bd1f-75f246948839'),
	('059b7fe5-6da6-4aff-a175-72828e2bdd0d', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '{"nim": "1234567890", "sub": "059b7fe5-6da6-4aff-a175-72828e2bdd0d", "email": "leex5568@gmail.com", "full_name": "Double T", "email_verified": true, "phone_verified": false}', 'email', '2026-06-23 11:24:48.346696+00', '2026-06-23 11:24:48.346749+00', '2026-06-23 11:24:48.346749+00', '3e4de969-da90-4ba0-b556-bfe64df64e80'),
	('117585973386214160506', '84fa6077-753c-4c79-99aa-bee2a82690f6', '{"iss": "https://accounts.google.com", "sub": "117585973386214160506", "name": "Alex Ferguson", "email": "leex568@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocL16dWVzTcsKOtGQ5PB2kgEmX3j8VizuJWF4BDO0qBEb6SHUQ=s96-c", "full_name": "Alex Ferguson", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocL16dWVzTcsKOtGQ5PB2kgEmX3j8VizuJWF4BDO0qBEb6SHUQ=s96-c", "provider_id": "117585973386214160506", "email_verified": true, "phone_verified": false}', 'google', '2026-07-07 11:18:31.338091+00', '2026-07-07 11:18:31.338137+00', '2026-07-07 11:23:00.415075+00', '6f76119c-2685-4fb3-b88d-eb574b14fa5e'),
	('104205576010131698809', '62356062-e6e9-4e16-8e82-293e0ccba2fd', '{"iss": "https://accounts.google.com", "sub": "104205576010131698809", "name": "Venessya Calista", "email": "venessyacalista@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocI1C0hPkuUpk8HPRKfP512vMbO_zgP29YkWi4d5WBHHCQ6kTN99=s96-c", "full_name": "Venessya Calista", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocI1C0hPkuUpk8HPRKfP512vMbO_zgP29YkWi4d5WBHHCQ6kTN99=s96-c", "provider_id": "104205576010131698809", "email_verified": true, "phone_verified": false}', 'google', '2026-07-06 11:03:04.201383+00', '2026-07-06 11:03:04.201459+00', '2026-07-06 11:03:04.201459+00', '1738add6-8a7e-49c6-8681-33004a569c8f'),
	('ce9b2af7-7dc5-4f1c-9a27-c72763248335', 'ce9b2af7-7dc5-4f1c-9a27-c72763248335', '{"nim": "1122334455", "sub": "ce9b2af7-7dc5-4f1c-9a27-c72763248335", "email": "himapltestdosen@gmail.com", "full_name": "Himapl Dosen", "email_verified": true, "phone_verified": false}', 'email', '2026-07-12 11:50:05.874511+00', '2026-07-12 11:50:05.874573+00', '2026-07-12 11:50:05.874573+00', 'b328eb88-410e-4e2d-bf5c-54cd7382223c'),
	('102716447679129093130', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '{"iss": "https://accounts.google.com", "sub": "102716447679129093130", "name": "Alex Ferguson", "email": "alexferguson5568@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKhvyMIuzv_nb5L6MXx54V_MO2vypCh1ok4tl6AAj6bxRNA7Q=s96-c", "full_name": "Alex Ferguson", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKhvyMIuzv_nb5L6MXx54V_MO2vypCh1ok4tl6AAj6bxRNA7Q=s96-c", "provider_id": "102716447679129093130", "email_verified": true, "phone_verified": false}', 'google', '2026-07-01 20:27:32.60492+00', '2026-07-01 20:27:32.604993+00', '2026-07-13 08:58:40.027326+00', '4a09e7e3-044e-4398-b0f8-a3d4887b6cdb'),
	('116282741045635798711', 'c7b09eca-4095-4655-90d2-84ea06e21236', '{"iss": "https://accounts.google.com", "sub": "116282741045635798711", "name": "Nexl Level", "email": "nextlvlgameshop@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIHkPdVk7qAZ3PEoeIwkavdpq4rphw1BGPixKMvEKSXwbIuZw=s96-c", "full_name": "Nexl Level", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIHkPdVk7qAZ3PEoeIwkavdpq4rphw1BGPixKMvEKSXwbIuZw=s96-c", "provider_id": "116282741045635798711", "email_verified": true, "phone_verified": false}', 'google', '2026-07-06 11:15:55.804474+00', '2026-07-06 11:15:55.804533+00', '2026-07-06 11:15:55.804533+00', '984841bd-5369-41e5-b719-c5abc088a72d'),
	('103999107588662885621', '4a7ed672-33a4-4cb7-bab2-e10c436879fd', '{"iss": "https://accounts.google.com", "sub": "103999107588662885621", "name": "Himapl Ketua Himpunan", "email": "himaplketuah@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIfLrhhwtP6EUWlcsSalWXodOj2LEu3SZdNxPsA8UQaHMjbjg=s96-c", "full_name": "Himapl Ketua Himpunan", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIfLrhhwtP6EUWlcsSalWXodOj2LEu3SZdNxPsA8UQaHMjbjg=s96-c", "provider_id": "103999107588662885621", "email_verified": true, "phone_verified": false}', 'google', '2026-07-12 12:18:03.727537+00', '2026-07-12 12:18:03.727588+00', '2026-07-12 12:18:03.727588+00', '992a21c2-6a75-475b-b3cb-8a44e49e1af3'),
	('107909826733656456991', '2051e56d-f59e-49bc-9a41-f258ba24da6c', '{"iss": "https://accounts.google.com", "sub": "107909826733656456991", "name": "Himapl Ketua Divisi", "email": "himaplketuad@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJ9qrjPQHVC6GZoKDMcvZCUgcSsVeZ1dSj31e-6aA9LPoQGjQ=s96-c", "full_name": "Himapl Ketua Divisi", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJ9qrjPQHVC6GZoKDMcvZCUgcSsVeZ1dSj31e-6aA9LPoQGjQ=s96-c", "provider_id": "107909826733656456991", "email_verified": true, "phone_verified": false}', 'google', '2026-07-12 12:19:42.357313+00', '2026-07-12 12:19:42.35737+00', '2026-07-12 12:19:42.35737+00', '0c39dd91-d467-47e3-b890-c809eb06dcb7'),
	('109774784043689286340', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '{"iss": "https://accounts.google.com", "sub": "109774784043689286340", "name": "Vivie Triyanti", "email": "vivietriyanti0921@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJNsEQ9X33c-4mzR-hRyglQfAktCtgE0OAr_L9Wb4vqBRpawQ=s96-c", "full_name": "Vivie Triyanti", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJNsEQ9X33c-4mzR-hRyglQfAktCtgE0OAr_L9Wb4vqBRpawQ=s96-c", "provider_id": "109774784043689286340", "email_verified": true, "phone_verified": false}', 'google', '2026-07-12 15:01:35.231512+00', '2026-07-12 15:01:35.231557+00', '2026-07-12 15:01:35.231557+00', '64087e43-89d3-49fa-b2d9-b5845a35a4f5'),
	('29fdb77a-bf17-4032-ac54-a50c262769a7', '29fdb77a-bf17-4032-ac54-a50c262769a7', '{"nim": "2022133004", "sub": "29fdb77a-bf17-4032-ac54-a50c262769a7", "email": "vivietriyanti0921@uvers.ac.id", "full_name": "Vivie", "email_verified": false, "phone_verified": false}', 'email', '2026-07-12 14:58:04.989535+00', '2026-07-12 14:58:04.989584+00', '2026-07-12 14:58:04.989584+00', '915f7da1-06db-4b07-b466-3b51a67e8f70'),
	('108632446168851972910', '219a4f40-b531-4956-9413-5a114c032334', '{"iss": "https://accounts.google.com", "sub": "108632446168851972910", "name": "Tommy Theonanda", "email": "theonanda.tom@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLw85WR5HuSRpn-oG5XZ1Pv_x6AGjFM8-EhTyr10vwSCiwbUq3f=s96-c", "full_name": "Tommy Theonanda", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocLw85WR5HuSRpn-oG5XZ1Pv_x6AGjFM8-EhTyr10vwSCiwbUq3f=s96-c", "provider_id": "108632446168851972910", "email_verified": true, "phone_verified": false}', 'google', '2026-07-12 15:04:52.23226+00', '2026-07-12 15:04:52.23231+00', '2026-07-12 15:04:52.23231+00', '0ac26372-fb7c-4cfc-afc1-7d3948d8095c'),
	('109091406371973442750', 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', '{"iss": "https://accounts.google.com", "sub": "109091406371973442750", "name": "Drip Cake", "email": "dripcakeofficial@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocJMVZb90XANLVub7VILU9F9QgdveZdi8klEkpZa0cIz2Rh2kRY=s96-c", "full_name": "Drip Cake", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocJMVZb90XANLVub7VILU9F9QgdveZdi8klEkpZa0cIz2Rh2kRY=s96-c", "provider_id": "109091406371973442750", "email_verified": true, "phone_verified": false}', 'google', '2026-07-13 08:26:42.780467+00', '2026-07-13 08:26:42.780518+00', '2026-07-13 08:26:42.780518+00', 'd1107a7c-b6d7-40b1-8772-375073c42710'),
	('117924489802331684812', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '{"iss": "https://accounts.google.com", "sub": "117924489802331684812", "name": "Edison", "email": "edsn197@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKxVC3ZG_W5H0eBb7JLPc5SR5oQH2zpiRxQ5U-nnFDf9s2lgg=s96-c", "full_name": "Edison", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKxVC3ZG_W5H0eBb7JLPc5SR5oQH2zpiRxQ5U-nnFDf9s2lgg=s96-c", "provider_id": "117924489802331684812", "email_verified": true, "phone_verified": false}', 'google', '2026-07-12 15:04:07.140405+00', '2026-07-12 15:04:07.140464+00', '2026-07-12 15:08:33.566184+00', 'db9ef87a-1212-4908-b1df-f4a469cb7949'),
	('101389371319599277465', '0e54a436-b68e-4e69-a31b-6eae5db4d623', '{"iss": "https://accounts.google.com", "sub": "101389371319599277465", "name": "Hadi Susanto TPL 2022", "email": "hadi.s256314@uvers.ac.id", "picture": "https://lh3.googleusercontent.com/a/ACg8ocI8qyiVx8H0F9uHWCjAWG464-pISa7TJkjPbqahhfjvUA7piA=s96-c", "full_name": "Hadi Susanto TPL 2022", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocI8qyiVx8H0F9uHWCjAWG464-pISa7TJkjPbqahhfjvUA7piA=s96-c", "provider_id": "101389371319599277465", "custom_claims": {"hd": "uvers.ac.id"}, "email_verified": true, "phone_verified": false}', 'google', '2026-07-12 16:45:05.586732+00', '2026-07-12 16:45:05.58678+00', '2026-07-12 16:45:05.58678+00', '9b33c10c-4c6a-4493-858d-b5ee66043c3a'),
	('bbae5596-70f5-4491-8bcf-01ae43e701f7', 'bbae5596-70f5-4491-8bcf-01ae43e701f7', '{"nim": "2022133000", "sub": "bbae5596-70f5-4491-8bcf-01ae43e701f7", "email": "me@uvers.ac.id", "full_name": "me", "email_verified": false, "phone_verified": false}', 'email', '2026-07-13 00:07:41.760167+00', '2026-07-13 00:07:41.760213+00', '2026-07-13 00:07:41.760213+00', '84c0a6e5-dded-4f8c-9f07-d0992d05f542'),
	('100297427450550705230', 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', '{"iss": "https://accounts.google.com", "sub": "100297427450550705230", "name": "Herman TPL 2022", "email": "hermanyang2803@uvers.ac.id", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIhuPiLfvd5ep0mb6QC0bk273bFUJfu1P6-ocivqwmxX2Fl5GhG=s96-c", "full_name": "Herman TPL 2022", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIhuPiLfvd5ep0mb6QC0bk273bFUJfu1P6-ocivqwmxX2Fl5GhG=s96-c", "provider_id": "100297427450550705230", "custom_claims": {"hd": "uvers.ac.id"}, "email_verified": true, "phone_verified": false}', 'google', '2026-07-13 00:08:24.48676+00', '2026-07-13 00:08:24.486804+00', '2026-07-13 00:08:24.486804+00', '5563fbfe-b076-480d-8d33-92798cd82408'),
	('115066864125882760064', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '{"iss": "https://accounts.google.com", "sub": "115066864125882760064", "name": "Alex Ferguson", "email": "leex5568@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIQOtEwyKbq6TNRXWOleCH2QBxB9mpaeU5SAikvkwagx9Xk2Q=s96-c", "full_name": "Alex Ferguson", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIQOtEwyKbq6TNRXWOleCH2QBxB9mpaeU5SAikvkwagx9Xk2Q=s96-c", "provider_id": "115066864125882760064", "email_verified": true, "phone_verified": false}', 'google', '2026-07-04 13:44:10.998619+00', '2026-07-04 13:44:10.998673+00', '2026-07-13 08:59:17.21716+00', '4a966134-f7c3-42ba-bd8b-add9e562ac77'),
	('101027125842473619772', 'ac4cbe57-8fb4-4603-b854-1057aa6e61e3', '{"iss": "https://accounts.google.com", "sub": "101027125842473619772", "name": "Shereen Clarentio", "email": "shereenclarentio9@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocKdATXuOubuSIjCIK8iMn_2qMtg6-SUKUlMlqxfvgKHOVMZXA=s96-c", "full_name": "Shereen Clarentio", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocKdATXuOubuSIjCIK8iMn_2qMtg6-SUKUlMlqxfvgKHOVMZXA=s96-c", "provider_id": "101027125842473619772", "email_verified": true, "phone_verified": false}', 'google', '2026-07-14 04:11:08.254285+00', '2026-07-14 04:11:08.254335+00', '2026-07-14 04:11:08.254335+00', 'ef2e2c89-d622-431b-8106-72e62c1363de');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('fb8a6070-6951-44da-836a-6bcd37519d0f', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:08:33.568511+00', '2026-07-12 15:08:33.568511+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('22856648-c45d-4ecf-a2a3-c082f0c69ced', '62356062-e6e9-4e16-8e82-293e0ccba2fd', '2026-07-06 11:03:04.233863+00', '2026-07-06 11:03:04.233863+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '202.67.47.1', NULL, NULL, NULL, NULL, NULL),
	('9b97fb85-1e7c-4ec5-a946-2e975da8bee7', '2051e56d-f59e-49bc-9a41-f258ba24da6c', '2026-07-12 15:10:16.961518+00', '2026-07-12 15:10:16.961518+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 15; 2312DRAABG Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.46 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('0e87883e-1bf8-4d11-9895-641496c6fb2e', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '2026-07-12 15:01:35.243038+00', '2026-07-12 15:01:35.243038+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '180.252.52.196', NULL, NULL, NULL, NULL, NULL),
	('84879cb0-092c-4137-941a-5840deabbc41', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:04:07.152325+00', '2026-07-12 15:04:07.152325+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('8426b1de-66b6-44ef-870d-bccc57962497', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:04:55.801053+00', '2026-07-12 15:04:55.801053+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('eff23b97-378b-4533-8630-62e3adfff999', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:05:00.868917+00', '2026-07-12 15:05:00.868917+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('7fc0ac29-7b9f-48a5-bfb4-c55db06dd6ab', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:05:41.866198+00', '2026-07-12 15:05:41.866198+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('38c44275-e910-488a-a8bd-ddb300e113fe', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:05:44.425894+00', '2026-07-12 15:05:44.425894+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('f6612747-529b-4f79-add5-db90fa24d820', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:05:47.96832+00', '2026-07-12 15:05:47.96832+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('d34a5df7-8e60-476e-b5e1-a21df34dda6e', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:05:58.101114+00', '2026-07-12 15:05:58.101114+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('6ae51d57-131b-4a7a-aa73-a3891efcd54a', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:06:01.624365+00', '2026-07-12 15:06:01.624365+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('61259b25-7d01-4ceb-a2b0-93a3a0fef068', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:08:28.806515+00', '2026-07-12 15:08:28.806515+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('d4892a6a-ab26-43ac-bc8f-7a4f40519142', '29faba6b-83b1-4053-8d04-053e92bcc2e7', '2026-07-12 15:08:31.370102+00', '2026-07-12 15:08:31.370102+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '180.242.196.176', NULL, NULL, NULL, NULL, NULL),
	('a4d145af-aa30-4ea7-8a00-aa3f41e790b8', '0e54a436-b68e-4e69-a31b-6eae5db4d623', '2026-07-12 16:45:05.601459+00', '2026-07-12 16:45:05.601459+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '180.242.199.64', NULL, NULL, NULL, NULL, NULL),
	('4e559faa-d4bd-47e1-8708-e4c972577fc2', '4a7ed672-33a4-4cb7-bab2-e10c436879fd', '2026-07-13 14:15:01.253275+00', '2026-07-13 14:15:01.253275+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 16; 24069PC21G Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/149.0.7827.159 Mobile Safari/537.36', '140.213.143.3', NULL, NULL, NULL, NULL, NULL),
	('381f8f02-a07c-461d-b5f4-6e2fccd03f84', 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', '2026-07-13 00:08:24.494065+00', '2026-07-13 00:08:24.494065+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '182.253.9.66', NULL, NULL, NULL, NULL, NULL),
	('e1999c5a-5e0d-4348-8a8f-9cf37a9ebd7c', 'ac4cbe57-8fb4-4603-b854-1057aa6e61e3', '2026-07-14 04:11:08.274471+00', '2026-07-14 04:11:08.274471+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Safari/537.36', '182.253.9.75', NULL, NULL, NULL, NULL, NULL),
	('05bb867d-061d-49ff-9c56-0f164ad19364', 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', '2026-07-13 08:26:42.803589+00', '2026-07-13 08:26:42.803589+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '182.253.44.2', NULL, NULL, NULL, NULL, NULL),
	('3c4edc9d-8df9-457b-8c77-2de28f68c7fb', '4a7ed672-33a4-4cb7-bab2-e10c436879fd', '2026-07-13 14:07:16.555048+00', '2026-07-13 14:07:16.555048+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Linux; Android 16; 2412DPC0AG Build/BP2A.250605.031.A3; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.46 Mobile Safari/537.36', '182.2.4.85', NULL, NULL, NULL, NULL, NULL),
	('07b713ac-933a-470b-9380-38f86994835f', '219a4f40-b531-4956-9413-5a114c032334', '2026-07-12 15:04:52.241939+00', '2026-07-18 06:21:15.694468+00', NULL, 'aal1', NULL, '2026-07-18 06:21:15.694078', 'Mozilla/5.0 (Linux; Android 15; TECNO KM7 Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/150.0.7871.46 Mobile Safari/537.36', '223.255.224.109', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('0e87883e-1bf8-4d11-9895-641496c6fb2e', '2026-07-12 15:01:35.275296+00', '2026-07-12 15:01:35.275296+00', 'oauth', '288ae291-cac1-4c44-b56f-79533f02fb2d'),
	('84879cb0-092c-4137-941a-5840deabbc41', '2026-07-12 15:04:07.158128+00', '2026-07-12 15:04:07.158128+00', 'oauth', 'd113cefc-1889-464c-96ec-df58f0653c4a'),
	('07b713ac-933a-470b-9380-38f86994835f', '2026-07-12 15:04:52.247779+00', '2026-07-12 15:04:52.247779+00', 'oauth', 'cc8141d2-0459-4577-a06b-0c1a9495a836'),
	('8426b1de-66b6-44ef-870d-bccc57962497', '2026-07-12 15:04:55.804216+00', '2026-07-12 15:04:55.804216+00', 'oauth', '18058785-743f-4548-9818-6fb0597204ff'),
	('eff23b97-378b-4533-8630-62e3adfff999', '2026-07-12 15:05:00.871404+00', '2026-07-12 15:05:00.871404+00', 'oauth', '7f47cc03-e8cf-4624-900c-df0cf6fbeacd'),
	('7fc0ac29-7b9f-48a5-bfb4-c55db06dd6ab', '2026-07-12 15:05:41.868568+00', '2026-07-12 15:05:41.868568+00', 'oauth', 'c9a71829-6573-4a67-b6d8-18949749a92e'),
	('38c44275-e910-488a-a8bd-ddb300e113fe', '2026-07-12 15:05:44.427928+00', '2026-07-12 15:05:44.427928+00', 'oauth', '4ae235a7-7e38-476d-8c76-752bc5e8e8e4'),
	('f6612747-529b-4f79-add5-db90fa24d820', '2026-07-12 15:05:47.981179+00', '2026-07-12 15:05:47.981179+00', 'oauth', 'e9d8d016-3a46-42f7-8b11-d94bd1cce5be'),
	('d34a5df7-8e60-476e-b5e1-a21df34dda6e', '2026-07-12 15:05:58.10338+00', '2026-07-12 15:05:58.10338+00', 'oauth', '379ecf34-1a4a-475d-9caa-78f65e486b24'),
	('6ae51d57-131b-4a7a-aa73-a3891efcd54a', '2026-07-12 15:06:01.626572+00', '2026-07-12 15:06:01.626572+00', 'oauth', '817b033d-1842-45d8-b193-6eeb27587280'),
	('61259b25-7d01-4ceb-a2b0-93a3a0fef068', '2026-07-12 15:08:28.809447+00', '2026-07-12 15:08:28.809447+00', 'oauth', '5bbb022b-31ef-4128-ab63-350523c717d9'),
	('d4892a6a-ab26-43ac-bc8f-7a4f40519142', '2026-07-12 15:08:31.372309+00', '2026-07-12 15:08:31.372309+00', 'oauth', '26dfc9c8-bd95-4aec-a591-85cc9f064d6c'),
	('fb8a6070-6951-44da-836a-6bcd37519d0f', '2026-07-12 15:08:33.570565+00', '2026-07-12 15:08:33.570565+00', 'oauth', '1a073e7b-8c70-4d62-a0c2-2bd8282565ff'),
	('9b97fb85-1e7c-4ec5-a946-2e975da8bee7', '2026-07-12 15:10:16.97768+00', '2026-07-12 15:10:16.97768+00', 'password', 'c5fc917a-84b3-4129-bad5-f86baedf5a19'),
	('a4d145af-aa30-4ea7-8a00-aa3f41e790b8', '2026-07-12 16:45:05.628232+00', '2026-07-12 16:45:05.628232+00', 'oauth', 'cdc49de6-8421-496d-9519-a3007baeac37'),
	('381f8f02-a07c-461d-b5f4-6e2fccd03f84', '2026-07-13 00:08:24.539498+00', '2026-07-13 00:08:24.539498+00', 'oauth', 'bd02d9b7-60a7-402d-87ee-62c7f767d94a'),
	('05bb867d-061d-49ff-9c56-0f164ad19364', '2026-07-13 08:26:42.839743+00', '2026-07-13 08:26:42.839743+00', 'oauth', '842304fd-090d-4952-9062-7bb47b7fb5c4'),
	('22856648-c45d-4ecf-a2a3-c082f0c69ced', '2026-07-06 11:03:04.277235+00', '2026-07-06 11:03:04.277235+00', 'oauth', '7c5b413f-7276-412a-84e1-414b1956afd6'),
	('3c4edc9d-8df9-457b-8c77-2de28f68c7fb', '2026-07-13 14:07:16.62024+00', '2026-07-13 14:07:16.62024+00', 'password', 'c7e86bc4-2f17-4041-a17b-483a7d829d35'),
	('4e559faa-d4bd-47e1-8708-e4c972577fc2', '2026-07-13 14:15:01.260217+00', '2026-07-13 14:15:01.260217+00', 'password', '2c17df52-a7cf-4c55-a529-5f401944d80a'),
	('e1999c5a-5e0d-4348-8a8f-9cf37a9ebd7c', '2026-07-14 04:11:08.321904+00', '2026-07-14 04:11:08.321904+00', 'oauth', '27252212-965b-47c5-8f5b-146981cd3a1a');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") VALUES
	('8d9795e6-a532-4b1e-a5ff-79a00419db6b', '29fdb77a-bf17-4032-ac54-a50c262769a7', 'confirmation_token', 'a8f47a4d8e34960af2dd8e81fcd5dc1261308eec88502ce1a10bd573', 'vivietriyanti0921@uvers.ac.id', '2026-07-12 15:01:01.032845', '2026-07-12 15:01:01.032845'),
	('a8da16ac-0098-4fc3-9141-e609d58f9073', 'bbae5596-70f5-4491-8bcf-01ae43e701f7', 'confirmation_token', '0631dac7326f6e7be71100450e0241468484b704fc79a4d0b89943d3', 'me@uvers.ac.id', '2026-07-13 00:07:43.588126', '2026-07-13 00:07:43.588126');


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 243, 'dbmxwzjxwe7o', 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', false, '2026-07-13 00:08:24.51075+00', '2026-07-13 00:08:24.51075+00', NULL, '381f8f02-a07c-461d-b5f4-6e2fccd03f84'),
	('00000000-0000-0000-0000-000000000000', 223, 'shjcuepb5oxr', '219a4f40-b531-4956-9413-5a114c032334', true, '2026-07-12 15:04:52.244018+00', '2026-07-13 06:18:46.398234+00', NULL, '07b713ac-933a-470b-9380-38f86994835f'),
	('00000000-0000-0000-0000-000000000000', 130, '5aibqrnb5vhi', '62356062-e6e9-4e16-8e82-293e0ccba2fd', false, '2026-07-06 11:03:04.254341+00', '2026-07-06 11:03:04.254341+00', NULL, '22856648-c45d-4ecf-a2a3-c082f0c69ced'),
	('00000000-0000-0000-0000-000000000000', 245, '3f32lp4hhpyr', 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', false, '2026-07-13 08:26:42.822879+00', '2026-07-13 08:26:42.822879+00', NULL, '05bb867d-061d-49ff-9c56-0f164ad19364'),
	('00000000-0000-0000-0000-000000000000', 251, 'cirw6pcfrcdo', '4a7ed672-33a4-4cb7-bab2-e10c436879fd', false, '2026-07-13 14:07:16.583029+00', '2026-07-13 14:07:16.583029+00', NULL, '3c4edc9d-8df9-457b-8c77-2de28f68c7fb'),
	('00000000-0000-0000-0000-000000000000', 254, '44sagubtaay3', 'ac4cbe57-8fb4-4603-b854-1057aa6e61e3', false, '2026-07-14 04:11:08.297874+00', '2026-07-14 04:11:08.297874+00', NULL, 'e1999c5a-5e0d-4348-8a8f-9cf37a9ebd7c'),
	('00000000-0000-0000-0000-000000000000', 256, '7qh26hkaimv5', '219a4f40-b531-4956-9413-5a114c032334', false, '2026-07-18 06:21:15.665975+00', '2026-07-18 06:21:15.665975+00', 'di7me77kbkus', '07b713ac-933a-470b-9380-38f86994835f'),
	('00000000-0000-0000-0000-000000000000', 221, 'lquuwcke2nek', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', false, '2026-07-12 15:01:35.255083+00', '2026-07-12 15:01:35.255083+00', NULL, '0e87883e-1bf8-4d11-9895-641496c6fb2e'),
	('00000000-0000-0000-0000-000000000000', 222, 'itdo2zpvqtuu', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:04:07.154187+00', '2026-07-12 15:04:07.154187+00', NULL, '84879cb0-092c-4137-941a-5840deabbc41'),
	('00000000-0000-0000-0000-000000000000', 224, 'vy2ztyui52ze', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:04:55.80269+00', '2026-07-12 15:04:55.80269+00', NULL, '8426b1de-66b6-44ef-870d-bccc57962497'),
	('00000000-0000-0000-0000-000000000000', 225, 'lyj3car34hna', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:05:00.869964+00', '2026-07-12 15:05:00.869964+00', NULL, 'eff23b97-378b-4533-8630-62e3adfff999'),
	('00000000-0000-0000-0000-000000000000', 226, 'xxmmkqc7v6wn', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:05:41.867149+00', '2026-07-12 15:05:41.867149+00', NULL, '7fc0ac29-7b9f-48a5-bfb4-c55db06dd6ab'),
	('00000000-0000-0000-0000-000000000000', 227, 'ndat4iuaum4s', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:05:44.426751+00', '2026-07-12 15:05:44.426751+00', NULL, '38c44275-e910-488a-a8bd-ddb300e113fe'),
	('00000000-0000-0000-0000-000000000000', 228, 'e5k7bxszpyqd', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:05:47.971455+00', '2026-07-12 15:05:47.971455+00', NULL, 'f6612747-529b-4f79-add5-db90fa24d820'),
	('00000000-0000-0000-0000-000000000000', 229, 'hdyal6gcfefv', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:05:58.101888+00', '2026-07-12 15:05:58.101888+00', NULL, 'd34a5df7-8e60-476e-b5e1-a21df34dda6e'),
	('00000000-0000-0000-0000-000000000000', 230, 'j75xbuvjk2r2', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:06:01.625214+00', '2026-07-12 15:06:01.625214+00', NULL, '6ae51d57-131b-4a7a-aa73-a3891efcd54a'),
	('00000000-0000-0000-0000-000000000000', 233, 'sscsl4nvj4mo', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:08:28.808151+00', '2026-07-12 15:08:28.808151+00', NULL, '61259b25-7d01-4ceb-a2b0-93a3a0fef068'),
	('00000000-0000-0000-0000-000000000000', 234, '3gkehfylmqh7', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:08:31.371093+00', '2026-07-12 15:08:31.371093+00', NULL, 'd4892a6a-ab26-43ac-bc8f-7a4f40519142'),
	('00000000-0000-0000-0000-000000000000', 235, 'rouqaqydu464', '29faba6b-83b1-4053-8d04-053e92bcc2e7', false, '2026-07-12 15:08:33.569358+00', '2026-07-12 15:08:33.569358+00', NULL, 'fb8a6070-6951-44da-836a-6bcd37519d0f'),
	('00000000-0000-0000-0000-000000000000', 236, 'luirnri3q5e5', '2051e56d-f59e-49bc-9a41-f258ba24da6c', false, '2026-07-12 15:10:16.973658+00', '2026-07-12 15:10:16.973658+00', NULL, '9b97fb85-1e7c-4ec5-a946-2e975da8bee7'),
	('00000000-0000-0000-0000-000000000000', 244, 'we4chh2uwvj2', '219a4f40-b531-4956-9413-5a114c032334', true, '2026-07-13 06:18:46.412558+00', '2026-07-13 09:37:25.656713+00', 'shjcuepb5oxr', '07b713ac-933a-470b-9380-38f86994835f'),
	('00000000-0000-0000-0000-000000000000', 240, '6dbzk4lpakyv', '0e54a436-b68e-4e69-a31b-6eae5db4d623', false, '2026-07-12 16:45:05.616059+00', '2026-07-12 16:45:05.616059+00', NULL, 'a4d145af-aa30-4ea7-8a00-aa3f41e790b8'),
	('00000000-0000-0000-0000-000000000000', 253, '43qyaip4k2aw', '4a7ed672-33a4-4cb7-bab2-e10c436879fd', false, '2026-07-13 14:15:01.257308+00', '2026-07-13 14:15:01.257308+00', NULL, '4e559faa-d4bd-47e1-8708-e4c972577fc2'),
	('00000000-0000-0000-0000-000000000000', 250, 'jaaiv7k53dqb', '219a4f40-b531-4956-9413-5a114c032334', true, '2026-07-13 09:37:25.668006+00', '2026-07-14 07:01:40.348953+00', 'we4chh2uwvj2', '07b713ac-933a-470b-9380-38f86994835f'),
	('00000000-0000-0000-0000-000000000000', 255, 'di7me77kbkus', '219a4f40-b531-4956-9413-5a114c032334', true, '2026-07-14 07:01:40.359733+00', '2026-07-18 06:21:15.64218+00', 'jaaiv7k53dqb', '07b713ac-933a-470b-9380-38f86994835f');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: divisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."divisi" ("id", "nama_divisi", "ketua_divisi_id", "created_at") VALUES
	(3, 'Minat & Bakat', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-03 16:02:39.396261+00'),
	(5, 'Human Resource', NULL, '2026-07-03 16:03:20.008045+00'),
	(6, 'Dokumentasi', '2051e56d-f59e-49bc-9a41-f258ba24da6c', '2026-07-03 16:03:30.151286+00'),
	(4, 'Bendahara', NULL, '2026-07-03 16:02:56.723419+00');


--
-- Data for Name: lokasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."lokasi" ("id", "nama_ruangan", "kapasitas", "created_at") VALUES
	(1, 'Gedung Serbaguna', 200, '2026-07-05 18:16:56.422227+00'),
	(2, 'Lab Komputer 1', 40, '2026-07-05 18:16:56.422227+00'),
	(3, 'Ruang Rapat Utama', 20, '2026-07-05 18:16:56.422227+00');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."users" ("id", "nim", "nama", "email", "role", "divisi_id", "avatar_url", "created_at") VALUES
	('0e54a436-b68e-4e69-a31b-6eae5db4d623', NULL, 'Hadi Susanto TPL 2022', 'hadi.s256314@uvers.ac.id', 'Anggota', NULL, NULL, '2026-07-12 16:45:05.562002+00'),
	('bbae5596-70f5-4491-8bcf-01ae43e701f7', '2022133000', 'me', 'me@uvers.ac.id', 'Anggota', NULL, NULL, '2026-07-13 00:07:41.679557+00'),
	('edce8c3d-a716-47e9-bd61-2b2dfdf72059', '202213300', 'Herman TPL 2022', 'hermanyang2803@uvers.ac.id', 'Anggota', NULL, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/avatars/edce8c3d-a716-47e9-bd61-2b2dfdf72059_1783901446213.jpg', '2026-07-13 00:08:24.480256+00'),
	('cbab0558-6b06-4304-a935-42b5f6ea2ec9', NULL, 'Drip Cake', 'dripcakeofficial@gmail.com', 'Anggota', NULL, NULL, '2026-07-13 08:26:42.664447+00'),
	('c7b09eca-4095-4655-90d2-84ea06e21236', '3456788990', 'Dummy 3', 'nextlvlgameshop@gmail.com', 'Anggota', 4, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/avatars/c7b09eca-4095-4655-90d2-84ea06e21236_1783336588098.jpg', '2026-07-06 11:15:55.754326+00'),
	('ac4cbe57-8fb4-4603-b854-1057aa6e61e3', NULL, 'Shereen Clarentio', 'shereenclarentio9@gmail.com', 'Anggota', NULL, NULL, '2026-07-14 04:11:08.11605+00'),
	('059b7fe5-6da6-4aff-a175-72828e2bdd0d', '1234567890', 'Role Dosen', 'leex5568@gmail.com', 'Dosen', NULL, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/avatars/059b7fe5-6da6-4aff-a175-72828e2bdd0d_1783338059790.jpg', '2026-06-23 11:24:48.289513+00'),
	('dd4792af-61c7-46c6-b142-dac0fbf87083', '2022133011', 'Alex Ferguson', 'alexferguson5568@gmail.com', 'Ketua Divisi', 3, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/avatars/dd4792af-61c7-46c6-b142-dac0fbf87083_1782846880067.jpg', '2026-06-23 11:06:39.333646+00'),
	('84fa6077-753c-4c79-99aa-bee2a82690f6', '3456789067', 'Alex Ferguson 2', 'leex568@gmail.com', 'Anggota', 3, '', '2026-07-07 11:18:31.326797+00'),
	('62356062-e6e9-4e16-8e82-293e0ccba2fd', '', 'Venessya Calista', 'venessyacalista@gmail.com', 'Ketua', NULL, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/avatars/62356062-e6e9-4e16-8e82-293e0ccba2fd_1783336628479.jpg', '2026-07-06 11:03:04.029882+00'),
	('ce9b2af7-7dc5-4f1c-9a27-c72763248335', '1122334455', 'Himapl Dosen', 'himapltestdosen@gmail.com', 'Dosen', NULL, NULL, '2026-07-12 11:50:05.81491+00'),
	('4a7ed672-33a4-4cb7-bab2-e10c436879fd', '2233445566', 'Himapl Ketua Himpunan', 'himaplketuah@gmail.com', 'Ketua', NULL, '', '2026-07-12 12:18:03.700412+00'),
	('2051e56d-f59e-49bc-9a41-f258ba24da6c', '3344556677', 'Himapl Ketua Divisi', 'himaplketuad@gmail.com', 'Ketua Divisi', 6, '', '2026-07-12 12:19:42.340742+00'),
	('29fdb77a-bf17-4032-ac54-a50c262769a7', '2022133004', 'Vivie', 'vivietriyanti0921@uvers.ac.id', 'Anggota', NULL, NULL, '2026-07-12 14:58:04.941653+00'),
	('29faba6b-83b1-4053-8d04-053e92bcc2e7', NULL, 'Edison', 'edsn197@gmail.com', 'Anggota', NULL, NULL, '2026-07-12 15:04:07.128395+00'),
	('219a4f40-b531-4956-9413-5a114c032334', NULL, 'Tommy Theonanda', 'theonanda.tom@gmail.com', 'Anggota', NULL, NULL, '2026-07-12 15:04:52.200741+00'),
	('6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '202213304', 'Vivie Triyanti', 'vivietriyanti0921@gmail.com', 'Anggota', NULL, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/avatars/6f4fea43-77ac-4f57-a257-e5cd1b0329f2_1783868827570.jpg', '2026-07-12 15:01:35.22521+00');


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."events" ("id", "nama_event", "deskripsi", "status", "start_date", "end_date", "created_by", "created_at", "kuota", "lokasi_id") VALUES
	(10, 'Revisi Sidang TPL', 'Jangan lupa revisi setelah selesai sidang.', 'PUBLISHED', '2026-06-30 07:53:00+00', '2026-07-13 07:54:00+00', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-03 05:57:07.74701+00', NULL, NULL),
	(15, 'Kuesioner UAT', 'Halo teman teman, mohon maaf menggangu waktunya!

Perkenalkan, saya Alex Ferguson, mahasiswa prodi Teknik Perang Lunak Universitas Universal.

Dengan hormat, saya memohon kesediaan teman teman untuk mengisi kuesioner penelitian saya terkait Aplikasi Sistem Informasi HIMAPL berbasi mobile.

Kuesioner ini ditujukan khusus kepada teman teman dengan prodi *TPL* berlaku untuk semua angkatan maupun alumni yang menggunakan perangkat *Android*. Partisipan mohon diharapkan untuk mematuhi skenario pengujian aplikasi pada form kuesioner sebelum memberikan jawab.

Atas waktu dan ketersediaan teman teman, saya ucapkan terima kasih.', 'PUBLISHED', '2026-07-12 00:26:00+00', '2026-07-14 01:26:00+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-12 14:31:15.354139+00', NULL, NULL),
	(4, 'Project Ionic vue', 'Memperkenalkan Ionic sebagai framework untuk mengembangkan aplikasi berbasi mobile', 'COMPLETED', '2026-06-22 06:00:00+00', '2026-06-22 10:30:30+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-06-18 17:01:00+00', NULL, NULL),
	(17, 'test', 'test', 'DRAFT', '2026-07-13 14:15:00+00', '2026-07-13 15:15:00+00', '4a7ed672-33a4-4cb7-bab2-e10c436879fd', '2026-07-13 14:16:15.624652+00', NULL, 1),
	(1, 'Sidang TPL', 'Hari sidang skripsi untuk prodi HIMAPL, yang tidak bimbingan sebanyak delapan kali dilarang ikut sidang', 'PUBLISHED', '2026-07-02 04:30:00+00', '2026-07-03 07:10:00+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-06-23 13:01:21+00', NULL, NULL),
	(3, 'Seminar Saham', 'Seminar yang bertujuan untuk menyampaikan cara kerja saham', 'PUBLISHED', '2026-07-07 22:30:00+00', '2026-07-08 00:00:00+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-06-30 20:35:10+00', NULL, NULL),
	(2, 'Hangout TPL', 'Kegiatan kumpul bersama yang dilakukan oleh TPL setelah selesai sidang untuk melepaskan stress', 'PUBLISHED', '2026-07-04 23:00:00+00', '2026-07-05 05:00:00+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-06-30 20:25:59+00', NULL, NULL);


--
-- Data for Name: dokumentasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."dokumentasi" ("id", "event_id", "url_foto", "uploader_id", "created_at") VALUES
	(1, 2, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/dokumentasi-event/event_2/0.24790869256519632.jpg', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-03 05:13:47.256516+00'),
	(2, 2, 'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/6541e931-8131-4ba1-90d5-dd8956e880be_532526_0081119d_Blooming_Jasmine_Milk_Tea_Signature_Series.png', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-03 05:14:14.89767+00'),
	(5, 10, 'https://assets.siakadcloud.com/uploads/uvers/bgaplikasi/1505.jpg?46082', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-03 06:05:38.686866+00'),
	(8, 2, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/dokumentasi-event/event_2/0.47194252415687366.jpg', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-05 17:53:33.171471+00'),
	(13, 2, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/dokumentasi-event/event_2/0.5642004671239137.jpg', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-08 12:10:02.773583+00'),
	(15, 10, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/dokumentasi-event/event_10/0.4168417765289183.jpg', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-11 20:54:52.508618+00'),
	(16, 15, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/dokumentasi-event/events/0.5378954093741212.jpeg', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-12 14:42:37.793056+00'),
	(17, 15, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/dokumentasi-event/event_15/0.8187709958463014.jpg', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '2026-07-12 15:10:36.771297+00'),
	(18, 15, 'https://weypaqthodjvvadjmihx.supabase.co/storage/v1/object/public/dokumentasi-event/event_15/0.9714952118950696.jpg', 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', '2026-07-13 08:27:20.759526+00');


--
-- Data for Name: kategori_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."kategori_event" ("id", "nama_kategori", "created_at") VALUES
	(1, 'Seminar', '2026-07-05 18:16:56.422227+00'),
	(2, 'Workshop', '2026-07-05 18:16:56.422227+00'),
	(3, 'Industrial Visit', '2026-07-05 18:16:56.422227+00'),
	(4, 'Course', '2026-07-05 18:16:56.422227+00'),
	(5, 'Project', '2026-07-05 18:16:56.422227+00'),
	(6, 'Celebration', '2026-07-05 18:16:56.422227+00'),
	(7, 'Free', '2026-07-05 18:16:56.422227+00'),
	(8, 'Paid', '2026-07-05 18:16:56.422227+00'),
	(9, 'Limited', '2026-07-05 18:16:56.422227+00'),
	(10, 'Meeting', '2026-07-05 18:16:56.422227+00'),
	(11, 'Certificate', '2026-07-05 18:16:56.422227+00'),
	(12, 'Online', '2026-07-05 18:18:54+00'),
	(14, 'Offline', '2026-07-05 18:19:16+00');


--
-- Data for Name: event_kategori_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."event_kategori_mapping" ("id", "event_id", "kategori_id") VALUES
	(16, 10, 11),
	(17, 10, 1),
	(26, 15, 7),
	(27, 15, 12);


--
-- Data for Name: event_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."event_links" ("id", "event_id", "nama_tautan", "url", "created_at") VALUES
	(5, 15, 'APK HIMAPL', 'https://drive.google.com/drive/folders/1FjSLfU-d9yldoo2fUyLtSmy5dQlu50Gx', '2026-07-13 08:58:23.915779+00'),
	(6, 15, 'Kuesioner', 'https://forms.gle/4J9SQZHLuEwTwzUE6', '2026-07-13 08:58:23.915779+00');


--
-- Data for Name: event_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."event_participants" ("id", "event_id", "user_id", "status", "waktu_registrasi") VALUES
	('bc8059ce-2455-4596-a015-aa603a4af870', 4, 'dd4792af-61c7-46c6-b142-dac0fbf87083', 'ATTENDED', '2026-07-02 18:35:46+00'),
	('28321223-a9ba-41e8-85a7-989a76846c01', 1, 'dd4792af-61c7-46c6-b142-dac0fbf87083', 'REGISTERED', '2026-07-02 19:36:18.762181+00'),
	('eaecaa47-862e-4191-9b0b-1444857dfa98', 2, 'dd4792af-61c7-46c6-b142-dac0fbf87083', 'REGISTERED', '2026-07-02 20:14:34.944128+00'),
	('7106ecf7-c5b2-4ca1-8be3-e389630a85cb', 3, 'dd4792af-61c7-46c6-b142-dac0fbf87083', 'REGISTERED', '2026-07-06 12:29:42.383831+00'),
	('4a46c762-21a1-40cc-8faa-6e94baaed15f', 10, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'REGISTERED', '2026-07-08 13:38:55.642687+00'),
	('cfbf5a0c-398e-4139-93af-ff1a55062a73', 10, 'dd4792af-61c7-46c6-b142-dac0fbf87083', 'REGISTERED', '2026-07-09 07:03:46.963188+00'),
	('ca290a2e-a043-4e87-b253-a08edbf6e787', 15, 'dd4792af-61c7-46c6-b142-dac0fbf87083', 'REGISTERED', '2026-07-12 15:08:44.094627+00'),
	('a2a446d8-768e-40c1-a9b7-0497237c59c2', 10, '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', 'REGISTERED', '2026-07-12 15:08:52.333935+00'),
	('66cdb7ae-b7f4-44ca-9e64-260b241c04bd', 15, '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', 'REGISTERED', '2026-07-12 15:08:09.477924+00'),
	('85062806-0d0a-4d52-99ad-e19d9a95472f', 15, '2051e56d-f59e-49bc-9a41-f258ba24da6c', 'CANCELLED', '2026-07-12 15:12:02.726904+00'),
	('81a80f84-2c6f-4cf7-8954-172765908441', 10, 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', 'REGISTERED', '2026-07-13 00:11:54.994922+00'),
	('f2b6001e-b113-483e-ac45-05fdef628449', 15, 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', 'REGISTERED', '2026-07-13 08:27:26.6748+00'),
	('6c2d4e01-23bb-4e0d-af21-b61929c75570', 15, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'REGISTERED', '2026-07-13 08:49:46.997052+00');


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."news" ("id", "title", "content", "image_url", "created_at", "category", "publisher_id") VALUES
	('682305e9-b3e9-4f5e-be70-1a729cd4b85b', 'HIMAPL System Information Realese', 'Perilisan aplikasi Sistem Informasi untuk HIMAPL. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since 1966', NULL, '2026-06-23 18:26:57+00', 'ANNOUNCEMENT', '059b7fe5-6da6-4aff-a175-72828e2bdd0d'),
	('96fa0718-51e4-4c27-9a62-0c6df5a3aa7d', 'Test news', 'Tidak ada yang penting test publisher', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ43k2qnI7dbCrBl5mOj8UyFXmle9OO-14yt2BOsvwWyJnVcFsQz46h0b-V&s=10', '2026-07-03 06:34:51.825091+00', 'GENERAL', '059b7fe5-6da6-4aff-a175-72828e2bdd0d');


--
-- Data for Name: notifikasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."notifikasi" ("id", "judul", "pesan", "created_at", "sender_id", "tipe") VALUES
	(8, 'PPT', 'Jangan lupa PPT', '2026-07-03 06:30:51.811885+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'PERSONAL'),
	(2, 'Udah bisa Sign in Google', 'Kini pengguna telah bisa melakukan sign in meggunakan akun google dan pengguna yang telah memiliki akun ', '2026-07-01 21:06:02+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'GLOBAL'),
	(3, 'Jangan coba Hapus akun terlebih dahulu', 'Fitur hapus akun masih dalam tahap pengetesan dan belum secara resmi dinyatakan aman', '2026-07-01 21:08:13+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'GLOBAL'),
	(4, '🎉 Pengumuman Global Perdana', 'Halo semuanya! Ini adalah uji coba fitur notifikasi global. Notifikasi ini dikirimkan ke seluruh anggota tanpa terkecuali.', '2026-07-02 22:03:42.911259+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'GLOBAL'),
	(1, 'Test notifikasi', 'Isi dari notofikasi ini adalah Hari ini fitur notifikasi telah diperbaiki', '2026-06-23 13:09:37+00', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', 'GLOBAL');


--
-- Data for Name: penerima_notifikasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."penerima_notifikasi" ("id", "notif_id", "user_id", "is_read", "created_at") VALUES
	(1, 1, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', false, '2026-07-05 17:11:50.792943+00'),
	(6, 2, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', false, '2026-07-05 17:11:50.792943+00'),
	(12, 3, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-05 17:11:50.792943+00'),
	(17, 4, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-05 17:11:50.792943+00'),
	(21, 8, 'dd4792af-61c7-46c6-b142-dac0fbf87083', true, '2026-07-05 17:13:59+00'),
	(2, 1, 'dd4792af-61c7-46c6-b142-dac0fbf87083', true, '2026-07-05 17:11:50.792943+00'),
	(7, 2, 'dd4792af-61c7-46c6-b142-dac0fbf87083', true, '2026-07-05 17:11:50.792943+00'),
	(16, 4, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', true, '2026-07-05 17:11:50.792943+00'),
	(11, 3, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', true, '2026-07-05 17:11:50.792943+00');


--
-- Data for Name: tugas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."tugas" ("id", "nama_tugas", "event_id", "assigned_by_id", "created_at", "assign_type") VALUES
	(6, 'Selesaikan Skripsi (Perancangan Aplikasi Sistem Informasi HIMAPL Berbasis Mobile pada Fakultas Komputer Universitas Universal) dan juga Projectnya', 1, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-05 17:22:45.697784+00', 'global'),
	(8, 'Install aplikasi saham', 3, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-05 17:53:25.568168+00', 'global'),
	(9, 'Siapkan uang jajan sebelum kumpul', 2, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-05 17:53:33.08841+00', 'global'),
	(17, 'Revisi skripsi', 10, 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-11 18:57:39.775612+00', 'global'),
	(18, 'Rapikan Skripsi', 10, 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-11 18:57:39.775612+00', 'global'),
	(19, 'selesaikan skripsi', 15, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-13 08:58:24.21583+00', 'individu');


--
-- Data for Name: tugas_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."tugas_assignments" ("id", "tugas_id", "user_id", "status_selesai", "created_at") VALUES
	(1, 6, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', false, '2026-07-05 17:22:45.796037+00'),
	(2, 6, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-05 17:22:45.796037+00'),
	(79, 18, '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', false, '2026-07-12 15:08:52.455085+00'),
	(78, 17, '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', true, '2026-07-12 15:08:52.455085+00'),
	(64, 17, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', true, '2026-07-11 18:57:39.847271+00'),
	(69, 18, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', true, '2026-07-11 18:57:39.847271+00'),
	(80, 17, 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', false, '2026-07-13 00:11:55.117826+00'),
	(81, 18, 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', false, '2026-07-13 00:11:55.117826+00'),
	(82, 19, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-13 08:58:24.427648+00'),
	(11, 8, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', false, '2026-07-05 17:53:25.614674+00'),
	(12, 8, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-05 17:53:25.614674+00'),
	(83, 19, '84fa6077-753c-4c79-99aa-bee2a82690f6', false, '2026-07-13 08:58:24.427648+00'),
	(16, 9, '059b7fe5-6da6-4aff-a175-72828e2bdd0d', false, '2026-07-05 17:53:33.144529+00'),
	(17, 9, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-05 17:53:33.144529+00'),
	(65, 17, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-11 18:57:39.847271+00'),
	(66, 17, 'c7b09eca-4095-4655-90d2-84ea06e21236', false, '2026-07-11 18:57:39.847271+00'),
	(67, 17, '84fa6077-753c-4c79-99aa-bee2a82690f6', false, '2026-07-11 18:57:39.847271+00'),
	(68, 17, '62356062-e6e9-4e16-8e82-293e0ccba2fd', false, '2026-07-11 18:57:39.847271+00'),
	(70, 18, 'dd4792af-61c7-46c6-b142-dac0fbf87083', false, '2026-07-11 18:57:39.847271+00'),
	(71, 18, 'c7b09eca-4095-4655-90d2-84ea06e21236', false, '2026-07-11 18:57:39.847271+00'),
	(72, 18, '84fa6077-753c-4c79-99aa-bee2a82690f6', false, '2026-07-11 18:57:39.847271+00'),
	(73, 18, '62356062-e6e9-4e16-8e82-293e0ccba2fd', false, '2026-07-11 18:57:39.847271+00');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") VALUES
	('avatars', 'avatars', NULL, '2026-06-30 17:58:43.834748+00', '2026-06-30 17:58:43.834748+00', true, false, NULL, NULL, NULL, 'STANDARD'),
	('dokumentasi-event', 'dokumentasi-event', NULL, '2026-07-01 21:21:52.879733+00', '2026-07-01 21:21:52.879733+00', true, false, NULL, NULL, NULL, 'STANDARD');


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") VALUES
	('17680db0-9490-46ff-8709-5cc65f68c7ed', 'avatars', 'dd4792af-61c7-46c6-b142-dac0fbf87083_1782846880067.jpg', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-06-30 19:14:39.542752+00', '2026-06-30 19:14:39.542752+00', '2026-06-30 19:14:39.542752+00', '{"eTag": "\"a8be92c2e96aee5fc75e30895f583b7b\"", "size": 269866, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2026-06-30T19:14:40.000Z", "contentLength": 269866, "httpStatusCode": 200}', 'bf2f003d-52ea-4218-ad63-977c970629e2', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '{}'),
	('c49e4665-b3e3-4f4b-b17c-05300f014833', 'dokumentasi-event', 'event_2/0.24790869256519632.jpg', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-03 05:13:46.79757+00', '2026-07-03 05:13:46.79757+00', '2026-07-03 05:13:46.79757+00', '{"eTag": "\"9379cbc91c768b204c2a6052aa70610c\"", "size": 63239, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-03T05:13:47.000Z", "contentLength": 63239, "httpStatusCode": 200}', '4bfa6583-5642-4df1-8b27-d7f432782567', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '{}'),
	('f5fb4a87-c14d-4804-848c-b253c16f3435', 'avatars', 'c7b09eca-4095-4655-90d2-84ea06e21236_1783336588098.jpg', 'c7b09eca-4095-4655-90d2-84ea06e21236', '2026-07-06 11:16:29.366275+00', '2026-07-06 11:16:29.366275+00', '2026-07-06 11:16:29.366275+00', '{"eTag": "\"3e86cd1649cbb5d7e622142b01bf9521\"", "size": 441798, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-06T11:16:30.000Z", "contentLength": 441798, "httpStatusCode": 200}', 'e9c43bfa-e764-4ae8-9d3d-8a9d28a61011', 'c7b09eca-4095-4655-90d2-84ea06e21236', '{}'),
	('24ccaa66-e8dc-4709-a1a1-7d3acd91eb4a', 'avatars', '62356062-e6e9-4e16-8e82-293e0ccba2fd_1783336628479.jpg', '62356062-e6e9-4e16-8e82-293e0ccba2fd', '2026-07-06 11:17:09.324803+00', '2026-07-06 11:17:09.324803+00', '2026-07-06 11:17:09.324803+00', '{"eTag": "\"c387722b454a6351fcfed10d9dadeb5d\"", "size": 34954, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-06T11:17:10.000Z", "contentLength": 34954, "httpStatusCode": 200}', '15655b75-af91-4a88-817e-cf9d9b61bfef', '62356062-e6e9-4e16-8e82-293e0ccba2fd', '{}'),
	('13d6bd5b-6fb9-4187-9f46-83769dac7186', 'avatars', '059b7fe5-6da6-4aff-a175-72828e2bdd0d_1783338059790.jpg', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-06 11:41:00.897625+00', '2026-07-06 11:41:00.897625+00', '2026-07-06 11:41:00.897625+00', '{"eTag": "\"46ec21ac4166b3dde382ddc5168f2245\"", "size": 427487, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-06T11:41:01.000Z", "contentLength": 427487, "httpStatusCode": 200}', '80e86fdd-81e9-4716-a2d5-263d8407e0f9', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '{}'),
	('300a0085-3859-45e8-9853-35dd55622f1c', 'dokumentasi-event', 'event_2/0.5642004671239137.jpg', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-08 12:10:02.521031+00', '2026-07-08 12:10:02.521031+00', '2026-07-08 12:10:02.521031+00', '{"eTag": "\"39c44119dab67871002cd2bf1b46d477\"", "size": 178581, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-08T12:10:03.000Z", "contentLength": 178581, "httpStatusCode": 200}', '56fab4a9-217d-4798-bb35-405cd62cd008', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '{}'),
	('c83cc2ea-f678-47a9-8462-ea285e686af8', 'dokumentasi-event', 'event_10/0.4168417765289183.jpg', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '2026-07-11 20:54:52.336095+00', '2026-07-11 20:54:52.336095+00', '2026-07-11 20:54:52.336095+00', '{"eTag": "\"ebc1034d9cf65f645a79cbec93995acc\"", "size": 18029, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-11T20:54:53.000Z", "contentLength": 18029, "httpStatusCode": 200}', '2b618a19-b265-4dec-8f6e-dc389781887c', 'dd4792af-61c7-46c6-b142-dac0fbf87083', '{}'),
	('f3755bc6-df6f-4700-b72c-d07cf0c36270', 'dokumentasi-event', 'events/0.5378954093741212.jpeg', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '2026-07-12 14:42:25.300483+00', '2026-07-12 14:42:25.300483+00', '2026-07-12 14:42:25.300483+00', '{"eTag": "\"deba215be39fe1ec4fa84b04efb96a3c\"", "size": 25702, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-12T14:42:26.000Z", "contentLength": 25702, "httpStatusCode": 200}', 'dc6ae25d-b41c-42f2-b28f-f32dcbec53c8', '059b7fe5-6da6-4aff-a175-72828e2bdd0d', '{}'),
	('3b1adcc4-5076-4f4a-adfc-f1f8efff12ef', 'avatars', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2_1783868827570.jpg', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '2026-07-12 15:07:07.919983+00', '2026-07-12 15:07:07.919983+00', '2026-07-12 15:07:07.919983+00', '{"eTag": "\"335ee161871a434785ad41bb92a420d1\"", "size": 70367, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-12T15:07:08.000Z", "contentLength": 70367, "httpStatusCode": 200}', 'dcd21ad0-cbc2-4530-afc8-1b4efee1173e', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '{}'),
	('554d26cb-abbb-4ff7-b817-c8bfd79a00c2', 'dokumentasi-event', 'event_15/0.8187709958463014.jpg', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '2026-07-12 15:10:36.652935+00', '2026-07-12 15:10:36.652935+00', '2026-07-12 15:10:36.652935+00', '{"eTag": "\"813b79c0eaac045157d6dea991d4053d\"", "size": 80667, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-12T15:10:37.000Z", "contentLength": 80667, "httpStatusCode": 200}', 'ee00b285-7aa3-4fba-8106-d0b4a670b08a', '6f4fea43-77ac-4f57-a257-e5cd1b0329f2', '{}'),
	('c8c5c280-94d4-4f73-a33d-591f2c5853f3', 'avatars', 'edce8c3d-a716-47e9-bd61-2b2dfdf72059_1783901446213.jpg', 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', '2026-07-13 00:10:46.526107+00', '2026-07-13 00:10:46.526107+00', '2026-07-13 00:10:46.526107+00', '{"eTag": "\"d2d83fc13a6bad32acc489f74324321c\"", "size": 340326, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-13T00:10:47.000Z", "contentLength": 340326, "httpStatusCode": 200}', 'a0689eab-e886-42b3-a4d7-a827e3639720', 'edce8c3d-a716-47e9-bd61-2b2dfdf72059', '{}'),
	('ad526731-656e-4fa5-a19d-b3105d4d6523', 'dokumentasi-event', 'event_15/0.9714952118950696.jpg', 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', '2026-07-13 08:27:20.355593+00', '2026-07-13 08:27:20.355593+00', '2026-07-13 08:27:20.355593+00', '{"eTag": "\"b181a648827229bdc7681bcf35e54d8f\"", "size": 47700, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2026-07-13T08:27:21.000Z", "contentLength": 47700, "httpStatusCode": 200}', '4702ea22-5c3a-4ac1-85ad-771846983f61', 'cbab0558-6b06-4304-a935-42b5f6ea2ec9', '{}');


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 256, true);


--
-- Name: divisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."divisi_id_seq"', 7, true);


--
-- Name: dokumentasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."dokumentasi_id_seq"', 18, true);


--
-- Name: event_kategori_mapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."event_kategori_mapping_id_seq"', 29, true);


--
-- Name: event_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."event_links_id_seq"', 6, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."events_id_seq"', 17, true);


--
-- Name: kategori_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."kategori_event_id_seq"', 15, true);


--
-- Name: lokasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."lokasi_id_seq"', 4, true);


--
-- Name: notifikasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."notifikasi_id_seq"', 8, true);


--
-- Name: penerima_notifikasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."penerima_notifikasi_id_seq"', 21, true);


--
-- Name: tugas_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."tugas_assignments_id_seq"', 83, true);


--
-- Name: tugas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."tugas_id_seq"', 19, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict MY3SQftKiCuJXoRSdEf0abgb08TI989abNVI0K1Reu5o44fy2Ja9AQycigJbgo7

RESET ALL;
