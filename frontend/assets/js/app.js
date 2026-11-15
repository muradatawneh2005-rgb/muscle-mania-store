// Language switch (FR-07) and product list from the API (FR-04/FR-05). The API answers 501 until Sprint 2.
const API = '/api/v1';
const html = document.documentElement;
function setLang(lang) {
  html.lang = lang; html.dir = lang === 'ar' ? 'rtl' : 'ltr';
  document.querySelectorAll('[data-ar]').forEach(el => { el.textContent = el.dataset[lang]; });
  document.querySelectorAll('[data-ph-ar]').forEach(el => { el.placeholder = lang === 'ar' ? el.dataset.phAr : el.dataset.phEn; });
  document.getElementById('langBtn').textContent = lang === 'ar' ? 'English' : 'العربية';
  localStorage.setItem('lang', lang);
}
document.getElementById('langBtn').addEventListener('click', () => setLang(html.lang === 'ar' ? 'en' : 'ar'));
setLang(localStorage.getItem('lang') || 'ar');

fetch(API + '/products?page=1').then(r => r.ok ? r.json() : { items: [] }).then(({ items }) => {
  const box = document.getElementById('products');
  for (const p of items) {
    const card = document.createElement('article');
    const name = document.createElement('h3');
    name.textContent = html.lang === 'ar' ? p.name_ar : p.name_en;   // textContent, never innerHTML: no XSS from data
    card.append(name);
    box.append(card);
  }
}).catch(() => {});
