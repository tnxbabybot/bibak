------------------------
-- In The Name Of GoD --
-- Satring Panel.lua  --
--      By Bibak      --
------------------------
local URL = require "socket.url"
local https = require "ssl.https"
local serpent = require "serpent"
local json = (loadfile "Data/JSON.lua")()
local token = '488610809:AAE8ytWMCQZxy8-0YKIuyUds5oPwoBhevYM' --token
local url = 'https://api.telegram.org/bot' .. token
local offset = 0
local redis = require('redis')
local redis = redis.connect('127.0.0.1', 6379)
local botcli = 451274866
local SUDO = 304933903
local BOT = 1
function is_mod(chat,user)
sudo = {}
  local var = false 
  for v,_user in pairs(sudo) do
    if _user == user then
      var = true
    end
  end
  local hash = redis:sismember('bibak'..BOT..'mod', user)
 if hash then
 var = true
 end
  local hash = redis:sismember('bibak'..BOT..'admin', user)
 if hash then
 var = true
 end
 return var
 end
local function getUpdates()
  local response = {}
  local success, code, headers, status  = https.request{
    url = url .. '/getUpdates?timeout=20&limit=1&offset=' .. offset,
    method = "POST",
    sink = ltn12.sink.table(response),
  }

  local body = table.concat(response or {"no response"})
  if (success == 1) then
    return json:decode(body)
  else
    return nil, "Request Error"
  end
end

function vardump(value)
  print(serpent.block(value, {comment=false}))
end

function sendmsg(chat,text,keyboard)
if keyboard then
urlk = url .. '/sendMessage?chat_id=' ..chat.. '&text='..URL.escape(text)..'&parse_mode=html&reply_markup='..URL.escape(json:encode(keyboard))
else
urlk = url .. '/sendMessage?chat_id=' ..chat.. '&text=' ..URL.escape(text)..'&parse_mode=html'
end
https.request(urlk)
end
 function edit( message_id, text, keyboard)
  local urlk = url .. '/editMessageText?&inline_message_id='..message_id..'&text=' .. URL.escape(text)
    urlk = urlk .. '&parse_mode=Markdown'
  if keyboard then
    urlk = urlk..'&reply_markup='..URL.escape(json:encode(keyboard))
  end
    return https.request(urlk)
  end
function Canswer(callback_query_id, text, show_alert)
	local urlk = url .. '/answerCallbackQuery?callback_query_id=' .. callback_query_id .. '&text=' .. URL.escape(text)
	if show_alert then
		urlk = urlk..'&show_alert=true'
	end
  https.request(urlk)
	end
  function answer(inline_query_id, query_id , title , description , text , keyboard)
  local results = {{}}
         results[1].id = query_id
         results[1].type = 'article'
         results[1].description = description
         results[1].title = title
         results[1].message_text = text
  urlk = url .. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(json:encode(results))..'&parse_mode=Markdown&cache_time=' .. 1
  if keyboard then
   results[1].reply_markup = keyboard
  urlk = url .. '/answerInlineQuery?inline_query_id=' .. inline_query_id ..'&results=' .. URL.escape(json:encode(results))..'&parse_mode=Markdown&cache_time=' .. 1
  end
    https.request(urlk)
  end
function fwd(chat_id, from_chat_id, message_id)
  local urlk = url.. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id
  local res, code, desc = https.request(urlk)
  if not res and code then --if the request failed and a code is returned (not 403 and 429)
  end
  return res, code
end
function sleep(n)
os.execute("sleep " .. tonumber(n))
end
local day = 86400
local function run()
  while true do
    local updates = getUpdates()
    vardump(updates)
    if(updates) then
      if (updates.result) then
        for i=1, #updates.result do
          local msg = updates.result[i]
          offset = msg.update_id + 1
          if msg.inline_query then
            local q = msg.inline_query
						if q.from.id == botcli or q.from.id == SUDO then
            if q.query:match('%d+') then
              local chat = '-'..q.query:match('%d+')
							local function is_lock(chat,value)
 if redis:hget(SUDO.."gps:settings:"..chat,"lock"..value.."settings") then
    return true
    else
    return false
    end
  end
--------Main Menu-------#Bibak
local name = redis:get("bibak"..BOT.."fname")
     local userid = redis:get("bibak"..BOT.."id")
     local phone = redis:get("bibak"..BOT.."num")
---‌‌----
              local keyboard = {}
							keyboard.inline_keyboard = {
								{
				{text = '⌯ آمار ⌯', callback_data = 'asdfdsa:'..chat},{text = '⌯ وضعیت ⌯', callback_data = 'wedjsa:'..chat}
				},{
				{text = '⌯ تنظیمات ⌯', callback_data = 'setting:'..chat}
		     	},{
		     	{text = '⌯ راهنما ⌯', callback_data = 'help:'..chat}
		     	},{
                {text = '○ خروج', callback_data = 'close:'..chat}
				}
				}
            answer(q.id,'panel','Group settings',chat,'» Bot Name : '..tostring(name)..'\n» Bot UserID : '..tostring(userid)..'\n» Bot Phone : +'..tostring(phone)..'',keyboard)
            end
            end
						end
          if msg.callback_query then
            local q = msg.callback_query
						local chat = ('-'..q.data:match('(%d+)') or '')
						if is_mod(chat,q.from.id) then
             if q.data:match('_') and not (q.data:match('menu')) then
                Canswer(q.id,"#Bibak :D",true)
					elseif q.data:match('lock') then
							local lock = q.data:match('lock (.*)')			
				TIME_MAX = (redis:hget(SUDO.."gps:settings:"..chat,"floodtime") or 2)
              MSG_MAX = (redis:hget(SUDO.."gps:settings:"..chat,"floodmax") or 5)
			                WARN_MAX = (redis:hget("warn:settings:"..chat,"warnmax") or 3)
							local result = settings(chat,lock)
							if lock == 'contacting' or lock == 'savelink' or lock == 'markread' then
							q.data = 'tabsettings:'..chat
								end
							Canswer(q.id,result)
							end
--------Back To Main Menu-------#Bibak---------------
							if q.data:match('firstmenu') then
							local chat = '-'..q.data:match('(%d+)$')
local name = redis:get("bibak"..BOT.."fname")
     local userid = redis:get("bibak"..BOT.."id")
     local phone = redis:get("bibak"..BOT.."num")
----
							local function is_lock(chat,value)
 if redis:hget(SUDO.."gps:settings:"..chat,"lock"..value.."settings") then
    return true
    else
    return false
    end
  end
                local keyboard = {}
							keyboard.inline_keyboard = {
								{
				{text = '⌯ آمار ⌯', callback_data = 'asdfdsa:'..chat},{text = '⌯ وضعیت ⌯', callback_data = 'wedjsa:'..chat}
							},{
				{text = '⌯ تنظیمات ⌯', callback_data = 'setting:'..chat}
							},{
							{text = '⌯ راهنما ⌯', callback_data = 'help:'..chat}
							},{
                {text = '○ خروج', callback_data = 'close:'..chat}
							}
							}
            edit(q.inline_message_id,'*» Bot Name :* `'..tostring(name)..'`\n*» Bot UserID :* `'..tostring(userid)..'`\n*» Bot Phone :* `+'..tostring(phone)..'`',keyboard)
            end
--------Close-------#Bibak
						if q.data:match('close') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = 'BG TeaM ⇜', url = 'https://t.me/bg_team'}
				}
							}
              edit(q.inline_message_id,'▪️ انجام شد \n▪️ پنل با موفقیت بسته شد !',keyboard)
            end
--------Help-------#Bibak
			if q.data:match('help') then
                           local chat = '-'..q.data:match('(%d+)$')
		                    local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '> Back', callback_data = 'firstmenu:'..chat}
				}
							}
             local text = '•[⇩راهنمای دستورات⇩]•\n➖➖➖➖➖➖\n• modset USERID\n• افزودن ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• moddem USERID\n• حذف ادمین\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• link list\n• دریافت لیست لینک های ربات\n➖➖➖➖➖➖\n• fwd users\n• فروارد پیام به کاربران (با ریپلی)\n➖➖➖➖➖➖\n• fwd groups\n• فروارد پیام به گروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd sgroups\n• فروارد پیام به سوپرگروه ها (با ریپلی)\n➖➖➖➖➖➖\n• fwd all\n• فروارد پیام به همه (کاربران،گروه ها،سوپرگروه ها)،(با ریپلی)\n➖➖➖➖➖➖\n• on\n• اطلاع از آنلاین بودن ربات\n➖➖➖➖➖➖\n• addall USERID\n• افزودن کاربر مورد نظر به تمامیه گروه ها\n••• به جای USERID آیدی عددی کاربر مورد نظر را قرار دهید .\n\n➖➖➖➖➖➖\n• reload stats\n• ریست کردن امار ربات\n➖➖➖➖➖➖\n• reload bot\n• بروز کردن مشخصات ربات\n➖➖➖➖➖➖\n• share\n• دریافت شماره ربات\n➖➖➖➖➖➖\n• echo TEXT\n• تکرار کردن متن\n••• به جای TEXT متن مورد نظر را قرار دهید .\n➖➖➖➖➖➖\n• leave\n•• لفت دادن تبچی از یک گروه\n\n• leave groups\n•• لفت دادن تبچی از کل گروه ها\n\n• leave supergroups\n•• لفت دادن تبچی از کل سوپرگروه ها\n➖➖➖➖➖➖\n▪ از انتشار این سورس به هیچ وجه راضی نمیباشیم ...\n▪▪ نوشته شده توسط :\n▪▪ [Bibak](https://t.me/bannedbylife)\n▪▪▪ کانال :\n▪▪▪ [BG TeaM](https://t.me/BG_TeaM)'
 edit(q.inline_message_id,""..text.."",keyboard)
            end
--------Info-------#Bibak
								if q.data:match('wedjsa') then
------#Locals-------
                           local chat = '-'..q.data:match('(%d+)$')
---
local offjoin = redis:get("bibak"..BOT.."offjoin") and "غیرفعال️" or "فعال️"
---
local offlink = redis:get("bibak"..BOT.."offlink") and "غیرفعال️" or "فعال️"
---
local nlink = redis:get("bibak"..BOT.."link") and "فعال️" or "غیرفعال️"
---
local numadd = 	redis:get("bibak"..BOT.."markread") and "فعال️" or "غیرفعال️"
---
local forcejoin = redis:get("bibak"..BOT.."forcejoin") and "فعال️" or "غیرفعال️"
------#End--Locals-------
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = ''..tostring(offjoin)..'', callback_data = 'asdf:'..chat},{text = '⇜عضویت خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(offlink)..'', callback_data = 'aksldsnf:'..chat},{text = '⇜تایید لینک خودکار :', callback_data = 'asmnd:'..chat}
				},{
				{text = ''..tostring(nlink)..'', callback_data = 'fqwe:'..chat},{text = '⇜تشخیص لینک های عضویت :', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(numadd)..'', callback_data = 'asdf:'..chat},{text = '⇜خواندن پیام ها(تیک دوم) :', callback_data = 'asmnd:'..chat}
				},{
 {text = ''..tostring(forcejoin)..'', callback_data = 'asdf:'..chat},{text = '⇜عضویت اجباری :', callback_data = 'asmnd:'..chat}
},{
	{text = '« صفحه بعد', callback_data = 'nextpage:'..chat}
				},{
				{text = 'برگشت »', callback_data = 'firstmenu:'..chat}
							}
							}
              edit(q.inline_message_id, 'Ｓｔａｔｕｓ（Ｂｏｔ１）',keyboard)
            end		
-----------------------#MaMaDKRL-----------------
			if q.data:match('nextpage') then
------#Locals-------
                           local chat = '-'..q.data:match('(%d+)$')
---
local links = redis:scard("bibak"..BOT.."savedlinks")
---
local glinks = redis:scard("bibak"..BOT.."goodlinks")
---
local wlinks = redis:scard("bibak"..BOT.."waitelinks")
---
local ss = redis:get("bibak"..BOT.."offlink") and 0 or redis:get("bibak"..BOT.."maxlink") and redis:ttl("bibak"..BOT.."maxlink") or 0
---
local s =  redis:get("bibak"..BOT.."offjoin") and 0 or redis:get("bibak"..BOT.."maxjoin") and redis:ttl("bibak"..BOT.."maxjoin") or 0
------#End--Locals-------
local keyboard = {}
							keyboard.inline_keyboard = {
								{
				},{
			{text = ''..tostring(links)..'', callback_data = 'asmnd:'..chat},{text = '⇜لینک های ذخیره شده :', callback_data = 'sdf:'..chat},
				},{
				{text = ''..tostring(glinks)..'', callback_data = 'fiasd:'..chat},{text = '⇜لینک های در انتظار عضویت :', callback_data = 'asmnd:'..chat}
},{
	{text = ''..tostring(s)..'', callback_data = 'asmnd:'..chat},{text = '⇜ثانیه تا عضویت مجدد :', callback_data = 'asmnd:'..chat}
				},{
				 {text = ''..tostring(wlinks)..'', callback_data = 'asdf:'..chat},{text = '⇜لینک های در انتظار تایید :', callback_data = 'asmnd:'..chat}
				},{
{text = ''..tostring(ss)..'', callback_data = 'asmnd:'..chat},{text = '⇜ثانیه تا تایید لینک مجدد :', callback_data = 'asdf:'..chat}
},{
{text = 'صفحه قبل »', callback_data = 'wedjsa:'..chat}
							}
							}
              edit(q.inline_message_id, 'Ｓｔａｔｕｓ（Ｂｏｔ１）',keyboard)
            end
--------Stats-------#Bibak
							if q.data:match('asdfdsa') then
------#Locals-------
                           local chat = '-'..q.data:match('(%d+)$')
						  local gps = redis:scard("bibak"..BOT.."groups")
					local sgps = redis:scard("bibak"..BOT.."supergroups")
					local usrs = redis:scard("bibak"..BOT.."users")
					local links = redis:scard("bibak"..BOT.."savedlinks")
					local glinks = redis:scard("bibak"..BOT.."goodlinks")
					local wlinks = redis:scard("bibak"..BOT.."waitelinks")	
------#End--Locals-------
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
{text = ''..tostring(gps)..'', callback_data = 'asmnd:'..chat},{text = '⇜ گروه ها :', callback_data = 'asdf:'..chat}
				},{
{text = ''..tostring(sgps)..'', callback_data = 'asmnd:'..chat},{text = '⇜ سوپر گروه ها :', callback_data = 'aksldsnf:'..chat}
				},{
{text = ''..tostring(usrs)..'', callback_data = 'asmnd:'..chat},{text = '⇜پیوی ها :', callback_data = 'fqwe:'..chat}
				},{
{text = ''..tostring(links)..'', callback_data = 'asmnd:'..chat},{text = '⇜لینک ها :', callback_data = 'fiasd:'..chat}
				},{
				{text = 'برگشت »', callback_data = 'firstmenu:'..chat}
							}
							}
              edit(q.inline_message_id, 'Ｓｔａｔｓ（Ｂｏｔ１）',keyboard)
            end	
----------------------
-- Starting Setting --
--     By Bibak     --
----------------------
			if q.data:match('setting') then
                           local chat = '-'..q.data:match('(%d+)$')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '⌯ عضویت خودکار ⌯', callback_data = 'autojoin:'..chat}
				},{
				{text = '⌯ تایید لینک خودکار ⌯', callback_data = 'truelink:'..chat}
},{
{text = '⌯ تشخیص لینک های عضویت ⌯', callback_data = 'relink:'..chat}
				},{
					{text = '⌯ خواندن پیام ها (تیک دوم) ⌯', callback_data = 'markread:'..chat}
},{
{text = '⌯ عضویت اجباری ⌯', callback_data = 'forcejoin:'..chat}
				},{
				{text = 'برگشت »', callback_data = 'firstmenu:'..chat}
							}
							}
              edit(q.inline_message_id, 'Ｓｅｔｔｉｎｇｓ（Ｂｏｔ１）',keyboard)
            end			
--AutoJoin
							if q.data:match('autojoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		local bibak = redis:get("bibak"..BOT.."offjoin")
		if bibak then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onautojoinnn:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'alksjdfdkslaksjd:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('onautojoinnn') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del("bibak"..BOT.."maxjoin")
		redis:del("bibak"..BOT.."offjoin")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'alksjdfdkslaksjd:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('alksjdfdkslaksjd') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:set("bibak"..BOT.."maxjoin", true)
		redis:set("bibak"..BOT.."offjoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onautojoinnn:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--TrueLink
						if q.data:match('truelink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local bibak = redis:get("bibak"..BOT.."offlink")
		if bibak then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'ontruelinkkk:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiistruelink:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تایید لینک خودکار]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('ontruelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
		redis:del("bibak"..BOT.."maxlink")
						redis:del("bibak"..BOT.."offlink")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiistruelink:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiistruelink') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set("bibak"..BOT.."maxlink", true)
						redis:set("bibak"..BOT.."offlink", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'ontruelinkkk:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تایید لینک خودکار]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ReLink
						if q.data:match('relink') then
                           local chat = '-'..q.data:match('(%d+)$')
		local bibak = redis:get("bibak"..BOT.."link")
		if not bibak then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onreeelinkkk:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisreeelink:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تشخیص لینک های عضویت]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('onreeelinkkk') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:set("bibak"..BOT.."link", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'diiisreeelink:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('diiisreeelink') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del("bibak"..BOT.."link")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'onreeelinkkk:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تشخیص لینک های عضویت]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end	
--MarkRead
						if q.data:match('markread') then
                           local chat = '-'..q.data:match('(%d+)$')
		local bibak = 	redis:get("bibak"..BOT.."markread")
			
		if not bibak then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'markreadonnn:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'markreadoff:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[تیک دوم پیام ها]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('markreadonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set("bibak"..BOT.."markread", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'markreadoff:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('markreadoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del("bibak"..BOT.."markread")
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'markreadonnn:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[تیک دوم پیام ها]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
--ForceJoin
						if q.data:match('forcejoin') then
                           local chat = '-'..q.data:match('(%d+)$')
		local bibak = redis:get('bibak'..BOT..'forcejoin')
			
		if not bibak then
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'forcejoinonnn:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• غیر فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
			  else
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'forcejoinoff:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id,'`[عضویت اجباری]`\nدرحال حاظر `• فعال •` است.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end
			end
----
							if q.data:match('forcejoinonnn') then
                           local chat = '-'..q.data:match('(%d+)$')
				redis:set("bibak"..BOT.."forcejoin", true)
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• غیر فعال کردن', callback_data = 'forcejoinoff:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
----
			if q.data:match('forcejoinoff') then
                           local chat = '-'..q.data:match('(%d+)$')
			redis:del('bibak'..BOT..'forcejoin')
		local keyboard = {}
							keyboard.inline_keyboard = {
								{
                   {text = '• فعال کردن', callback_data = 'forcejoinonnn:'..chat}
},{
		{text = 'برگشت »', callback_data = 'setting:'..chat}
				}
							}
              edit(q.inline_message_id, '`[عضویت اجباری]`\n`• غیر فعال •` شد.\n⇩⇩ انتخاب کنید ⇩⇩',keyboard)
            end		
-------------------
-- End Setting   --
--   By Bibak    --
-------------------
			else Canswer(q.id,'» شما دسترسی را ندارید !',true)
						end
						end
          if msg.message and msg.message.date > (os.time() - 5) and msg.message.text then
		  	 local m = msg.message
      if m.text == "/start" then
    local keyboard = {}
    keyboard.inline_keyboard = {
         {
				 {text = '• کانال ما', url = 'https://t.me/BG_TeaM'}
                },{
                   {text = '• نویسنده سورس', url = 'https://t.me/aa_Bibak'}
				   }
							}
        sendmsg(m.chat.id, "• هلپر هم اکون انلاین میباشد !", keyboard, true)
      end
   end
      end
    end
  end
    end
	end 

return run()					
-------------------
-- End Panel.lua --
--   By Bibak    --
-------------------
