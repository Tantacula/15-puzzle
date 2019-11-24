<template>
  <div class="AppContainer">
    <div
      v-if="displayStartingMessage || displayFinishMessage"
      class="GameMessages"
    >
      <div
        v-if="displayStartingMessage"
        class="GameMessages__intro"
      >
        <img class="GameMessages__image" src="/images/bg-start.jpg">
        <div class="GameMessages__textContainer">
          <p>
            Помнишь, в прошлом году ты нашел баг в своем коде, но вместо исправления залил его в продакшен, чтобы
            поскорее уйти домой? А когда клиент обнаружил его, ты сказал, что это вовсе и не баг, а фича и потребовал
            денег за внесение исправлений.
          </p>
          <p>
            Я вижу ты очень ценишь время и предлагаю тебе сыграть со мной в игру. Сегодня на дверь офисного туалета
            поставили новый кодовый замок, номер от которого скрыт в игре. А еще в твой кофе было подмешано
            сильнодействующее слабительное, которое сработает через 5 минут. Если победишь - узнаешь ключ к туалету, а
            если нет - дурно пахнуть будет не только твой код. Игра началать >:)
          </p>
        </div>

        <button
          class="GameMessages__button GameButton"
          @click="displayStartingMessage = false"
        >
          Нет же, не началась! Начать скорее
        </button>
      </div>
      <div
        v-if="displayFinishMessage"
        class="GameMessages__victory"
      >
        <div class="GameMessages__textContainer">
          <p>
            {{ decodeMessage(victoryMessage) }}
          </p>
        </div>

        <button
          class="GameMessages__button GameButton"
          @click="displayFinishMessage = false"
        >
          Сыграть еще разок
        </button>
      </div>
    </div>
    <div
      v-else
      class="GameContainer"
    >
      <GameMain @game-was-won="displayFinishMessage = true" />
    </div>
  </div>
</template>

<script>
import GameMain from '~/components/GameMain.vue'

// Cообщение, которое можно увидеть, если пройти игру. Просто защита от спойлеров, не более того :) Вдруг ты один из тех, кто решит поиграть в очередные тестовые пятнашки ради этого.
const victoryMessage = '%D0%A8%D1%82%D0%BE%D1%88,%20%D1%82%D1%8B%20%D0%BF%D0%BE%D0%B1%D0%B5%D0%B4%D0%B8%D0%BB%20%D0%B8%20%D1%8D%D1%82%D0%BE%20%D0%B3%D0%BE%D0%B2%D0%BE%D1%80%D0%B8%D1%82%20%D0%BE%20%D1%82%D0%BE%D0%BC,%20%D1%87%D1%82%D0%BE%20%D1%82%D1%8B%20%D0%B4%D0%BE%D1%81%D1%82%D0%B0%D1%82%D0%BE%D1%87%D0%BD%D0%BE%20%D1%83%D0%BC%D0%B5%D0%BD.%20%D0%9D%D0%BE%20%D0%B5%D1%81%D0%BB%D0%B8%20%D1%82%D1%8B%20%D0%B8%D0%B3%D1%80%D0%B0%D0%BB%20%D1%80%D0%B0%D0%B4%D0%B8%20%D0%BA%D0%BE%D0%B4%D0%B0,%20%D1%8D%D1%82%D0%BE%20%D0%B3%D0%BE%D0%B2%D0%BE%D1%80%D0%B8%D1%82%20%D0%BE%20%D1%82%D0%BE%D0%BC,%20%D1%87%D1%82%D0%BE%20%D1%82%D1%8B%20%D0%BD%D0%B5%20%D0%BE%D1%87%D0%B5%D0%BD%D1%8C%20%D0%BD%D0%B0%D0%B1%D0%BB%D1%8E%D0%B4%D0%B0%D1%82%D0%B5%D0%BB%D0%B5%D0%BD,%20%D0%B8%D0%BD%D0%B0%D1%87%D0%B5%20%D1%82%D1%8B%20%D0%B1%D1%8B%20%D0%B7%D0%B0%D0%BC%D0%B5%D1%82%D0%B8%D0%BB,%20%D1%87%D1%82%D0%BE%20%D0%BD%D0%B8%D0%BA%D0%B0%D0%BA%D0%BE%D0%B3%D0%BE%20%D0%B7%D0%B0%D0%BC%D0%BA%D0%B0%20%D0%BD%D0%B0%20%D0%B4%D0%B2%D0%B5%D1%80%D1%8F%D1%85%20%D1%82%D1%83%D0%B0%D0%BB%D0%B5%D1%82%D0%B0%20%D0%BD%D0%B8%D0%BA%D1%82%D0%BE%20%D0%BD%D0%B5%20%D1%81%D1%82%D0%B0%D0%B2%D0%B8%D0%BB.%20%D0%9F%D0%BE%D1%80%D0%B0%D0%B6%D0%B0%D1%8E%D1%81%D1%8C%20%D1%82%D0%BE%D0%BC%D1%83,%20%D0%BA%D0%B0%D0%BA%20%D0%B4%D0%BE%D0%B2%D0%B5%D1%80%D1%87%D0%B8%D0%B2%D1%8B%20%D0%BB%D1%8E%D0%B4%D0%B8.'

export default {
  components: {
    GameMain,
  },

  data: () => ({
    displayStartingMessage: true,
    displayFinishMessage: false,
    victoryMessage,
  }),

  methods: {
    decodeMessage (msg) {
      return decodeURI(msg)
    },
  },
}
</script>

<style lang="scss">
  @import '~assets/styles/app';

  .AppContainer {
    margin: 0 auto;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 15px 0;

    @media screen and (min-width: 800px) {
      justify-content: left;
    }
  }

  .GameContainer {
    width: 25%;
    min-width: 300px;

    @media screen and (min-width: 800px) {
      margin-left: 20%;
    }
  }

  .GameMessages {
    width: 30%;
    min-width: 300px;

    font-family: $fontSecondary;
    font-size: $fontSizeBase;
    background-color: $bgColorPrimary;

    &__textContainer {
      padding: 15px;
    }

    @media screen and (min-width: 800px) {
      margin: 0 10%;
    }

    &__image {
      width: 100%;
      object-fit: cover;
    }

    &__button {
      display: block;
      width: 100%;
    }
  }
</style>
